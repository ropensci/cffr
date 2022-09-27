test_that("test errors", {
  x <- c(1, 2, 3)
  expect_error(cff_from_bibtex(x))

  x <- cff()
  expect_error(cff_from_bibtex(x))
})

test_that("Read from file", {
  skip_if_not_installed("bibtex", "0.5.0")

  x <- system.file("REFERENCES.bib", package = "cffr")

  list <- cff_from_bibtex(x)

  expect_s3_class(list, "cff")
  expect_gt(length(list), 1)


  # With encodings

  x2 <- system.file("examples/example.bib", package = "cffr")
  fromfile <- cff_from_bibtex(x2)
  expect_s3_class(fromfile, "cff")
  expect_length(fromfile, 2)

  d <- fromfile[[2]]

  expect_snapshot_output(d)
})


test_that("From Bibtex entries", {
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

  list <- cff_from_bibtex(x)

  expect_s3_class(list, "cff")
  expect_length(list, 2)

  expect_snapshot_output(list)
})
