test_that("Error if file not exists", {
  expect_error(
    cff_create("DESCRIPTION_not_exists")
  )
})

test_that("Test installed packages", {
  expect_silent(cff_create("jsonlite"))
  expect_silent(cff_create("yaml"))
  expect_silent(cff_create("jsonvalidate"))
})

test_that("Test error formats on inputs", {
  df <- data.frame(x = 1, b = "c")
  expect_error(cff_create(df))
  l <- list(a = 1, b = 3)
  expect_error(cff_create(l))

  expect_error(cff_create("uanuanua"))
})

test_that("Validate all DESCRIPTION files", {
  allfiles <- list.files(system.file("examples",
    package = "cffr"
  ), pattern = "^DESC", full.names = TRUE)

  for (i in seq_len(length(allfiles))) {
    cffobj <- cff_create(allfiles[i])
    # Check that all have preferred citation
    expect_false(is.null(cffobj$`preferred-citation`))

    # Check year
    if (is.null(cffobj$`date-released`)) {
      expect_true(cffobj$`preferred-citation`$year == format(Sys.Date(), "%Y"))
    } else {
      dat <- format(as.Date(cffobj$`date-released`), "%Y")
      expect_true(cffobj$`preferred-citation`$year == dat)
    }

    expect_true(cff_validate(cffobj))
  }
})
