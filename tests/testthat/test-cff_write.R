test_that("Write basic", {
  desc_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(withr::local_tempdir(), "basic.cff")
  expect_message(cff_write(desc_file, outfile = tmp, validate = FALSE))
  expect_silent(cff_write(desc_file, outfile = tmp, verbose = FALSE))
  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)
})

test_that("Write to a non-existing folder", {
  desc_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  root <- withr::local_tempdir(pattern = "cff-write-")
  tmp <- file.path(root, "recursive", "new_folder.cff")
  cff_write(desc_file, outfile = tmp, validate = FALSE, verbose = FALSE)

  expect_true(dir.exists(file.path(root, "recursive")))
  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)
})

test_that("Write no encoding", {
  desc_file <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(withr::local_tempdir(), "noencoding.cff")
  cff_write(desc_file, outfile = tmp, validate = FALSE, verbose = FALSE)

  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)
})

test_that("Add new keys", {
  desc_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(withr::local_tempdir(), "newkeys.cff")

  # Add additional keys
  newkeys <- list(
    message = "This overwrites fields",
    abstract = "New abstract",
    keywords = c("A", "new", "list", "of", "keywords"),
    authors = as_cff_person(person(
      "Don",
      "Nadie",
      comment = c(website = "error")
    )),
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
})

test_that("Append keys", {
  desc_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_snapshot(desc_file)

  expect_s3_class(desc_file, "cff")

  old_aut <- desc_file$authors

  # It should be a list
  new_aut <- append(
    old_aut,
    as_cff_person(person(
      "New",
      "author",
      comment = c(
        "error" = 123,
        website = "https://stackoverflow.com/",
        country = "IT"
      )
    ))
  )

  tmp <- file.path(withr::local_tempdir(), "appendkeys.cff")
  s <- cff_write(
    desc_file,
    outfile = tmp,
    keys = list("authors" = new_aut),
    verbose = FALSE
  )

  expect_snapshot(s)

  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)
})

test_that("Fix extension of the file", {
  cffobj <- cff()
  cffobj <- cff_modify(cffobj, authors = as_cff_person("Diego Pérez"))
  tmp <- file.path(withr::local_tempdir(), "fix_extension")
  expect_silent(cff_write(cffobj, tmp, verbose = FALSE))

  expect_false(file_exist_abort(tmp))
  expect_true(file_exist_abort(paste0(tmp, ".cff")))
  expect_true(cff_validate(paste0(tmp, ".cff"), verbose = FALSE))
  expect_snapshot_file(paste0(tmp, ".cff"))
})

test_that("test encoding utf8", {
  cffobj <- cff()
  cffobj <- cff_modify(cffobj, authors = as_cff_person("Diego Pérez"))
  tmp <- file.path(withr::local_tempdir(), "utf8.cff")
  expect_silent(cff_write(cffobj, tmp, verbose = FALSE))

  expect_true(file_exist_abort(tmp))
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)
})

test_that("test encoding others", {
  skip_on_os("mac")
  cffobj <- cff()
  cffobj <- cff_modify(cffobj, authors = as_cff_person("Diego Pérez"))
  tmp <- file.path(withr::local_tempdir(), "asci_trans.cff")
  expect_silent(cff_write(
    cffobj,
    tmp,
    verbose = FALSE,
    encoding = "ASCII//TRANSLIT"
  ))

  expect_true(file_exist_abort(tmp))
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)
})

test_that("Update .Rbuildignore", {
  new_dir <- withr::local_tempdir(pattern = "rbuildignore-")
  withr::local_dir(new_dir)

  outfile <- "CITATION.cff"
  current_dir <- getwd()

  expect_silent(cff_update_rbuildignore(cff(), outfile, verbose = TRUE))
  expect_false(file.exists(".Rbuildignore"))

  expect_silent(cff_update_rbuildignore("not-the-current-dir", outfile, TRUE))
  expect_false(file.exists(".Rbuildignore"))

  expect_silent(cff_update_rbuildignore(current_dir, outfile, verbose = TRUE))
  expect_false(file.exists(".Rbuildignore"))

  writeLines(c("^foo$", "^CITATION\\.cff$"), ".Rbuildignore")
  expect_silent(cff_update_rbuildignore(current_dir, outfile, verbose = TRUE))
  expect_identical(readLines(".Rbuildignore"), c("^foo$", "^CITATION\\.cff$"))

  writeLines(c("^foo$", "^foo$"), ".Rbuildignore")
  expect_silent(cff_update_rbuildignore(current_dir, outfile, verbose = FALSE))
  expect_identical(readLines(".Rbuildignore"), c("^foo$", "^CITATION\\.cff$"))

  writeLines("^bar$", ".Rbuildignore")
  expect_message(
    cff_update_rbuildignore(current_dir, outfile, verbose = TRUE),
    "Adding"
  )
  expect_identical(readLines(".Rbuildignore"), c("^bar$", "^CITATION\\.cff$"))
})


test_that("cff_write creates CITATION.cff in a mock package", {
  skip_on_cran()

  local_mock_package(
    description = "DESCRIPTION_many_urls",
    rbuildignore = TRUE
  )

  expect_silent(cff_write(verbose = FALSE))
  expect_true(file_exist_abort("CITATION.cff"))
  expect_true(cff_validate("CITATION.cff", verbose = FALSE))
  expect_false(file.exists("inst/CITATION"))

  ignore <- readLines(".Rbuildignore")
  expect_true("^CITATION\\.cff$" %in% ignore)
})

test_that("cff_write creates and updates inst/CITATION in a mock package", {
  skip_on_cran()

  local_mock_package(description = "DESCRIPTION_many_urls")

  expect_silent(cff_write(verbose = FALSE, r_citation = TRUE))
  expect_true(file.exists("inst/CITATION"))

  auto_cit1 <- utils::readCitationFile(
    "inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )

  expect_output(
    cff_write(verbose = TRUE, r_citation = TRUE),
    "Updating\\s+'inst/CITATION'"
  )
  expect_length(list.files("inst"), 1)

  auto_cit2 <- utils::readCitationFile(
    "inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )

  expect_identical(auto_cit1, auto_cit2)

  d <- desc::desc("DESCRIPTION")
  expect_message(d$bump_version("major"))
  d$write("DESCRIPTION")

  cff_write(verbose = FALSE, r_citation = TRUE)

  auto_cit3 <- utils::readCitationFile(
    "inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )

  expect_false(identical(auto_cit1, auto_cit3))

  rvers <- getRversion()
  skip_if(!grepl("^4.6", rvers), "Snapshot created with R 4.6.*")

  expect_snapshot(auto_cit1)
  expect_snapshot(auto_cit3)
})

test_that("cff_write_citation creates inst/CITATION in a mock package", {
  skip_on_cran()

  local_mock_package()

  cit <- utils::readCitationFile(
    system.file("examples/CITATION_basic", package = "cffr"),
    meta = list(Encoding = "UTF-8")
  )

  expect_silent(cff_write_citation(cit, "./inst/CITATION", verbose = FALSE))
  expect_true(file_exist_abort("./inst/CITATION"))

  written <- utils::readCitationFile(
    "./inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )
  expect_identical(written, cit)
})
