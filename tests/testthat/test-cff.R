test_that("Error on cff", {
  expect_error(cff("abcde"))
  nocff <- system.file("CITATION",
    package = "cffR"
  )
  expect_error(cff_create(nocff))
})

test_that("Compare skeleton", {
  skeleton <- system.file("examples/CITATION_skeleton.cff",
    package = "cffr"
  )

  fromfile <- unlist(cff(skeleton))
  fromfunction <- cff()
  expect_true(all(fromfile == unlist(fromfunction)))

  # Validate
  expect_true(cff_validate(fromfunction))
})

test_that("Full lifecycle", {
  complete <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )

  # Read
  read <- expect_silent(cff(complete))

  # Modify
  modify <- cff_create(read, keys = list(title = "New title here"))
  expect_false(read$title == modify$title)

  # Write
  tmp <- tempfile(fileext = ".cff")
  expect_message(cff_write(modify, outfile = tmp, validate = FALSE))
  expect_silent(stopifnotexists(tmp))
  expect_silent(stopifnotcff(tmp))

  # Validate
  expect_true(cff_validate(tmp))
})

test_that("Other convertes", {
  a <- cff()
  a <- as.cff(a)
  expect_true(is.cff(a))

  expect_true(is.cff(cff(address = "New York", version = 5)))
  expect_false(is.cff(list(a = 1, b = 2)))
  expect_true(is.cff(as.cff(list(a = 1, b = 2))))
})
