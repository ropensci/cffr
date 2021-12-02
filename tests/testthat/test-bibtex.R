test_that("Read bibtex example", {
  file <- system.file("examples/bibtex_example.bib",
    package = "cffr"
  )
  parsed <- cff_read_bib(file)

  expect_snapshot_output(toBibtex(parsed))
})
test_that("Read bibtex example cff", {
  file <- system.file("examples/bibtex_example.bib",
    package = "cffr"
  )
  parsed <- cff_read_bib(file)

  expect_snapshot_output(cff_parse_citation(parsed))
})
test_that("Read bibtex full", {
  file <- system.file("examples/bibtex_test.bib",
    package = "cffr"
  )
  parsed <- cff_read_bib(file)

  expect_snapshot_output(toBibtex(parsed))
})

test_that("Read bibtex full cff", {
  file <- system.file("examples/bibtex_test.bib",
    package = "cffr"
  )
  parsed <- cff_read_bib(file)

  expect_snapshot_output(cff_parse_citation(parsed))
})

test_that("Read bibtex misc", {
  file <- system.file("examples/bibtex_misc.bib",
    package = "cffr"
  )

  expect_warning(cff_read_bib(file))

  parsed <- suppressWarnings(cff_read_bib(file))

  expect_snapshot_output(toBibtex(parsed))
})

test_that("Read bibtex misc cff", {
  file <- system.file("examples/bibtex_misc.bib",
    package = "cffr"
  )

  expect_warning((cff_read_bib(file)))

  parsed <- suppressWarnings(cff_read_bib(file))

  expect_snapshot_output(cff_parse_citation(parsed))
})

test_that("Read bibtex ascii", {
  file <- system.file("examples/bibtex_ascii.bib",
    package = "cffr"
  )

  parsed <- cff_read_bib(file)

  expect_snapshot_output(toBibtex(parsed))
})

test_that("Read bibtex ascii cff", {
  file <- system.file("examples/bibtex_ascii.bib",
    package = "cffr"
  )

  parsed <- cff_read_bib(file)

  expect_snapshot_output(cff_parse_citation(parsed))
})

test_that("Read Error", {
  file <- system.file("examples/bibtex_malformed.bib",
    package = "cffr"
  )

  expect_error(cff_read_bib(file))
})
