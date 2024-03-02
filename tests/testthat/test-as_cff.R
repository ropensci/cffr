test_that("as.cff still works", {
  l <- list(
    "cff-version" = "1.2.0",
    title = "Manipulating files"
  )

  expect_silent(l1 <- as_cff(l))
  expect_silent(l2 <- as.cff(l))
  expect_s3_class(l1, c("cff", "list"))

  expect_snapshot(l2)
})


test_that("Other convertes", {
  a <- cff()
  expect_s3_class(a, "cff")
  a <- cff(a)
  expect_s3_class(a, "cff")
  a <- as_cff(a)
  expect_true(is_cff(a))
  expect_s3_class(a, "cff")

  expect_message(noadd <- cff(address = "New York", version = 5))
  expect_true(is_cff(noadd))
  expect_false(is_cff(list(a = 1, b = 2)))
  expect_true(is_cff(as_cff(list(a = 1, b = 2))))
})
