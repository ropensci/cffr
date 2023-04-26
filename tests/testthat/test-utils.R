test_that("Try encoding conversion", {
  a <- iconv("España", to = "latin1")

  expect_true(Encoding(a) == "latin1")

  b <- clean_str(a)

  expect_false(Encoding(b) == Encoding(a))
  expect_true(Encoding(b) == "UTF-8")
})

test_that("Try cleaning string", {
  expect_identical(
    clean_str(c("a", "b")),
    c("a b")
  )


  expect_null(clean_str(NA))
  expect_null(clean_str(NULL))
  expect_null(clean_str(""))
  expect_null(clean_str(character(0)))
  expect_null(clean_str(integer(0)))
  expect_null(clean_str(logical(0)))
  expect_null(clean_str(list()))
})
