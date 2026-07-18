test_that("cff_gha_update installs a workflow in the requested package", {
  skip_on_cran()

  new_dir <- local_mock_package(
    description = "DESCRIPTION_many_urls",
    rbuildignore = TRUE,
    local_dir = FALSE
  )
  rbuildignore <- file.path(new_dir, ".Rbuildignore")
  expect_true(file_exist_abort(rbuildignore))

  # Add action
  expect_message(cff_gha_update(path = new_dir), "Creating directory")

  expect_message(cff_gha_update(path = new_dir), "already exists")
  expect_message(
    cff_gha_update(path = new_dir, overwrite = TRUE),
    "Workflow installed"
  )

  expect_true(file_exist_abort(file.path(
    new_dir,
    ".github",
    "workflows",
    "update-citation-cff.yaml"
  )))

  expect_true("^\\.github$" %in% readLines(rbuildignore))
})
