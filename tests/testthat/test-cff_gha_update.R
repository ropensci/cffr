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

  # Create Rbuildignore
  file.create(".Rbuildignore", showWarnings = FALSE)
  expect_true(file_exist_abort(".Rbuildignore"))

  # Add action
  expect_snapshot(cff_gha_update())

  expect_snapshot(cff_gha_update())
  expect_snapshot(cff_gha_update(overwrite = TRUE))

  expect_true(file_exist_abort(file.path(
    ".github",
    "workflows",
    "update-citation-cff.yaml"
  )))

  # Revert to initial wd
  setwd(current_dir)

  unlink(new_dir, recursive = TRUE, force = TRUE)
})
