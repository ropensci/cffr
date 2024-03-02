test_that("cff_extract_to_bibtex", {
  a_cff <- cff_create("cffr")

  current <- as_bibentry(a_cff)
  expect_snapshot(old1 <- cff_extract_to_bibtex(a_cff))

  expect_identical(current, old1)
})

test_that("cff_to_bibtex", {
  a_cff <- cff_create("cffr")

  current <- as_bibentry(a_cff)
  expect_snapshot(old1 <- cff_to_bibtex(a_cff))

  expect_identical(current, old1)
})

test_that("cff_from_bibtex", {
  # From file
  x2 <- system.file("examples/example.bib", package = "cffr")
  expect_snapshot(ffile <- cff_from_bibtex(x2))
  expect_identical(ffile, cff_read_bib(x2))

  # From lines
  x <- "@book{einstein1921,
          title        = {Relativity: The Special and the General Theory},
          author       = {Einstein, Albert},
          year         = 1920,
          publisher    = {Henry Holt and Company},
          address      = {London, United Kingdom},
          isbn         = 9781587340925
      }"

  expect_snapshot(flines <- cff_from_bibtex(x))
  expect_identical(flines, cff_read_bib_text(x))
})

test_that("write_bib", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  tmp <- tempfile(fileext = ".bib")
  expect_snapshot(write_bib(bib, tmp, verbose = FALSE))

  expect_snapshot(cat(readLines(tmp), sep = "\n"))
})

test_that("write_citation", {
  bib <- bibentry("Misc",
    title = "My title",
    author = "Fran Pérez"
  )

  tmp <- tempfile("CIT_ATION")
  expect_snapshot(write_citation(bib, tmp, verbose = FALSE))

  expect_snapshot(cat(readLines(tmp), sep = "\n"))
})


test_that("cff_parse_person", {
  p <- person("A", "person")
  expect_snapshot(pend <- cff_parse_person(p))

  expect_identical(pend, as_cff_person(p))
})

test_that("cff_parse_person_bibtex", {
  p <- "{Elephant and Castle}"
  expect_snapshot(pend <- cff_parse_person_bibtex(p))

  expect_identical(pend, as_cff_person(p))
})


test_that("cff_parse_citation", {
  p <- citation("testthat")
  expect_snapshot(pend <- cff_parse_citation(p))

  expect_identical(pend, as_cff(p))
})
