test_that("merge_cff combines DESCRIPTION fixtures with CITATION", {
  rvers <- getRversion()
  skip_if(!grepl("^4.6", rvers), "Snapshot created with R 4.6.*")
  skip_on_cran()

  allfiles <- list.files(
    system.file("examples", package = "cffr"),
    pattern = "^DESC",
    full.names = TRUE
  )

  citpath <- system.file("examples/CITATION_basic", package = "cffr")
  merged_cffs <- setNames(vector("list", length(allfiles)), basename(allfiles))
  for (file in allfiles) {
    fixture <- basename(file)
    desc_cff <- cff_read_description(file, gh_keywords = FALSE)
    generate_cit <- cff_safe_read_citation(file, citpath)
    merged <- merge_desc_cit(desc_cff, generate_cit)
    merged <- as_cff(merged)

    expect_true(cff_validate(merged, verbose = FALSE), info = fixture)
    merged_cffs[[fixture]] <- merged
  }

  expect_snapshot(merged_cffs)
})

test_that("citation merging retains one copy of each identifier", {
  cran_doi <- "10.32614/CRAN.package.example"
  other_doi <- "10.1234/example"
  desc_cff <- as_cff(list(doi = cran_doi))
  citation_cff <- as_cff(list(list(
    type = "generic",
    title = "Example package",
    doi = "10.5678/example",
    identifiers = list(
      list(type = "doi", value = cran_doi),
      list(type = "doi", value = other_doi)
    )
  )))

  merged <- merge_desc_cit(desc_cff, citation_cff)
  identifier_values <- vapply(merged$identifiers, `[[`, character(1), "value")

  expect_identical(identifier_values, c(cran_doi, other_doi))
})

test_that("get_dependencies preserves package citation metadata", {
  skip_on_cran()
  desc_path <- system.file("DESCRIPTION", package = "cffr")
  dep_rows <- desc::desc(desc_path)$get_deps()
  dep_rows <- cff_dependency_rows(dep_rows)
  installed <- as.character(installed.packages()[, "Package"])
  dep_rows <- dep_rows[dep_rows$package %in% c("R", installed), ]

  actual <- get_dependencies(desc_path)
  actual <- lapply(actual, \(x) drop_null(x[c("title", "abstract", "year")]))

  expected <- lapply(dep_rows$package, function(package) {
    raw_citation <- if (package == "R") {
      utils::citation()
    } else {
      utils::citation(package, auto = TRUE)[1]
    }
    citation_cff <- as_cff(raw_citation)[[1]]

    date_released <- citation_cff[["date-released"]]
    if (!is.null(date_released)) {
      citation_cff$year <- format(as.Date(date_released), "%Y")
    }

    drop_null(citation_cff[c("title", "abstract", "year")])
  })

  expect_setequal(unique(actual), unique(expected))
})

test_that("merge_cff resolves conflicting DESCRIPTION and CITATION URLs", {
  rvers <- getRversion()
  skip_if(!grepl("^4.6", rvers), "Snapshot created with R 4.6.*")
  skip_on_cran()

  dd <- list.files(
    system.file("examples", package = "cffr"),
    pattern = "wrong",
    full.names = TRUE
  )

  citpath <- system.file("examples/CITATION_dx_doi", package = "cffr")
  desc_cff <- cff_read_description(dd, gh_keywords = FALSE)
  generate_cit <- cff_safe_read_citation(dd, citpath)
  merged <- merge_desc_cit(desc_cff, generate_cit)
  merged <- as_cff(merged)

  expect_true(cff_validate(merged, verbose = FALSE))
  expect_identical(
    paste0("https://dx.doi.org/", merged$doi),
    merged[["preferred-citation"]]$url
  )
})

test_that("cff_dependency_rows normalizes versions and dependency scopes", {
  deps <- data.frame(
    package = c("foo", "foo", "bar"),
    version = c("*", "1.0", "2.0"),
    type = c("Imports", "Suggests", "Depends")
  )
  rows <- cff_dependency_rows(deps)

  expect_equal(rows$package, c("foo", "foo", "bar"))
  expect_equal(rows$version_clean, c("", "1.0", "2.0"))
  expect_equal(rows$scope, c("Imports", "Imports", "Depends"))
})

test_that("cff_dependency_year extracts years from supported dates", {
  mod <- list(`date-released` = "1995-02-01", year = "1990")
  expect_identical(cff_dependency_year(mod), "1995")

  mod2 <- list(`date-released` = "1904/12/30")
  expect_identical(cff_dependency_year(mod2), "1904")

  expect_identical(cff_dependency_year(list(year = "1999")), "1999")
  expect_null(cff_dependency_year(list()))
})

test_that("is_cran_dependency checks the package repository", {
  avail <- data.frame(
    Package = c("foo", "bar", "stats"),
    Repository = c(
      "https://cloud.r-project.org/src/contrib",
      "https://fixture.r-universe.dev/src/contrib",
      "https://cloud.r-project.org/src/contrib"
    )
  )
  withr::local_options(
    cffr.available_packages = avail,
    cffr.repos = c(
      fixture = "https://fixture.r-universe.dev",
      CRAN = "https://cloud.r-project.org/"
    )
  )

  result <- vapply(
    c("foo", "bar", "stats", "unknown"),
    is_cran_dependency,
    logical(1)
  )
  expect_identical(unname(result), c(TRUE, FALSE, FALSE, FALSE))
})

test_that("dependency citations preserve source metadata", {
  local_mocked_bindings(
    cff_citation = function(...) {
      bibentry(
        bibtype = "Manual",
        title = "Original dependency title",
        author = person("Jane", "Doe"),
        year = "1999"
      )
    },
    is_cran_dependency = function(package) FALSE
  )

  dependency <- cff_dependency_citation("example")
  r_dependency <- cff_dependency_citation("R")

  expect_identical(dependency$title, "Original dependency title")
  expect_null(dependency$abstract)
  expect_identical(r_dependency$year, "1999")
})

test_that("dependency references preserve citation years", {
  rvers <- getRversion()
  skip_if(!grepl("^4.6", rvers), "Snapshot created with R 4.6.*")

  local_mocked_bindings(
    cff_dependency_citation = function(package) {
      list(title = "Dependency title", year = "1999")
    },
    cff_dependency_desc_fields = function(mod, package) mod
  )

  result <- cff_dependency_reference(list(
    package = "example",
    version_clean = "1.0",
    scope = "Imports"
  ))

  expect_snapshot(result)
})

test_that("cff_dependency_order uses canonical field order", {
  ordered <- drop_null(cff_dependency_order(list(
    year = "2025",
    repository = "https://example.org/repo",
    title = "foo",
    type = "software"
  )))
  expect_named(ordered, c("type", "title", "repository", "year"))
})

test_that("cff_dependency_reference returns NULL for unavailable packages", {
  dep <- list(package = "aaaa")
  expect_null(cff_dependency_reference(dep))
})

test_that("get_dependencies rejects invalid DESCRIPTION inputs", {
  expect_null(get_dependencies(1))
  expect_null(get_dependencies(withr::local_tempfile()))
})

test_that("dependency citation returns NULL when citation cannot be read", {
  local_mocked_bindings(cff_citation = function(...) {
    stop("no citation", call. = FALSE)
  })

  expect_null(cff_dependency_citation("foo"))
  expect_null(cff_dependency_reference(list(
    package = "foo",
    version_clean = "",
    scope = "Imports"
  )))
})
