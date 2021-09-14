test_that("Try encoding conversion", {
  a <- iconv("España", to = "latin1")

  expect_true(Encoding(a) == "latin1")

  b <- clean_str(a)

  expect_false(Encoding(b) == Encoding(a))
  expect_true(Encoding(b) == "UTF-8")
})
