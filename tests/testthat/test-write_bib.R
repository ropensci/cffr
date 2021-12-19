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

test_that("Test append", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Herrero"
  )

  file <- file.path(tempdir(), "append.bib")
  expect_silent(write_bib(bib, file, verbose = FALSE, append = FALSE))

  # Initial lines
  lines1 <- readLines(file)

  # Append
  bib2 <- bibentry("Misc",
    key = "key2",
    title = "Another title",
    author = "Ian Henderson"
  )


  write_bib(bib2, file, verbose = FALSE, append = TRUE)
  expect_snapshot_file(file)

  lines2 <- readLines(file)

  # First lines identical, more lines on append
  expect_true(all(lines1 == lines2[seq_len(length(lines1))]))

  expect_gt(length(lines2), length(lines1))

  # Overwrite
  write_bib(bib2, file, verbose = FALSE, append = FALSE)
  lines3 <- readLines(file)

  expect_false(all(lines1 == lines3[seq_len(length(lines1))]))
  expect_lt(length(lines3), length(lines2))
})
