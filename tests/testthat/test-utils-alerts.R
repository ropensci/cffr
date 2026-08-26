test_that("abort_if_not_cff rejects unsupported inputs", {
  obj <- cff()

  expect_silent(abort_if_not_cff(obj))

  file <- system.file("examples/CITATION_skeleton.cff", package = "cffr")

  expect_silent(abort_if_not_cff(file))

  # Error

  err <- "Some string"

  expect_snapshot(abort_if_not_cff(err), error = TRUE)

  # Other objects
  x <- data.frame(a = 1)
  expect_snapshot(abort_if_not_cff(x), error = TRUE)
})

test_that("file_exist_abort reports missing files", {
  nonexits <- "aaaaaaaa"
  expect_silent(file_exist_abort(nonexits))
  expect_false(file_exist_abort(nonexits))

  # Signal an error
  expect_snapshot(file_exist_abort(nonexits, abort = TRUE), error = TRUE)
  # With dir
  non_with_path <- "./R/no/existe"
  expect_snapshot(file_exist_abort(non_with_path, abort = TRUE), error = TRUE)

  tmp <- withr::local_tempfile()

  writeLines("a", tmp)
  expect_true(file_exist_abort(tmp))
  expect_true(file_exist_abort(tmp, abort = TRUE))
})

test_that("match_cff_arg validates allowed values", {
  expect_snapshot(match_cff_arg("a", "b", "..."), error = TRUE)
  expect_snapshot(match_cff_arg("a", c("b", "c", "d"), "what"), error = TRUE)

  # Test call
  my_fun <- function(x = "a") {
    match_cff_arg("a", LETTERS[1:5], "aa", environment())
  }

  expect_snapshot(my_fun(), error = TRUE)
  expect_silent(a <- match_cff_arg(c("a", "b"), letters, "..."))
  expect_identical(a, "a")
})
