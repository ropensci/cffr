test_that("Validate full CITATION.cff", {
  full <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )
  expect_message(cff_validate(full))
  expect_true(cff_validate(full))
})

test_that("Validate minimal CITATION.cff", {
  full <- system.file("examples/CITATION_skeleton.cff",
    package = "cffr"
  )
  expect_message(cff_validate(full))
  expect_true(cff_validate(full))
})

test_that("Validate error CITATION.cff", {
  err <- system.file("examples/CITATION_error.cff",
    package = "cffr"
  )
  expect_message(cff_validate(err))
  expect_false(suppressMessages(cff_validate(err)))
})

test_that("Validate cffr objects from installed packages", {
  cffr <- cff_create("jsonlite")
  expect_true(cff_validate(cffr))
})

test_that("Validate cffr objects", {
  allfiles <- list.files(system.file("examples",
    package = "cffr"
  ), pattern = "^DESC", full.names = TRUE)

  names <- list.files(system.file("examples",
    package = "cffr"
  ), pattern = "^DESC", full.names = FALSE)


  for (i in seq_len(length(allfiles))) {
    tmp <- tempfile(pattern = names[i], fileext = ".cff")
    message("----\nValidating ", names[i], "\n----")
    if (names[i] == "DESCRIPTION_no_encoding") {
      expect_warning(cff_create(allfiles[i]))
    } else {
      s <- cff_create(allfiles[i])
      expect_true(cff_validate(s))
    }
  }
})

test_that("Validate error CITATION.cff", {
  err <- system.file("examples/CITATION_error.cff",
    package = "cffr"
  )
  expect_message(cff_validate(err))
  expect_false(suppressMessages(cff_validate(err)))
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
    cff_validate(system.file("examples/DESCRIPTION_demo", package = "cffr"))
  )
})

test_that("Snapshot for validating message", {
  expect_snapshot({
    err <- system.file("examples/CITATION_error.cff",
      package = "cffr"
    )
    cff_validate(err)
  })
})
