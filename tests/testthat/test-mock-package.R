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

  cffobj <- cff_create()

  expect_message(cff_write(), "Congratulations! This .cff file is valid")

  expect_true(file.exists("CITATION.cff"))

  # Revert to initial wd
  setwd(current_dir)

  expect_snapshot_output(cffobj)
})
