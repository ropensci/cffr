test_that("Write", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  file <- file.path(tempdir(), "noext")
  expect_message(write_citation(bib, file, verbose = TRUE))

  # Fix extensions

  expect_snapshot_file(file)

  # Check backup
  expect_false(file.exists(paste0(file, ".bk1")))

  # Check now backup exists
  write_citation(bib, file, append = TRUE)
  expect_true(file.exists(paste0(file, ".bk1")))

  file.remove(file)
  file.remove(paste0(file, ".bk1"))
})

test_that("Test append", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Herrero"
  )

  file <- file.path(tempdir(), "append")
  expect_silent(write_citation(bib, file, verbose = FALSE, append = FALSE))

  # Initial lines
  lines1 <- readLines(file)

  # Append
  bib2 <- bibentry("Misc",
    key = "key2",
    title = "Another title",
    author = "Ian Henderson"
  )


  write_citation(bib2, file, verbose = FALSE, append = TRUE)
  expect_snapshot_file(file)

  lines2 <- readLines(file)

  # First lines identical, more lines on append
  expect_true(all(lines1 == lines2[seq_len(length(lines1))]))

  expect_gt(length(lines2), length(lines1))

  # Overwrite
  write_citation(bib2, file, verbose = FALSE, append = FALSE)
  lines3 <- readLines(file)

  expect_false(all(lines1 == lines3[seq_len(length(lines1))]))
  expect_lt(length(lines3), length(lines2))
})


test_that("Test dir creation", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Herrero"
  )

  file <- file.path(tempdir(), "citdontexist", "append")

  dir <- dirname(file)

  expect_false(dir.exists(dir))
  expect_silent(write_citation(bib, file, verbose = FALSE))

  expect_true(dir.exists(dir))
  expect_true(file.exists(file))


  # With messages
  file <- file.path(tempdir(), "citverbose", "append")
  dir <- dirname(file)
  expect_false(dir.exists(dir))
  expect_message(
    write_citation(bib, file, verbose = TRUE),
    "Creating directory"
  )

  expect_true(dir.exists(dir))
  expect_true(file.exists(file))
})


test_that("Results can be parsed", {
  file <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )

  tmp <- tempfile()
  expect_silent(sil <- write_citation(file, tmp, verbose = FALSE))

  expect_s3_class(sil, "bibentry")

  pp <- utils::readCitationFile(tmp, meta = list(Encoding = "UTF-8"))
  expect_snapshot_output(pp)
})
