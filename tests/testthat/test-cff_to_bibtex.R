# Examples from https://www.bibtex.com/e/entry-types/

test_that("Article", {
  bib <- bibentry("Article",
    author   = "P. J. Cohen",
    title    = "The independence of the continuum hypothesis",
    journal  = "Proceedings of the National Academy of Sciences",
    year     = 1963,
    volume   = "50",
    number   = "6",
    pages    = "1143--1148"
  )

  bibparsed <- cff_parse_citation(bib)

  cffobj <- cff_create(cff(),
    keys = list("preferred-citation" = bibparsed)
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))

  bibtex <- cff_to_bibtex(cffobj)

  expect_snapshot_output(bibtex)
})

test_that("Book", {
  bib <- bibentry("Book",
    author    = "Leonard Susskind and George Hrabovsky",
    title     = "Classical mechanics: the theoretical minimum",
    publisher = "Penguin Random House",
    address   = "New York, NY",
    year      = 2014
  )

  bibparsed <- cff_parse_citation(bib)

  cffobj <- cff_create(cff(),
    keys = list("preferred-citation" = bibparsed)
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))

  bibtex <- cff_to_bibtex(cffobj)

  expect_snapshot_output(bibtex)
})

test_that("Booklet", {
  bib <- bibentry("Booklet",
    title        = "Canoe tours in {S}weden",
    author       = "Maria Swetla",
    howpublished = "Distributed at the Stockholm Tourist Office",
    month        = "jul",
    year         = 2015
  )

  bibparsed <- cff_parse_citation(bib)

  cffobj <- cff_create(cff(),
    keys = list("preferred-citation" = bibparsed)
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))

  bibtex <- cff_to_bibtex(cffobj)

  expect_snapshot_output(bibtex)
})

test_that("InBook", {
  bib <- bibentry("InBook",
    author = "Lisa A. Urry and Michael L. Cain and Steven A. Wasserman and Peter V. Minorsky and Jane B. Reece",
    title = "Photosynthesis",
    booktitle = "Campbell Biology",
    year = "2016",
    publisher = "Pearson",
    address = "New York, NY",
    pages = "187--221",
    chapter = "7"
  )

  bibparsed <- cff_parse_citation(bib)

  cffobj <- cff_create(cff(),
    keys = list("preferred-citation" = bibparsed)
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))

  bibtex <- cff_to_bibtex(cffobj)

  expect_snapshot_output(bibtex)
})
