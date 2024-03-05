# See ´
# https://github.com/citation-file-format/ruby-cff/tree/main/test/files


test_that("preferred-citation-book-missing", {
  x <- system.file("examples/preferred-citation-book-missing.cff",
    package = "cffr"
  )

  expect_snapshot(s <- as_bibentry(x))
})

test_that("preferred-citation-book", {
  x <- system.file("examples/preferred-citation-book.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-conference-paper-2", {
  x <- system.file("examples/preferred-citation-conference-paper-2.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-conference-paper-missing", {
  x <- system.file("examples/preferred-citation-conference-paper-missing.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-conference-paper", {
  x <- system.file("examples/preferred-citation-conference-paper.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-manual", {
  x <- system.file("examples/preferred-citation-manual.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-no-month", {
  x <- system.file("examples/preferred-citation-no-month.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-no-vol", {
  x <- system.file("examples/preferred-citation-no-vol.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})


test_that("preferred-citation-pamphlet", {
  x <- system.file("examples/preferred-citation-pamphlet.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-report-no-institution", {
  x <- system.file("examples/preferred-citation-report-no-institution.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("preferred-citation-report", {
  x <- system.file("examples/preferred-citation-report.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})


test_that("preferred-citation-unpublished", {
  x <- system.file("examples/preferred-citation-unpublished.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("reprozip", {
  x <- system.file("examples/reprozip.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})


test_that("smith-et-al", {
  x <- system.file("examples/smith-et-al.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})

test_that("tidyverse-joss-paper", {
  x <- system.file("examples/tidyverse-joss-paper.cff",
    package = "cffr"
  )

  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})
