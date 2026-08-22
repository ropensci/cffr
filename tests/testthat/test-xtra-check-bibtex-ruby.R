# See ´
# https://github.com/citation-file-format/ruby-cff/tree/main/test/files

test_that("Ruby CFF book fixture reports missing fields", {
  x <- system.file(
    "examples/preferred-citation-book-missing.cff",
    package = "cffr"
  )

  expect_snapshot(s <- as_bibentry(x))
})

test_that("Ruby CFF book fixture converts to BibTeX", {
  x <- system.file("examples/preferred-citation-book.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF alternate conference fixture converts to BibTeX", {
  x <- system.file(
    "examples/preferred-citation-conference-paper-2.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF conference fixture reports missing fields", {
  x <- system.file(
    "examples/preferred-citation-conference-paper-missing.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF conference fixture converts to BibTeX", {
  x <- system.file(
    "examples/preferred-citation-conference-paper.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF manual fixture converts to BibTeX", {
  x <- system.file("examples/preferred-citation-manual.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF fixture supports missing months", {
  x <- system.file("examples/preferred-citation-no-month.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF fixture supports missing volumes", {
  x <- system.file("examples/preferred-citation-no-vol.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF pamphlet fixture converts to BibTeX", {
  x <- system.file("examples/preferred-citation-pamphlet.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF report fixture supports missing institutions", {
  x <- system.file(
    "examples/preferred-citation-report-no-institution.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("Ruby CFF report fixture converts to BibTeX", {
  x <- system.file("examples/preferred-citation-report.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})


test_that("Ruby CFF unpublished fixture converts to BibTeX", {
  x <- system.file(
    "examples/preferred-citation-unpublished.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("ReproZip fixture converts to BibTeX", {
  x <- system.file("examples/reprozip.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})


test_that("Smith et al fixture converts to BibTeX", {
  x <- system.file("examples/smith-et-al.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("tidyverse JOSS fixture converts to BibTeX", {
  x <- system.file("examples/tidyverse-joss-paper.cff", package = "cffr")

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})
