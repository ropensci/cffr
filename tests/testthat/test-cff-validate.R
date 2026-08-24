test_that("cff_validate accepts complete cff files", {
  full <- system.file("examples/CITATION_complete.cff", package = "cffr")

  # From object
  fcff <- cff_read(full)
  expect_snapshot(ok <- cff_validate(fcff))
  expect_true(ok)
  expect_null(attr(ok, "errors"))
  expect_silent(cff_validate(full, verbose = FALSE))

  # From file
  expect_true(cff_validate(full))
})

test_that("cff_validate accepts minimal cff files", {
  full <- system.file("examples/CITATION_skeleton.cff", package = "cffr")
  expect_true(cff_validate(full, verbose = FALSE))
})

test_that("cff_validate handles file paths with braces in verbose messages", {
  full <- system.file("examples/CITATION_complete.cff", package = "cffr")
  tmp <- withr::local_tempfile(pattern = "cff-{path}", fileext = ".cff")
  file.copy(full, tmp)

  expect_message(cff_validate(tmp), "is valid")
})

test_that("cff_validate reports all schema errors", {
  err <- system.file("examples/CITATION_error.cff", package = "cffr")
  # From cff
  ferr <- cff_read(err)
  expect_snapshot(tab <- cff_validate(ferr))
  expect_false(as.logical(tab))
  # Extract attr table
  df <- attr(tab, "errors")
  expect_s3_class(df, "data.frame")

  snap_fields <- vapply(df, class, FUN.VALUE = character(1))
  expect_snapshot(df[, snap_fields == "character"])

  expect_silent(cff_validate(err, verbose = FALSE))
})

test_that("cff_validate pluralizes one validation error", {
  cffobj <- cff(
    "cff-version" = "1.2.0",
    message = "If you use this software, please cite it as below.",
    title = "A minimal package"
  )

  expect_message(cff_validate(cffobj), "has 1 validation error:")
})

test_that("cff_validate accepts cff objects from installed packages", {
  cffr <- cff_create("jsonlite")
  expect_true(cff_validate(cffr, verbose = FALSE))
})

test_that("cff_validate rejects unsupported inputs", {
  nocff <- system.file("CITATION", package = "cffr")
  expect_snapshot(cff_validate(nocff), error = TRUE)

  nofile <- system.file("examples/no_file_here", package = "cffr")
  expect_snapshot(cff_validate(nofile), error = TRUE)
})

test_that("cff_validate rejects non-cff files", {
  expect_snapshot(
    cff_validate(system.file("examples/DESCRIPTION_basic", package = "cffr")),
    error = TRUE
  )
})
