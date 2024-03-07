test_that("fallback_dates", {
  xinit <- list(year = "2025")
  p <- fallback_dates(list(year = "2025"))
  expect_identical(xinit, p)

  p2 <- fallback_dates(list("date-published" = "2025-09-25"))
  expect_snapshot(as_cff(p2))
})
