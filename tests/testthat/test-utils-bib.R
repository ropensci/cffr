test_that("get_bib_month parses valid months and rejects invalid ones", {
  x <- list(month = "1")
  expect_identical(get_bib_month(x), "jan")

  x <- list("date-published" = "2027-02-10")

  expect_identical(get_bib_month(x), "feb")
})

test_that("CFF publication types map to the expected BibTeX types", {
  types <- c(
    "article",
    "book",
    "manual",
    "unpublished",
    "conference",
    "conference-paper",
    "proceedings",
    "magazine-article",
    "newspaper-article",
    "pamphlet",
    "report",
    "thesis",
    "software"
  )

  bibtypes <- vapply(
    types,
    \(type) guess_bibtype(list(type = type)),
    character(1)
  )

  expect_identical(
    unname(bibtypes),
    c(
      "article",
      "book",
      "manual",
      "unpublished",
      "inproceedings",
      "inproceedings",
      "proceedings",
      "article",
      "article",
      "booklet",
      "techreport",
      "mastersthesis",
      "misc"
    )
  )
})
