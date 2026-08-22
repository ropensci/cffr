test_that("cff reports defaults and invalid file input", {
  expect_snapshot(def <- cff("abcde"))

  expect_identical(def, cff())
  nocff <- system.file("examples/CITATION_skeleton.cff", package = "cffR")
  expect_snapshot(afile <- cff(nocff))

  expect_identical(afile, cff())
})

test_that("cff objects survive the full write and modify lifecycle", {
  complete <- system.file("examples/CITATION_complete.cff", package = "cffr")

  # Read
  read <- cff_read(complete)
  expect_s3_class(read, "cff")
  expect_true(cff_validate(read, verbose = FALSE))
  expect_snapshot(read)

  # Modify
  modify <- cff_create(read, keys = list(title = "A new title"))
  expect_snapshot(modify)
  expect_length(read, length(modify))
  expect_setequal(names(read), names(modify))
  expect_false(identical(read$title, modify$title))

  # Write
  tmp <- withr::local_tempfile(fileext = ".cff")
  cff_write(modify, outfile = tmp, validate = FALSE, verbose = FALSE)
  expect_true(file.exists(tmp))

  # Validate
  expect_true(cff_validate(tmp, verbose = FALSE))
})

test_that("cff recursively parses complete files", {
  complete <- system.file("examples/CITATION_complete.cff", package = "cffr")

  # Read
  expect_snapshot(read <- cff(complete))
  read <- cff_read(complete)

  # Test all levels
  expect_s3_class(read, "cff")
  expect_s3_class(read$authors, "cff")
  expect_s3_class(read$authors[[1]], "cff")
  expect_s3_class(read$references, "cff")
  expect_s3_class(read$references[[1]]$authors, "cff")
  expect_s3_class(read$references[[1]]$authors[[1]], "cff")
})


test_that("cff fuzzy-matches misspelled keys", {
  expect_snapshot(cff(
    tittle = "a",
    cff_version = "ar",
    version = "200",
    messange = "Fix my keys"
  ))

  expect_snapshot(
    cffobj <- cff(
      tittle = "a",
      cff_version = "1.2.0",
      version = "200",
      messange = "aa",
      anthor = list(list("family-names" = "a", "given-names" = "b"))
    )
  )

  expect_true(is_cff(cffobj))
  expect_true(cff_validate(cffobj, verbose = FALSE))

  expect_message(
    do.call(cff, stats::setNames(list("a"), "tit{tle}")),
    "tit\\{tle\\}: No match"
  )
})

test_that("cff removes duplicate keys", {
  # jarl-ignore-start duplicated_arguments: Testing edge case.
  expect_snapshot(
    ss <- cff(
      tittle = "a",
      tittle = "ar",
      version = "200",
      messange = "Fix my keys"
    )
  )
  # jarl-ignore-end duplicated_arguments

  expect_s3_class(ss, "cff")
  expect_length(ss, 3)
})

test_that("cff removes unnamed arguments", {
  expect_snapshot(ss <- cff(path = "a", "200", "Fix my keys"), error = TRUE)

  expect_snapshot(s1 <- cff(path = NULL, title = "a", "b", version = 1))
  expect_snapshot(
    s2 <- cff(
      path = NULL,
      title = "a",
      "aa",
      "bb",
      "cc",
      "b",
      version = 1,
      "h",
      "j"
    )
  )

  expect_identical(s1, s2)
})
