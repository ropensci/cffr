test_that("Check is_email", {
  # Examples from https://www.nicebread.de/validating-email-adresses-in-r/

  # Valid addresses
  expect_true(
    all(
      is_email("felix@nicebread.de"),
      is_email("felix.123.honeyBunny@nicebread.lmu.de"),
      is_email("felix@nicebread.de  "),
      is_email("    felix@nicebread.de"),
      is_email("felix+batman@nicebread.de"),
      is_email("felix@nicebread.office")
    )
  )
  # invalid addresses
  expect_false(
    any(
      is_email("felix@nicebread"),
      is_email("felix@nicebread@de"),
      is_email("felixnicebread.de"),
      is_email("@felixnicebread"),
      is_email(NULL),
      is_email(NA)
    )
  )
})


test_that("Check is_url", {
  # Valid urls
  expect_true(
    all(
      is_url("https://github.com/dieghernan"),
      is_url("http://github.com/dieghernan"),
      is_url("ftp://github.com/dieghernan"),
      is_url("sftp://github.com/dieghernan")
    )
  )
  # invalid addresses
  expect_false(
    any(
      is_url("https:/github.com/dieghernan"),
      is_url("http:/github.com/dieghernan"),
      is_url("ftp:/github.com/dieghernan"),
      is_url("sftp:/github.com/dieghernan"),
      is_url("www.github.com/dieghernan")
    )
  )
})


test_that("Check stop if not cff", {
  obj <- cff()

  expect_silent(stopifnotcff(obj))

  file <- system.file("examples/CITATION_skeleton.cff",
    package = "cffr"
  )

  expect_silent(stopifnotcff(file))

  # Error

  err <- "Some string"

  expect_error(stopifnotcff(err))

  # Other objects
  x <- list(a = 1)
  expect_error(stopifnotcff(x), "list")
})
