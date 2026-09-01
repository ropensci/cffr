test_that("encoding helpers convert strings to UTF-8", {
  a <- iconv("España", to = "latin1")

  expect_identical(Encoding(a), "latin1")

  b <- clean_str(a)

  expect_identical(Encoding(b), "UTF-8")
})

test_that("clean_str removes empty and malformed values", {
  expect_identical(clean_str(c("a", "b")), c("a b"))

  expect_null(clean_str(NA))
  expect_null(clean_str(NULL))
  expect_null(clean_str(""))
  expect_null(clean_str(character(0)))
  expect_null(clean_str(integer(0)))
  expect_null(clean_str(logical(0)))
  expect_null(clean_str(list()))
})

test_that("clean_package_meta removes its temporary file after errors", {
  tmp <- withr::local_tempfile()
  unlink(tmp)
  local_mocked_bindings(cff_tempfile = \(...) tmp, clean_str = function(...) {
    stop("Unable to clean package metadata", call. = FALSE)
  })

  meta <- packageDescription("cffr")
  expect_snapshot(clean_package_meta(meta), error = TRUE)
  expect_false(file.exists(tmp))
})

test_that("repository helpers select CRAN-compatible repositories", {
  # Use some other repos
  repos <- c("https://ropensci.r-universe.dev", "https://cloud.r-project.org")

  final <- detect_repos(repos)
  expect_identical(final, c(CRAN = "https://cloud.r-project.org/"))

  # With posit package manager
  repos <- c(
    CRAN = "https://packagemanager.posit.co/cran/latest",
    RPSM = "https://packagemanager.rstudio.com/",
    ANOTHER = "https://packagemanager.rspm.com/"
  )
  final <- detect_repos(repos)
  expect_identical(final, c(CRAN = "https://cloud.r-project.org/"))
})
