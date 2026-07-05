test_that("Test errors on cff_read", {
  expect_snapshot(cff_read(c("abcde", "b")), error = TRUE)
  expect_snapshot(cff_read("abcde"), error = TRUE)

  f <- system.file("schema/schema.json", package = "cffr")
  expect_error(cff_read(f), "Cannot recognize the file type of")
})

test_that("cff_read citation.cff", {
  expect_snapshot(cff_read_cff_citation("a"), error = TRUE)

  f <- system.file("examples/CITATION_complete.cff", package = "cffr")
  f1 <- cff_read(f)
  expect_true(cff_validate(f1, verbose = FALSE))
  expect_s3_class(f1, "cff", exact = TRUE)

  # With the alias
  f2 <- cff_read_cff_citation(f)
  expect_identical(f1, f2)
})

test_that("cff_read DESCRIPTION", {
  expect_snapshot(cff_read_description("a"), error = TRUE)

  f <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  f1 <- cff_read(f, gh_keywords = FALSE)
  expect_true(cff_validate(f1, verbose = FALSE))
  expect_s3_class(f1, "cff", exact = TRUE)

  # With the alias
  f2 <- cff_read_description(f, gh_keywords = FALSE)
  expect_identical(f1, f2)

  # Use other params
  f1_1 <- cff_read(
    f,
    gh_keywords = FALSE,
    cff_version = 3000,
    authors_roles = c("aut", "cre", "ctb")
  )

  expect_equal(f1_1$`cff-version`, "3000")

  expect_gt(length(f1_1$authors), length(f1$authors))

  f2_1 <- cff_read_description(
    f,
    gh_keywords = FALSE,
    cff_version = 3000,
    authors_roles = c("aut", "cre", "ctb")
  )

  expect_identical(f1_1, f2_1)

  field_list <- list("repository-code" = "https://github.com/ropensci/cffr")
  expect_equal(
    gh_topics_api_url(field_list),
    "https://api.github.com/repos/ropensci/cffr"
  )
})

test_that("DESCRIPTION URL helpers are deterministic", {
  issues <- c(
    "https://github.com/ropensci/cffr/issues",
    "https://gitlab.com/org/pkg/-/issues"
  )
  expect_equal(
    desc_clean_issue_url(issues),
    c("https://github.com/ropensci/cffr", "https://gitlab.com/org/pkg")
  )

  urls <- c(
    "https://pkgdown.example.org",
    "https://codeberg.org/org/pkg",
    "https://docs.example.org"
  )
  expect_equal(desc_repository_url_index(urls), 2)

  primary <- desc_primary_url(urls[-2], "https://codeberg.org/org/pkg")
  expect_equal(primary$url, "https://pkgdown.example.org")
  expect_equal(primary$remaining, "https://docs.example.org")

  fallback <- desc_primary_url(character(0), "https://github.com/org/pkg")
  expect_equal(fallback$url, "https://github.com/org/pkg")
  expect_equal(fallback$remaining, character(0))

  identifiers <- desc_url_identifiers(c(
    "https://a.example",
    "https://b.example"
  ))
  expect_equal(
    identifiers,
    list(
      list(type = "url", value = "https://a.example"),
      list(type = "url", value = "https://b.example")
    )
  )
  expect_null(desc_url_identifiers(character(0)))
  expect_equal(
    desc_gh_keywords(c("r", "metadata"), c("metadata", "citation")),
    c("r", "metadata", "citation")
  )
})

test_that("DESCRIPTION repository helpers accept fixtures", {
  basic_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  tmp <- withr::local_tempfile(pattern = "DESCRIPTION_basic")
  file.copy(basic_path, tmp)

  pkg <- desc::desc_set("Package", "fixturepkg", file = tmp)
  avail <- data.frame(
    Package = "fixturepkg",
    Repository = "https://cloud.r-project.org/src/contrib"
  )
  repos <- c(CRAN = "https://cloud.r-project.org/")
  testthat::local_mocked_bindings(
    get_avail_on_init = function() avail,
    detect_repos = function() repos,
    .package = "cffr"
  )

  expect_equal(
    cran_package_url("fixturepkg"),
    "https://CRAN.R-project.org/package=fixturepkg"
  )
  expect_equal(
    get_desc_repository(pkg),
    "https://CRAN.R-project.org/package=fixturepkg"
  )
  expect_equal(get_desc_doi(pkg), "10.32614/CRAN.package.fixturepkg")
})

test_that("DESCRIPTION DOI returns NULL outside known repositories", {
  basic_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  tmp <- withr::local_tempfile(pattern = "DESCRIPTION_basic")
  file.copy(basic_path, tmp)

  pkg <- desc::desc_set("Package", "fixturepkg", file = tmp)
  empty_avail <- data.frame(Package = character(0), Repository = character(0))
  testthat::local_mocked_bindings(
    get_avail_on_init = function() empty_avail,
    detect_repos = function() c(CRAN = "https://cloud.r-project.org/"),
    .package = "cffr"
  )

  expect_null(get_desc_doi(pkg))
})

test_that("GitHub topics API URL is built without network calls", {
  x <- c("repository-code" = "https://github.com/ropensci/cffr")
  expect_equal(
    gh_topics_api_url(x),
    "https://api.github.com/repos/ropensci/cffr"
  )

  testthat::local_mocked_bindings(
    fetch_gh_topics = function(api_url) {
      expect_equal(api_url, "https://api.github.com/repos/ropensci/cffr")
      c("r", "citation", "r")
    },
    .package = "cffr"
  )

  expect_equal(get_gh_topics(x), c("r", "citation"))
})

test_that("GitHub topics returns NULL when API has no topics", {
  x <- c("repository-code" = "https://github.com/ropensci/cffr")

  testthat::local_mocked_bindings(
    fetch_gh_topics = function(...) {
      list()
    },
    .package = "cffr"
  )

  expect_null(get_gh_topics(x))
})

test_that("GitHub topics returns NULL outside GitHub repositories", {
  x <- c("repository-code" = "https://gitlab.com/ropensci/cffr")

  testthat::local_mocked_bindings(
    fetch_gh_topics = function(...) {
      stop("fetch_gh_topics() should not be called")
    },
    .package = "cffr"
  )

  expect_null(get_gh_topics(x))
})

test_that("GitHub topics returns NULL when the API request fails", {
  x <- c("repository-code" = "https://github.com/ropensci/cffr")

  testthat::local_mocked_bindings(
    fetch_gh_topics = function(...) {
      NULL
    },
    .package = "cffr"
  )

  expect_null(get_gh_topics(x))
})

test_that("GitHub topics are cleaned before being used as keywords", {
  x <- c("repository-code" = "https://github.com/ropensci/cffr")

  testthat::local_mocked_bindings(
    fetch_gh_topics = function(...) {
      c(" R ", "", "citation", "R")
    },
    .package = "cffr"
  )

  expect_equal(get_gh_topics(x), c("R", "citation"))
})


test_that("cff_read bib", {
  skip_if_not_installed("bibtex", "0.5.0")

  expect_snapshot(cff_read_bib("a"), error = TRUE)

  f <- system.file("REFERENCES.bib", package = "cffr")

  f1 <- cff_read(f)
  expect_s3_class(f1, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_gt(length(f1), 1)

  # Specific
  f2 <- cff_read_bib(f)
  expect_identical(f1, f2)

  # With encodings

  f <- system.file("examples/example.bib", package = "cffr")
  f1_2 <- cff_read(f)
  expect_s3_class(f1_2, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_length(f1_2, 2)

  d <- f1_2[[2]]

  expect_snapshot(d)
  f2_2 <- cff_read_bib(f)
  expect_identical(f1_2, f2_2)
})

test_that("cff_read citation messages", {
  expect_snapshot(cff_read_citation("a"), error = TRUE)

  f <- system.file("examples/CITATION_basic", package = "cffr")
  my_meta <- packageDescription("testthat")

  expect_snapshot(s <- cff_read(f, meta = "aa"))
  expect_silent(s <- cff_read(f, meta = NULL))
  expect_silent(s <- cff_read(f, meta = my_meta))

  # Now try with a file that needs meta
  f <- system.file("examples/CITATION_auto", package = "cffr")

  expect_message(s <- cff_read(f), "with the provided")
  expect_s3_class(s, c("cff_ref_lst", "cff"), exact = TRUE)
})

test_that("cff_read CITATION_basic", {
  a_desc <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  my_meta <- desc_to_meta(a_desc)

  path <- system.file("examples/CITATION_basic", package = "cffr")
  a_cff <- cff_read(path, my_meta)
  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_length(a_cff, 2)
})

test_that("cff_read CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")

  my_meta <- desc_to_meta(desc_path)
  a_cff <- cff_read_citation(cit_path, my_meta)
  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
})

test_that("cff_read CITATION_auto", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  my_meta <- desc_to_meta(desc_path)

  a_cff <- cff_read(cit_path, my_meta)

  expect_length(a_cff, 3)
})

test_that("cff_read CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  my_meta <- desc_to_meta(desc_path)
  a_cff <- cff_read(cit_path, my_meta)

  expect_length(a_cff, 3)
})

test_that("cff_read_safe CITATION_basic", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")
  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_length(a_cff, 2)
})

test_that("cff_read_safe CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")

  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_length(a_cff, 2)
})

test_that("cff_read_safe CITATION_auto", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_length(a_cff, 3)
})

test_that("cff_read_safe CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_length(a_cff, 3)
})


test_that("cff_read_safe CITATION NULL", {
  desc_path <- system.file("x", package = "cffr")
  cit_path <- system.file("y", package = "cffr")

  expect_null(cff_safe_read_citation(desc_path, cit_path))
})

test_that("Corrupt CITATION", {
  tmp <- withr::local_tempfile(pattern = "CITATION")
  writeLines("I am a bad CITATION", tmp)
  expect_message(
    expect_message(anull <- cff_read(tmp), "Could not read"),
    "Cannot read"
  )
  expect_null(anull)

  # Internal
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  expect_silent(anull <- cff_safe_read_citation(desc_path = desc_path, tmp))

  expect_null(anull)
})

test_that("Creating cff from packages encoded in latin1", {
  # Surveillance package
  desc_path <- system.file(
    "examples/DESCRIPTION_surveillance",
    package = "cffr"
  )
  cit_path <- system.file("examples/CITATION_surveillance", package = "cffr")

  expect_true(desc::desc(desc_path)$get("Encoding") == "latin1")

  # Parse citation
  bib <- cff_safe_read_citation(desc_path, cit_path)

  expect_true("UTF-8" %in% Encoding(unlist(bib)))
  expect_false("latin1" %in% Encoding(unlist(bib)))

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(references = bib))

  expect_s3_class(cffobj, "cff")
  expect_snapshot(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})
