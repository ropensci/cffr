test_that("Errors", {
  expect_snapshot(cff_write_bib(1:4), error = TRUE)
})

test_that("Write", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  file <- file.path(tempdir(), "noext")
  expect_message(cff_write_bib(bib, file, verbose = TRUE))

  # Fix extensions
  file <- paste0(file, ".bib")
  expect_true(file_exist_abort(file))

  expect_snapshot_file(file)

  # Check backup
  expect_false(file_exist_abort(paste0(file, ".bk1")))

  # Check now backup exists
  cff_write_bib(bib, file, append = TRUE)
  expect_true(file_exist_abort(paste0(file, ".bk1")))

  file.remove(file)
  file.remove(paste0(file, ".bk1"))
})


test_that("Write ASCII", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  file <- file.path(tempdir(), "ascii.bib")
  expect_silent(cff_write_bib(bib, file, verbose = FALSE, ascii = TRUE))

  # Fix extensions
  expect_snapshot_file(file)
  file.remove(file)
})

test_that("Test append", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Herrero"
  )
  cf <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  a_cff <- cff_read(cf)

  file <- file.path(tempdir(), "append.bib")
  expect_silent(cff_write_bib(bib, file, verbose = FALSE, append = FALSE))

  # Initial lines
  lines1 <- readLines(file)

  # Append
  bib2 <- bibentry("Misc",
    key = "key2", title = "Another title",
    author = "Ian Henderson"
  )


  cff_write_bib(bib2, file, verbose = FALSE, append = TRUE)
  cff_write_bib(a_cff, file, verbose = FALSE, append = TRUE)
  expect_snapshot_file(file)

  lines2 <- readLines(file)

  # First lines identical, more lines on append
  expect_true(all(lines1 == lines2[seq_len(length(lines1))]))

  expect_gt(length(lines2), length(lines1))

  # Overwrite
  cff_write_bib(bib2, file, verbose = FALSE, append = FALSE)
  lines3 <- readLines(file)

  expect_false(all(lines1 == lines3[seq_len(length(lines1))]))
  expect_lt(length(lines3), length(lines2))
})


test_that("Test dir creation", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Herrero"
  )

  file <- file.path(tempdir(), "idontexist", "append.bib")

  dir <- dirname(file)

  expect_false(dir.exists(dir))
  expect_silent(cff_write_bib(bib, file, verbose = FALSE))

  expect_true(dir.exists(dir))
  expect_true(file_exist_abort(file))

  unlink(dir, recursive = TRUE, force = TRUE)

  # With messages
  file <- file.path(tempdir(), "nowiamverbose", "append.bib")
  dir <- dirname(file)
  expect_false(dir.exists(dir))
  expect_message(cff_write_bib(bib, file, verbose = TRUE), "Creating directory")

  expect_true(dir.exists(dir))
  expect_true(file_exist_abort(file))

  unlink(dir, recursive = TRUE, force = TRUE)
})

test_that("Errors citation", {
  expect_snapshot(cff_write_citation(1:4), error = TRUE)
})

test_that("Write CITATION", {
  f <- system.file("examples", package = "cffr")
  thepath <- list.files(f, pattern = "DESCRIPTION_basicdate", full.names = TRUE)
  f1 <- cff_read(thepath)

  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  file <- file.path(tempdir(), "CITAT_ION")
  expect_message(cff_write_citation(bib, file, verbose = TRUE))

  # Check backup
  expect_false(file_exist_abort(paste0(file, ".bk1")))

  # Check now backup exists and use cff
  expect_silent(cff_write_citation(f1, file,
    verbose = FALSE,
    what = "all", append = TRUE
  ))

  expect_snapshot_file(file)

  file.remove(file)
  file.remove(paste0(file, ".bk1"))
})
