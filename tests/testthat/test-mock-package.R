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
  skip_if(!grepl("^4.5", rvers), "Snapshot created with R 4.5.*")

  expect_false(identical(auto_cit1, cit))
  expect_true(identical(auto_cit1, auto_cit2))
  expect_snapshot(auto_cit1)
  expect_snapshot(auto_cit3)
  expect_snapshot(cffobj)
  expect_snapshot(toBibtex(cit))
  expect_snapshot(toBibtex(a_bib))
})
