test_that("Errors", {
  expect_silent(b <- cff_to_bibtex("testthat"))
  expect_s3_class(b, "bibentry")
  expect_error(cff_to_bibtex("testthat", what = "aa"))
})

test_that("From package", {
  skip_if_not_installed("rmarkdown")

  base <- cff_to_bibtex("rmarkdown")

  expect_s3_class(base, "bibentry")

  expect_length(base, 1)

  refs <- cff_to_bibtex("rmarkdown", "references")
  expect_s3_class(refs, "bibentry")

  expect_gte(length(refs), 1)

  all <- cff_to_bibtex("rmarkdown", "all")
  expect_s3_class(all, "bibentry")

  expect_length(all, length(base) + length(refs))
})

test_that("NULL references", {
  basic <- cff()

  expect_null(cff_to_bibtex(basic, "references"))

  # Test all
  expect_length(cff_to_bibtex(basic, "all"), 1)
})


test_that("From CITATION.cff", {
  p <- system.file("examples/smith-et-al.cff", package = "cffr")

  base <- cff_to_bibtex(p)

  expect_s3_class(base, "bibentry")

  expect_length(base, 1)
})
