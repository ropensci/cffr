test_that("cff_extract_to_bibtex", {
  a_cff <- cff_create("cffr")

  current <- cff_to_bibentry(a_cff)
  expect_snapshot(old1 <- cff_extract_to_bibtex(a_cff))

  expect_identical(current, old1)
})

test_that("cff_to_bibtex", {
  a_cff <- cff_create("cffr")

  current <- cff_to_bibentry(a_cff)
  expect_snapshot(old1 <- cff_to_bibtex(a_cff))

  expect_identical(current, old1)
})
