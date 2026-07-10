test_that("Merge all DESCRIPTION files with CITATION_basic", {
  rvers <- getRversion()
  skip_if(!grepl("^4.6", rvers), "Snapshot created with R 4.6.*")
  skip_on_cran()

  allfiles <- list.files(
    system.file("examples", package = "cffr"),
    pattern = "^DESC",
    full.names = TRUE
  )

  citpath <- system.file("examples/CITATION_basic", package = "cffr")
  for (i in seq_along(allfiles)) {
    desc_cff <- cff_read_description(allfiles[i], gh_keywords = FALSE)
    generate_cit <- cff_safe_read_citation(allfiles[i], citpath)
    merged <- merge_desc_cit(desc_cff, generate_cit)
    merged <- as_cff(merged)

    expect_snapshot(merged)

    expect_true(cff_validate(merged, verbose = FALSE))
  }
})

test_that("Check dependencies", {
  skip_on_cran()
  deps <- get_dependencies(system.file("DESCRIPTION", package = "cffr"))

  # Extract selected fields
  selected <- lapply(deps, function(x) {
    y <- x[names(x) %in% c("title", "url", "repository")]
    y
  })

  # Select just a sample of dependencies
  selected <- selected[seq(1, 3)]

  class(selected) <- "cff"

  rvers <- getRversion()
  skip_if(!grepl("^4.6", rvers), "Snapshot created with R 4.6.*")
  expect_snapshot(print(selected))
})

test_that("Merge DESCRIPTION wrong url with CITATION_dx", {
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

test_that("Utils coverage", {
  deps <- data.frame(
    package = c("foo", "foo", "bar"),
    version = c("*", "1.0", "2.0"),
    type = c("Imports", "Suggests", "Depends")
  )
  rows <- cff_dependency_rows(deps)

  expect_equal(rows$package, c("foo", "foo", "bar"))
  expect_equal(rows$version_clean, c("", "1.0", "2.0"))
  expect_equal(rows$scope, c("Imports", "Imports", "Depends"))

  mod <- list(`date-released` = "1995-02-01")
  expect_identical(cff_dependency_year(mod), "1995")

  mod2 <- list(`date-released` = "1904/12/30")
  expect_identical(cff_dependency_year(mod2), "1904")

  avail <- data.frame(Package = c("foo", "stats"))
  withr::local_options(
    cffr.available_packages = avail
  )
  expect_true(is_cran_dependency("foo"))
  expect_false(is_cran_dependency("stats"))
  expect_false(is_cran_dependency("bar"))

  ordered <- drop_null(cff_dependency_order(list(
    year = "2025",
    repository = "https://example.org/repo",
    title = "foo",
    type = "software"
  )))
  expect_named(ordered, c("type", "title", "repository", "year"))

  dep <- list(package = "aaaa")
  expect_null(cff_dependency_reference(dep))
  expect_null(get_dependencies(1))
  expect_null(get_dependencies(withr::local_tempfile()))
})

test_that("dependency citation returns NULL when citation cannot be read", {
  local_mocked_bindings(
    cff_citation = function(...) {
      stop("no citation")
    }
  )

  expect_null(cff_dependency_citation("foo"))
  expect_null(cff_dependency_reference(list(
    package = "foo",
    version_clean = "",
    scope = "Imports"
  )))
})
