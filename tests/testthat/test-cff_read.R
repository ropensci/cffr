test_that("Test errors on cff", {
  expect_error(cff("abcde"))
  nocff <- system.file("CITATION",
    package = "cffR"
  )
  expect_error(cff_create(nocff))
})

test_that("Compare blank cff with skeleton", {
  skeleton <- system.file("examples/CITATION_skeleton.cff",
    package = "cffr"
  )

  fromfile <- cff(skeleton)
  fromfunction <- cff()
  expect_true(all(unlist(fromfile) == unlist(fromfunction)))

  # Validate
  expect_true(cff_validate(fromfunction, verbose = FALSE))
})

test_that("Walk trough full lifecycle", {
  complete <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )

  # Read
  read <- cff_read(complete)
  expect_s3_class(read, "cff")
  expect_true(cff_validate(read, verbose = FALSE))
  expect_snapshot_output(print_snapshot("Read object", read))

  # Modify
  modify <- cff_create(read, keys = list(title = "A new title"))
  expect_snapshot_output(print_snapshot("Modify object", modify))
  expect_true(all(unlist(read) == unlist(read)))
  expect_true(length(read) == length(modify))
  expect_true(length((setdiff(names(read), names(modify)))) == 0)
  expect_false(read$title == modify$title)



  # Write
  tmp <- tempfile(fileext = ".cff")
  cff_write(modify, outfile = tmp, validate = FALSE, verbose = FALSE)
  stopifnotexists(tmp)
  stopifnotcff(tmp)

  # Validate
  expect_true(cff_validate(tmp, verbose = FALSE))

  file.remove(tmp)
})

test_that("Other convertes", {
  a <- cff()
  expect_s3_class(a, "cff")
  a <- cff(a)
  expect_s3_class(a, "cff")
  a <- as.cff(a)
  expect_true(is.cff(a))
  expect_s3_class(a, "cff")

  expect_true(is.cff(cff(address = "New York", version = 5)))
  expect_false(is.cff(list(a = 1, b = 2)))
  expect_true(is.cff(as.cff(list(a = 1, b = 2))))
})


test_that("Recursive parsing", {
  complete <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )

  # Read
  read <- cff(complete)

  # Test all levels
  expect_s3_class(read, "cff")
  expect_s3_class(read$authors, "cff")
  expect_s3_class(read$authors[[1]], "cff")
  expect_s3_class(read$references, "cff")
  expect_s3_class(read$references[[1]]$authors, "cff")
  expect_s3_class(read$references[[1]]$authors[[1]], "cff")
})


test_that("Fuzzy matching of keys on cff", {
  expect_message(cff(
    tittle = "a",
    cff_version = "ar",
    version = "200",
    messange = "Fix my keys"
  ))

  cffobj <- suppressMessages(
    cff(
      tittle = "a",
      cff_version = "1.2.0",
      version = "200",
      anthor = list(list(
        "family-names" = "a",
        "given-names" = "b"
      )),
      messange = "Fix my keys"
    )
  )

  expect_true(is.cff(cffobj))
  expect_true(cff_validate(cffobj, verbose = FALSE))

  expect_snapshot_output(print_snapshot("Fuzzy keys", cffobj))
})
