test_that("fallback_dates normalizes reference dates", {
  xinit <- list(year = "2025")
  p <- fallback_dates(list(year = "2025"))
  expect_identical(xinit, p)

  p2 <- fallback_dates(list("date-published" = "2025-09-25"))
  expect_snapshot(as_cff(p2))
})

test_that("BibLaTeX partial dates retain their available precision", {
  partial <- bibentry(
    "Misc",
    title = "Partial publication date",
    author = "A. Author",
    date = "2024-05"
  )
  partial_ref <- as_cff(partial)

  expect_identical(partial_ref[[1]]$year, "2024")
  expect_identical(partial_ref[[1]]$month, "5")
  expect_null(partial_ref[[1]]$`date-published`)

  partial_cff <- cff_create(cff(), keys = list(references = partial_ref))
  expect_true(cff_validate(partial_cff, verbose = FALSE))

  inaccessible <- bibentry(
    "Misc",
    title = "Partial access date",
    author = "A. Author",
    urldate = "2024-05"
  )
  inaccessible_ref <- as_cff(inaccessible)

  expect_identical(inaccessible_ref[[1]]$`date-accessed`, "2024-05")

  inaccessible_cff <- cff_create(
    cff(),
    keys = list(references = inaccessible_ref)
  )
  expect_false(cff_validate(inaccessible_cff, verbose = FALSE))
})

test_that("BibTeX keywords omit empty values", {
  bib <- bibentry(
    "Misc",
    title = "Keyword cleanup",
    author = "A. Author",
    year = "2020",
    keywords = ", java, , java"
  )
  refs <- as_cff(bib)
  expect_identical(refs[[1]]$keywords, list("java"))

  cffobj <- cff_create(cff(), keys = list(references = refs))
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("get_bibtex_inst preserves the available institution metadata", {
  generic <- list(bibtex_entry = "manual", institution = "Generic institution")
  expect_identical(get_bibtex_inst(generic), generic)

  specific <- list(
    bibtex_entry = "manual",
    institution = "Generic institution",
    organization = "Specific organization"
  )
  expect_identical(
    get_bibtex_inst(specific),
    list(bibtex_entry = "manual", institution = "Specific organization")
  )

  blank_specific <- list(
    bibtex_entry = "manual",
    institution = "Generic institution",
    organization = "  "
  )
  expect_identical(get_bibtex_inst(blank_specific), blank_specific)

  missing_specific <- list(
    bibtex_entry = "manual",
    institution = "Generic institution",
    organization = NA_character_
  )
  expect_identical(get_bibtex_inst(missing_specific), missing_specific)

  thesis <- list(bibtex_entry = "phdthesis", institution = "Thesis institution")
  expect_identical(get_bibtex_inst(thesis), thesis)

  bib <- bibentry(
    "Manual",
    title = "A manual",
    author = "A. Author",
    year = "2020",
    institution = "Generic institution",
    organization = "  "
  )
  refs <- as_cff(bib)
  cffobj <- cff_create(cff(), keys = list(references = refs))
  expect_identical(
    cffobj$references[[1]]$institution$name,
    "Generic institution"
  )
  expect_null(cffobj$references[[1]]$organization)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("add_bibtex_coltype identifies book series", {
  book <- list(bibtex_entry = "book", `collection-title` = "A book series")
  inbook <- list(bibtex_entry = "inbook", `collection-title` = "A book series")
  incollection <- list(
    bibtex_entry = "incollection",
    `collection-title` = "A collection"
  )

  expect_identical(add_bibtex_coltype(book)$`collection-type`, "book-series")
  expect_identical(add_bibtex_coltype(inbook)$`collection-type`, "book-series")
  expect_identical(
    add_bibtex_coltype(incollection)$`collection-type`,
    "collection"
  )

  bib <- bibentry(
    "Book",
    title = "A book",
    author = "A. Author",
    year = "2020",
    publisher = "A publisher",
    series = "A book series"
  )
  refs <- as_cff(bib)
  cffobj <- cff_create(cff(), keys = list(references = refs))
  expect_identical(cffobj$references[[1]]$`collection-type`, "book-series")
  expect_identical(cffobj$references[[1]]$`collection-title`, "A book series")
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("DOI resolver URLs are classified independently", {
  fields <- list(
    doi = "10.1000/primary",
    url = c(
      "https://example.org/doi.org/about",
      "https://dx.doi.org/10.1000/secondary",
      "http://doi.org/10.1000/tertiary"
    )
  )

  expect_identical(
    get_bibtex_doi(fields),
    list(
      doi = "10.1000/primary",
      identifiers = list(
        list(type = "doi", value = "10.1000/secondary"),
        list(type = "doi", value = "10.1000/tertiary")
      )
    )
  )
  expect_identical(
    get_bibtex_url(fields),
    list(
      url = "https://example.org/doi.org/about",
      identifiers = list(
        list(type = "url", value = "https://dx.doi.org/10.1000/secondary"),
        list(type = "url", value = "http://doi.org/10.1000/tertiary")
      )
    )
  )

  packed <- list(url = "https://example.org, https://doi.org/10.1000/packed")
  expect_identical(
    get_bibtex_doi(packed),
    list(doi = "10.1000/packed", identifiers = NULL)
  )
  expect_identical(
    get_bibtex_url(packed),
    list(
      url = "https://example.org",
      identifiers = list(list(
        type = "url",
        value = "https://doi.org/10.1000/packed"
      ))
    )
  )

  bib <- bibentry(
    "Misc",
    title = "Packed URLs",
    author = "A. Author",
    year = "2020",
    url = packed$url
  )
  cffobj <- cff_create(cff(), keys = list(references = as_cff(bib)))
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("non-DOI resolver paths remain URLs", {
  resolver <- "https://doi.org/about"
  fields <- list(url = resolver)
  expect_identical(get_bibtex_doi(fields), list(doi = NULL, identifiers = NULL))

  bib <- bibentry(
    "Misc",
    title = "DOI resolver page",
    author = "A. Author",
    year = "2020",
    url = resolver
  )
  refs <- as_cff(bib)
  expect_null(refs[[1]]$doi)
  expect_identical(refs[[1]]$url, resolver)

  cffobj <- cff_create(cff(), keys = list(references = refs))
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("BibTeX URLs preserve legal commas", {
  packed <- list(
    url = "https://example.org/?q=a,b, https://doi.org/10.1000/packed"
  )
  expect_identical(
    get_bibtex_url_values(packed),
    c("https://example.org/?q=a,b", "https://doi.org/10.1000/packed")
  )

  bib <- bibentry(
    "Misc",
    title = "URL commas",
    author = "A. Author",
    year = "2020",
    url = packed$url
  )
  refs <- as_cff(bib)
  expect_identical(refs[[1]]$url, "https://example.org/?q=a,b")

  cffobj <- cff_create(cff(), keys = list(references = refs))
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("BibTeX URLs omit duplicate values", {
  fields <- list(url = rep("https://example.org", 3))
  expect_identical(get_bibtex_url_values(fields), "https://example.org")

  bib <- bibentry(
    "Misc",
    title = "Duplicate URLs",
    author = "A. Author",
    year = "2020",
    url = fields$url
  )
  refs <- as_cff(bib)
  expect_identical(refs[[1]]$url, "https://example.org")
  expect_null(refs[[1]]$identifiers)

  cffobj <- cff_create(cff(), keys = list(references = refs))
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("DOI resolver query and fragment are not DOI metadata", {
  resolver <- "https://doi.org/10.1000/resolver?download=1#section"
  explicit <- "10.1000/explicit?edition=1"
  fields <- list(doi = explicit, url = resolver)
  expect_identical(
    get_bibtex_doi(fields),
    list(
      doi = explicit,
      identifiers = list(list(type = "doi", value = "10.1000/resolver"))
    )
  )

  invalid_bib <- bibentry(
    "Misc",
    title = "Explicit DOI",
    author = "A. Author",
    year = "2020",
    doi = explicit
  )
  invalid_refs <- as_cff(invalid_bib)
  expect_identical(invalid_refs[[1]]$doi, explicit)

  invalid_cff <- cff_create(cff(), keys = list(references = invalid_refs))
  expect_false(cff_validate(invalid_cff, verbose = FALSE))

  bib <- bibentry(
    "Misc",
    title = "DOI resolver components",
    author = "A. Author",
    year = "2020",
    url = resolver
  )
  refs <- as_cff(bib)
  expect_identical(refs[[1]]$doi, "10.1000/resolver")
  expect_identical(refs[[1]]$url, resolver)

  cffobj <- cff_create(cff(), keys = list(references = refs))
  expect_true(cff_validate(cffobj, verbose = FALSE))
})
