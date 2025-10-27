test_that("Write basic", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(tempdir(), "basic.cff")
  expect_message(cff_write(desc_file, outfile = tmp, validate = FALSE))
  expect_silent(cff_write(desc_file, outfile = tmp, verbose = FALSE))
  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})

test_that("Write to a non-existing folder", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(tempdir(), "/test_new_folder/recursive/new_folder.cff")
  cff_write(
    desc_file,
    outfile = tmp,
    validate = FALSE,
    verbose = FALSE
  )

  expect_true(dir.exists(file.path(
    tempdir(),
    "test_new_folder",
    "recursive"
  )))
  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})

test_that("Write no encoding", {
  desc_file <-
    system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(tempdir(), "noencoding.cff")
  cff_write(
    desc_file,
    outfile = tmp,
    validate = FALSE,
    verbose = FALSE
  )

  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})

test_that("Add new keys", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(tempdir(), "newkeys.cff")

  # Add additional keys
  newkeys <- list(
    message = "This overwrites fields",
    abstract = "New abstract",
    keywords = c("A", "new", "list", "of", "keywords"),
    authors = as_cff_person(
      person("Don", "Nadie", comment = c(website = "error"))
    ),
    "date-released" = "1900-01-01",
    "error" = "This is an error"
  )
  expect_message(
    s <- cff_write(
      desc_file,
      keys = newkeys,
      outfile = tmp,
      validate = FALSE,
      verbose = FALSE
    ),
    "error: No match"
  )
  expect_snapshot(s)

  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})


test_that("Append keys", {
  desc_file <-
    system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_snapshot(desc_file)

  expect_s3_class(desc_file, "cff")

  old_aut <- desc_file$authors

  # It should be a list
  new_aut <- append(
    old_aut,
    as_cff_person(
      person(
        "New",
        "author",
        comment = c(
          "error" = 123,
          website = "https://stackoverflow.com/",
          country = "IT"
        )
      )
    )
  )

  tmp <- file.path(tempdir(), "appendkeys.cff")
  s <- cff_write(
    desc_file,
    outfile = tmp,
    keys = list("authors" = new_aut),
    verbose = FALSE
  )

  expect_snapshot(s)

  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})

test_that("Fix extension of the file", {
  cffobj <- cff()
  cffobj <- cff_modify(cffobj, authors = as_cff_person("Diego Pérez"))
  tmp <- file.path(tempdir(), "fix_extension")
  expect_silent(cff_write(cffobj, tmp, verbose = FALSE))

  expect_false(file_exist_abort(tmp))
  expect_true(file_exist_abort(paste0(tmp, ".cff")))
  expect_true(cff_validate(paste0(tmp, ".cff"), verbose = FALSE))
  expect_snapshot_file(paste0(tmp, ".cff"))

  file.remove(paste0(tmp, ".cff"))
  expect_false(file_exist_abort(paste0(tmp, ".cff")))
})

test_that("test encoding utf8", {
  cffobj <- cff()
  cffobj <- cff_modify(cffobj, authors = as_cff_person("Diego Pérez"))
  tmp <- file.path(tempdir(), "utf8.cff")
  expect_silent(cff_write(cffobj, tmp, verbose = FALSE))

  expect_true(file_exist_abort(tmp))
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})

test_that("test encoding others", {
  skip_on_os("mac")
  cffobj <- cff()
  cffobj <- cff_modify(cffobj, authors = as_cff_person("Diego Pérez"))
  tmp <- file.path(tempdir(), "asci_trans.cff")
  expect_silent(cff_write(
    cffobj,
    tmp,
    verbose = FALSE,
    encoding = "ASCII//TRANSLIT"
  ))

  expect_true(file_exist_abort(tmp))
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})
