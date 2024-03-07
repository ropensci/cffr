test_that("get_bib_month", {
  x <- list(month = "1")
  expect_identical(get_bib_month(x), "jan")

  x <- list("date-published" = "2027-02-10")

  expect_identical(get_bib_month(x), "feb")
})
