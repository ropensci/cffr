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

  expect_s3_class(parsed, "bibentry", exact = TRUE)

  # Test that is a named vector with the keys
  expect_equal(names(parsed), unname(unlist(parsed$key)))

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

test_that("No key", {
  file <- system.file("examples/bibtex_nokey.bib",
    package = "cffr"
  )

  expect_warning(cff_read_bib(file))

  parsed <- suppressWarnings(cff_read_bib(file))
})

test_that("UTF Encoding", {
  skip_on_cran()
  skip_if(R.Version()$major < 4, "On old R version")

  range <- 1:511

  utf8 <- intToUtf8(range, multiple = TRUE)

  ascii_table <- data.frame(
    dec = range
  )

  # Add latex using base approach
  ascii_table$latex_base <- tools::encoded_text_to_latex(utf8,
    encoding = "UTF-8"
  )

  # With cffr
  ascii_table$latex_cffr <- encoded_utf_to_latex(utf8)

  expect_snapshot_output(ascii_table)
})
