test_that("cff_write_bib() errors on unsupported input", {
  expect_snapshot(cff_write_bib(1:4), error = TRUE)
})

test_that("cff_write_bib() writes BibTeX files", {
  bib <- bibentry("Misc", title = "My title", author = "Fran P<U+00E9>rez")

  file <- file.path(tempdir(), "noext")
  expect_message(cff_write_bib(bib, file, verbose = TRUE), "Writing 4 lines")

  # Fix extensions
  file <- paste0(file, ".bib")
  withr::defer(unlink(file, force = TRUE))
  withr::defer(unlink(paste0(file, ".bk1"), force = TRUE))
  expect_true(file_exist_abort(file))

  skip_if(!isTRUE(l10n_info()[["UTF-8"]]), "Snapshot created with UTF-8 locale")
  expect_snapshot_file(file)

  # Check backup
  expect_false(file_exist_abort(paste0(file, ".bk1")))

  # Check now backup exists
  cff_write_bib(bib, file, append = TRUE)
  expect_true(file_exist_abort(paste0(file, ".bk1")))
})

test_that("cff_write_bib() writes ASCII BibTeX files", {
  bib <- bibentry("Misc", title = "My title", author = "Fran P<U+00E9>rez")

  file <- file.path(tempdir(), "ascii.bib")
  withr::defer(unlink(file, force = TRUE))
  expect_silent(cff_write_bib(bib, file, verbose = FALSE, ascii = TRUE))

  # Fix extensions
  skip_if(!isTRUE(l10n_info()[["UTF-8"]]), "Snapshot created with UTF-8 locale")
  expect_snapshot_file(file)
})

test_that("cff_write_bib() appends entries", {
  bib <- bibentry("Misc", title = "My title", author = "Fran Herrero")
  cf <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  a_cff <- cff_read(cf)

  file <- file.path(tempdir(), "append.bib")
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
  expect_true(all(lines1 == lines2[seq_along(lines1)]))

  expect_gt(length(lines2), length(lines1))

  # Overwrite
  cff_write_bib(bib2, file, verbose = FALSE, append = FALSE)
  lines3 <- readLines(file)

  expect_false(all(lines1 == lines3[seq_along(lines1)]))
  expect_lt(length(lines3), length(lines2))
})


test_that("cff_write_bib() creates parent directories", {
  bib <- bibentry("Misc", title = "My title", author = "Fran Herrero")

  root <- withr::local_tempdir()
  file <- file.path(root, "idontexist", "append.bib")

  dir <- dirname(file)

  expect_false(dir.exists(dir))
  expect_silent(cff_write_bib(bib, file, verbose = FALSE))

  expect_true(dir.exists(dir))
  expect_true(file_exist_abort(file))

  # With messages
  file <- file.path(root, "nowiamverbose", "append.bib")
  dir <- dirname(file)
  expect_false(dir.exists(dir))
  expect_message(cff_write_bib(bib, file, verbose = TRUE), "Creating directory")

  expect_true(dir.exists(dir))
  expect_true(file_exist_abort(file))
})

test_that("write_lines_msg reports lines, not entries", {
  file <- withr::local_tempfile()

  expect_message(
    write_lines_msg(c("a", "", "b"), file, TRUE, FALSE),
    "Writing 2 lines"
  )
})

test_that("cff_write_citation() errors on unsupported input", {
  expect_snapshot(cff_write_citation(1:4), error = TRUE)
})

test_that("cff_write_citation() writes CITATION files", {
  f <- system.file("examples", package = "cffr")
  thepath <- list.files(f, pattern = "DESCRIPTION_basicdate", full.names = TRUE)
  f1 <- cff_read(thepath)

  bib <- bibentry("Misc", title = "My title", author = "Fran P<U+00E9>rez")

  file <- file.path(tempdir(), "CITAT_ION")
  withr::defer(unlink(file, force = TRUE))
  withr::defer(unlink(paste0(file, ".bk1"), force = TRUE))
  expect_message(cff_write_citation(bib, file, verbose = TRUE))

  # Check backup
  expect_false(file_exist_abort(paste0(file, ".bk1")))

  # Check now backup exists and use cff
  expect_silent(cff_write_citation(
    f1,
    file,
    verbose = FALSE,
    what = "all",
    append = TRUE
  ))

  skip_if(!isTRUE(l10n_info()[["UTF-8"]]), "Snapshot created with UTF-8 locale")
  expect_snapshot_file(file)
})
