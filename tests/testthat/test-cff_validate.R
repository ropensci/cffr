test_that("Validate full CITATION.cff", {
  full <- system.file("examples/CITATION_full.cff",
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


test_that("Validate error for invalid input", {
  nocff <- system.file("CITATION",
    package = "cffR"
  )
  expect_error(cff_validate(nocff))

  nofile <- system.file("examples/no_file_here",
    package = "cffr"
  )
  expect_error(cff_validate(nofile))
})

test_that("Snapshot for validating message", {
  expect_snapshot({
    err <- system.file("examples/CITATION_error.cff",
      package = "cffr"
    )
    cff_validate(err)
  })
})
