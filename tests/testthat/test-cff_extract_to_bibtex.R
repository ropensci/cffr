test_that("From package", {
  skip_if_not_installed("rmarkdown")

  base <- cff_extract_to_bibtex("rmarkdown")

  expect_s3_class(base, "bibentry")

  expect_length(base, 1)

  refs <- cff_extract_to_bibtex("rmarkdown", "references")
  expect_s3_class(refs, "bibentry")

  expect_gte(length(refs), 1)

  all <- cff_extract_to_bibtex("rmarkdown", "all")
  expect_s3_class(all, "bibentry")

  expect_length(all, length(base) + length(refs))
})

test_that("NULL references", {
  basic <- cff()

  expect_null(cff_extract_to_bibtex(basic, "references"))

  # Test all
  expect_length(cff_extract_to_bibtex(basic, "all"), 1)
})
