test_that("Test in mock package", {
  current_dir <- getwd()

  name <- paste0("mock-pack", runif(1) * 10)
  new_dir <- file.path(tempdir(), name)

  dir.create(new_dir, recursive = TRUE)

  expect_true(dir.exists(new_dir))

  setwd(new_dir)
  dir.create(file.path(new_dir, "inst"), recursive = TRUE)

  # Move files
  file.copy(system.file("examples/DESCRIPTION_many_urls", package = "cffr"),
    to = "DESCRIPTION"
  )

  file.copy(system.file("examples/CITATION_basic", package = "cffr"),
    to = file.path("inst", "CITATION")
  )

  # Create Rbuildignore
  file.create(".Rbuildignore", showWarnings = FALSE)
  expect_true(file.exists(".Rbuildignore"))

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

  expect_true(file.exists(file.path(
    ".github",
    "workflows",
    "update-citation-cff.yaml"
  )))


  cffobj <- cff_create()


  expect_message(cff_write(validate = FALSE, verbose = TRUE))

  expect_true(file.exists("CITATION.cff"))

  expect_true(cff_validate("CITATION.cff", verbose = FALSE))

  ignore <- readLines(".Rbuildignore")

  expect_true(("^CITATION\\.cff$" %in% ignore))
  expect_true(("^\\.github$" %in% ignore))

  # Revert to initial wd
  setwd(current_dir)

  expect_snapshot(cffobj)
})
