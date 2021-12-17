test_that("Try not writing", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  expect_snapshot_output(write_bib(bib))

  expect_snapshot_output(write_bib(bib, ascii = TRUE))

  expect_error(write_bib(1))
})

test_that("Write", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  file <- file.path(tempdir(), "noext")
  expect_message(write_bib(bib, file, verbose = TRUE))

  # Fix extensions
  file <- paste0(file, ".bib")
  expect_true(file.exists(file))

  expect_snapshot_file(file)

  # Check backup
  expect_false(file.exists(paste0(file, ".bk1")))

  # Check now backup exists
  write_bib(bib, file, append = TRUE)
  expect_true(file.exists(paste0(file, ".bk1")))

  file.remove(file)
  file.remove(paste0(file, ".bk1"))
})


test_that("Write ASCII", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  file <- file.path(tempdir(), "ascii.bib")
  expect_message(write_bib(bib, file, verbose = TRUE, ascii = TRUE))

  # Fix extensions
  expect_snapshot_file(file)
  file.remove(file)
})
