test_that("cff_write_bib rejects non-bibentry inputs", {
  expect_snapshot(cff_write_bib(1:4), error = TRUE)
})

test_that("cff_write_bib writes files and creates backups", {
  bib <- bibentry("Misc", title = "My title", author = "Fran Pérez")

  root <- withr::local_tempdir()
  file <- file.path(root, "noext")
  expect_message(cff_write_bib(bib, file, verbose = TRUE), "Writing 4 lines")

  # Fix extensions
  file <- paste0(file, ".bib")
  expect_true(file.exists(file))

  expect_snapshot_file(file)

  # Check backup
  expect_false(file.exists(paste0(file, ".bk1")))

  # Check now backup exists
  cff_write_bib(bib, file, append = TRUE)
  expect_true(file.exists(paste0(file, ".bk1")))
})

test_that("cff_write_bib transliterates output to ASCII", {
  bib <- bibentry("Misc", title = "My title", author = "Fran Pérez")

  root <- withr::local_tempdir()
  file <- file.path(root, "ascii.bib")
  expect_silent(cff_write_bib(bib, file, verbose = FALSE, ascii = TRUE))

  # Fix extensions
  expect_snapshot_file(file)
})

test_that("cff_write_bib appends entries and supports overwrite", {
  bib <- bibentry("Misc", title = "My title", author = "Fran Herrero")
  cf <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  a_cff <- cff_read(cf)

  root <- withr::local_tempdir()
  file <- file.path(root, "append.bib")
  expect_silent(cff_write_bib(bib, file, verbose = FALSE, append = FALSE))

  # Initial lines
  lines1 <- readLines(file)

  # Append
  bib2 <- bibentry(
    "Misc",
    key = "key2",
    title = "Another title",
    author = "Ian Henderson"
  )

  cff_write_bib(bib2, file, verbose = FALSE, append = TRUE)
  cff_write_bib(a_cff, file, verbose = FALSE, append = TRUE)
  expect_snapshot_file(file)

  lines2 <- readLines(file)

  # First lines identical, more lines on append
  expect_equal(lines2[seq_along(lines1)], lines1)

  expect_gt(length(lines2), length(lines1))

  # Overwrite
  cff_write_bib(bib2, file, verbose = FALSE, append = FALSE)
  lines3 <- readLines(file)

  expect_false(identical(lines3[seq_along(lines1)], lines1))
  expect_lt(length(lines3), length(lines2))
})


test_that("cff_write_bib creates missing output directories", {
  bib <- bibentry("Misc", title = "My title", author = "Fran Herrero")

  root <- withr::local_tempdir()
  file <- file.path(root, "idontexist", "append.bib")

  dir <- dirname(file)

  expect_false(dir.exists(dir))
  expect_silent(cff_write_bib(bib, file, verbose = FALSE))

  expect_true(dir.exists(dir))
  expect_true(file.exists(file))

  # With messages
  file <- file.path(root, "nowiamverbose", "append.bib")
  dir <- dirname(file)
  expect_false(dir.exists(dir))
  expect_message(cff_write_bib(bib, file, verbose = TRUE), "Creating directory")

  expect_true(dir.exists(dir))
  expect_true(file.exists(file))
})

test_that("write_lines_msg reports lines, not entries", {
  file <- withr::local_tempfile()

  expect_message(
    write_lines_msg(c("a", "", "b"), file, TRUE, FALSE),
    "Writing 3 lines"
  )
})

test_that("cff_write_citation rejects non-bibentry inputs", {
  expect_snapshot(cff_write_citation(1:4), error = TRUE)
})

test_that("cff_write_citation writes and appends citations", {
  f <- system.file("examples", package = "cffr")
  thepath <- list.files(f, pattern = "DESCRIPTION_basicdate", full.names = TRUE)
  f1 <- cff_read(thepath)

  bib <- bibentry("Misc", title = "My title", author = "Fran Pérez")

  root <- withr::local_tempdir()
  file <- file.path(root, "CITAT_ION")
  expect_message(cff_write_citation(bib, file, verbose = TRUE))

  # Check backup
  expect_false(file.exists(paste0(file, ".bk1")))

  # Check now backup exists and use cff
  expect_silent(cff_write_citation(
    f1,
    file,
    verbose = FALSE,
    what = "all",
    append = TRUE
  ))

  expect_snapshot_file(file)
})
