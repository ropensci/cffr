test_that("Write basic", {
  desc_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
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
  desc_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(tempdir(), "/test_new_folder/recursive/new_folder.cff")
  cff_write(desc_file, outfile = tmp, validate = FALSE, verbose = FALSE)

  expect_true(dir.exists(file.path(tempdir(), "test_new_folder", "recursive")))
  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})

test_that("Write no encoding", {
  desc_file <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(tempdir(), "noencoding.cff")
  cff_write(desc_file, outfile = tmp, validate = FALSE, verbose = FALSE)

  expect_true(file_exist_abort(tmp))

  # Validate from file
  expect_true(cff_validate(tmp, verbose = FALSE))
  expect_snapshot_file(tmp)

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
})

test_that("Add new keys", {
  desc_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  desc_file <- cff_create(desc_file)
  expect_s3_class(desc_file, "cff")
  tmp <- file.path(tempdir(), "newkeys.cff")

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

  file.remove(tmp)
  expect_false(file_exist_abort(tmp))
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

test_that("Update .Rbuildignore", {
  old_rbuildignore <- if (file.exists(".Rbuildignore")) {
    readLines(".Rbuildignore")
  } else {
    NULL
  }

  on.exit(
    {
      if (is.null(old_rbuildignore)) {
        unlink(".Rbuildignore")
      } else {
        writeLines(old_rbuildignore, ".Rbuildignore")
      }
    },
    add = TRUE
  )

  outfile <- "CITATION.cff"
  current_dir <- getwd()

  unlink(".Rbuildignore")
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


test_that("Test in mock package", {
  skip_on_cran()
  current_dir <- getwd()

  name <- paste0("mock-pack", runif(1) * 10)
  new_dir <- file.path(tempdir(), name)

  dir.create(new_dir, recursive = TRUE)

  expect_true(dir.exists(new_dir))

  setwd(new_dir)

  # Move files
  file.copy(
    system.file("examples/DESCRIPTION_many_urls", package = "cffr"),
    to = "DESCRIPTION"
  )

  # Create a cff
  expect_silent(cff_write(verbose = FALSE))
  expect_false(file.exists("inst/CITATION"))

  # Create a cff also with auto_citation
  expect_silent(cff_write(verbose = FALSE, r_citation = TRUE))
  expect_true(file.exists("inst/CITATION"))

  auto_cit1 <- utils::readCitationFile(
    "inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )

  # Same but with verbose
  ff <- cff_write(verbose = TRUE, r_citation = TRUE)

  # No backup

  expect_length(list.files("inst"), 1)

  auto_cit2 <- utils::readCitationFile(
    "inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )

  expect_identical(auto_cit1, auto_cit2)

  # Update version and re-check

  d <- desc::desc("DESCRIPTION")

  expect_message(d$bump_version("major"))
  d$write("DESCRIPTION")

  # Check new vers
  cff_write(verbose = FALSE, r_citation = TRUE)

  auto_cit3 <- utils::readCitationFile(
    "inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )

  # Clean
  unlink("inst", recursive = TRUE, force = TRUE)
  expect_false(dir.exists("inst"))

  # Get bibentry
  a_bib <- as_bibentry()
  # Create citation
  cit <- utils::readCitationFile(
    system.file("examples/CITATION_basic", package = "cffr"),
    meta = list(Encoding = "UTF-8")
  )

  expect_silent(cff_write_citation(cit, "./inst/CITATION", verbose = FALSE))
  expect_true(file_exist_abort("./inst/CITATION"))

  # Create Rbuildignore
  file.create(".Rbuildignore", showWarnings = FALSE)
  expect_true(file_exist_abort(".Rbuildignore"))

  # Add action
  expect_message(
    expect_message(
      expect_message(cff_gha_update(), "Creating directory"),
      "Installing"
    ),
    "Adding"
  )

  expect_message(cff_gha_update(), "already installed")
  expect_message(cff_gha_update(overwrite = TRUE), "Installing")

  expect_true(file_exist_abort(file.path(
    ".github",
    "workflows",
    "update-citation-cff.yaml"
  )))

  cffobj <- cff_create()

  expect_output(cff_write())

  expect_true(file_exist_abort("CITATION.cff"))

  expect_true(cff_validate("CITATION.cff", verbose = FALSE))

  ignore <- readLines(".Rbuildignore")

  expect_true(("^CITATION\\.cff$" %in% ignore))
  expect_true(("^\\.github$" %in% ignore))

  # Check citation from package
  cit <- utils::readCitationFile(
    "./inst/CITATION",
    meta = list(Encoding = "UTF-8")
  )

  # Revert to initial wd
  setwd(current_dir)

  unlink(new_dir, recursive = TRUE, force = TRUE)

  rvers <- getRversion()
  skip_if(!grepl("^4.6", rvers), "Snapshot created with R 4.6.*")

  expect_false(identical(auto_cit1, cit))
  expect_true(identical(auto_cit1, auto_cit2))
  expect_snapshot(auto_cit1)
  expect_snapshot(auto_cit3)
  expect_snapshot(cffobj)
  expect_snapshot(toBibtex(cit))
  expect_snapshot(toBibtex(a_bib))
})
