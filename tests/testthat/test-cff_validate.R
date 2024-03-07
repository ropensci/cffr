test_that("Validate full CITATION.cff", {
  full <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )

  # From object
  fcff <- cff_read(full)
  expect_snapshot(ok <- cff_validate(fcff))
  expect_true(ok)
  expect_null(attr(ok, "errors"))
  expect_silent(cff_validate(full, verbose = FALSE))

  # From file
  expect_true(cff_validate(full))
})

test_that("Validate minimal CITATION.cff", {
  full <- system.file("examples/CITATION_skeleton.cff",
    package = "cffr"
  )
  expect_true(cff_validate(full, verbose = FALSE))
})

test_that("Validate error CITATION.cff", {
  err <- system.file("examples/CITATION_error.cff",
    package = "cffr"
  )
  # From cff
  ferr <- cff_read(err)
  expect_snapshot(tab <- cff_validate(ferr))
  expect_false(tab)
  # Extract attr table
  df <- attr(tab, "errors")
  expect_s3_class(df, "data.frame")
  expect_snapshot(df)

  expect_silent(cff_validate(err, verbose = FALSE))
})

test_that("Validate cffr objects from installed packages", {
  cffr <- cff_create("jsonlite")
  expect_true(cff_validate(cffr, verbose = FALSE))
})


test_that("Validate error for invalid input", {
  nocff <- system.file("CITATION",
    package = "cffr"
  )
  expect_error(cff_validate(nocff))

  nofile <- system.file("examples/no_file_here",
    package = "cffr"
  )
  expect_error(cff_validate(nofile))
})

test_that("File that is not cff", {
  expect_error(
    cff_validate(system.file("examples/DESCRIPTION_basic", package = "cffr"))
  )
})
