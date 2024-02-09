test_that("From CFF to bibentry", {
  a_cff <- cff_create("cffr")

  current <- cff_to_bibentry(a_cff)
  expect_silent(old1 <- cff_extract_to_bibtex(a_cff))
  expect_silent(old2 <- cff_to_bibtex(a_cff))

  expect_identical(current, old1)
  expect_identical(current, old2)
})
