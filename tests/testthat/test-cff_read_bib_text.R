test_that("Errors and messages", {
  skip_if_not_installed("bibtex", "0.5.0")
  a_cff <- cff()
  expect_snapshot(cff_read_bib_text(a_cff), error = TRUE)
  expect_snapshot(cff_read_bib_text("a bad line"), error = TRUE)
})

test_that("Read lines", {
  skip_if_not_installed("bibtex", "0.5.0")

  x <- c(
    "@book{einstein1921,
    title        = {Relativity: The Special and the General Theory},
    author       = {Einstein, Albert},
    year         = 1920,
    publisher    = {Henry Holt and Company},
    address      = {London, United Kingdom},
    isbn         = 9781587340925
}",
    "@misc{misc-full,
    title        = {Handing out random pamphlets in airports},
    author       = {Joe-Bob Missilany},
    year         = 1984,
    month        = oct,
    note         = {This is a full MISC entry},
    howpublished = {Handed out at O'Hare}
}"
  )

  list <- cff_read_bib_text(x)

  expect_s3_class(list, "cff")
  expect_length(list, 2)

  expect_snapshot(list)

  # Create a Bibtex file with that lines
  tmpbib <- tempfile(fileext = ".bib")
  writeLines(x, tmpbib)

  expect_snapshot(fromfile <- cff_read_bib_text(tmpbib))
  expect_identical(fromfile, list)
})
