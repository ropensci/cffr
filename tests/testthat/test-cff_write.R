test_that("Write basic", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- tempfile(fileext = ".cff")
  expect_message(cff_write(desc_file, outfile = tmp, validate = FALSE))
  expect_silent(cff_write(desc_file, outfile = tmp, verbose = FALSE))
  expect_true(file.exists(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))

  file.remove(tmp)
  expect_false(file.exists(tmp))
})

test_that("Write to a non-existing folder", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- tempfile("/test_new_folder/recursive/", fileext = ".cff")
  cff_write(
    desc_file,
    outfile = tmp,
    validate = FALSE,
    verbose = FALSE
  )

  expect_true(dir.exists(file.path(
    tempdir(), "test_new_folder", "recursive"
  )))
  expect_true(file.exists(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))

  file.remove(tmp)
  expect_false(file.exists(tmp))
})

test_that("Write no encoding", {
  desc_file <-
    system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- tempfile(fileext = ".cff")
  cff_write(
    desc_file,
    outfile = tmp,
    validate = FALSE,
    verbose = FALSE
  )

  expect_true(file.exists(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))

  file.remove(tmp)
  expect_false(file.exists(tmp))
})

test_that("Add new keys", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- tempfile(fileext = ".cff")


  # Add additional keys
  newkeys <- list(
    message = "This overwrites fields",
    abstract = "New abstract",
    keywords = c("A", "new", "list", "of", "keywords"),
    authors = list(cff_parse_person(person(
      "Don", "Nadie",
      comment = c(website = "error")
    ))),
    "date-released" = "1900-01-01",
    "error" = "This is an error"
  )

  s <- cff_write(
    desc_file,
    keys = newkeys,
    outfile = tmp,
    validate = FALSE,
    verbose = FALSE
  )
  expect_snapshot_output(s)

  expect_true(file.exists(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))

  file.remove(tmp)
  expect_false(file.exists(tmp))
})


test_that("Append keys", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_snapshot_output(desc_file)

  expect_s3_class(desc_file, "cff")


  old_aut <- desc_file$authors

  # It should be a list
  new_aut <- append(
    old_aut,
    list(cff_parse_person(person(
      "New",
      "author",
      comment = c(
        "error" = 123,
        website = "https://stackoverflow.com/",
        country = "IT"
      )
    )))
  )

  tmp <- tempfile(fileext = ".cff")
  s <- cff_write(
    desc_file,
    outfile = tmp,
    keys = list("authors" = new_aut),
    verbose = FALSE
  )

  expect_snapshot_output(s)

  expect_true(cff_validate(tmp, verbose = FALSE))

  file.remove(tmp)
  expect_false(file.exists(tmp))
})

test_that("Fix extension of the file", {
  cffobj <- cff()

  tmp <- tempfile()
  expect_silent(cff_write(cffobj, tmp, verbose = FALSE))

  expect_false(file.exists(tmp))
  expect_true(file.exists(paste0(tmp, ".cff")))
  expect_true(cff_validate(paste0(tmp, ".cff"), verbose = FALSE))

  file.remove(paste0(tmp, ".cff"))
  expect_false(file.exists(paste0(tmp, ".cff")))
})
