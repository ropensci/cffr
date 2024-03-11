# Underlying tests in as_bibentry
# Corner cases here

test_that("citations with installed packages", {
  installed <- as.character(installed.packages()[, 1])
  inst <- c("base", "jsonlite", "rmarkdown")
  for (i in seq_len(length(inst))) {
    if (inst[i] %in% installed) {
      desc <- cff_create(inst[i])
      expect_true(length(desc$`preferred-citation`) > 1)
      expect_true(cff_validate(desc, verbose = FALSE))
    }
  }
})

test_that("Test full with CITATION and (option = author)", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  parsed <- cff_safe_read_citation(desc_path, cit_path)
  expect_s3_class(parsed, "cff")

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    references = parsed
  ))

  expect_s3_class(cffobj, "cff")
  expect_snapshot(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Parsed several citations", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  citobj <- cff_safe_read_citation(desc_path, cit_path)
  expect_s3_class(citobj, c("cff_ref_lst", "cff"), exact = TRUE)

  expect_snapshot(citobj)
  expect_length(citobj, 3)
})


test_that("Add wrong field to citation", {
  bib <- bibentry(
    bibtype = "Manual",
    title = "favoritefood is not valid on cff schema",
    author = "Jane Smith",
    favoritefood = "bananas",
    type = "I should be removed"
  )

  bibparsed <- as_cff(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = bibparsed
    )
  )

  expect_snapshot(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Fix wrong orcid", {
  bib <- bibentry(
    bibtype = "Manual",
    title = "Wrong orcid fixed by cffr",
    author = person("Jane",
      "Smith",
      comment = c(
        ORCID =
          "http://orcid.org/0000-0000-0000-306X"
      )
    )
  )

  bibparsed <- as_cff(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(references = bibparsed)
  )

  expect_snapshot(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Several identifiers and duplicates", {
  bib <- bibentry(
    bibtype = "Manual",
    title = "A Language and Environment for Statistical Computing",
    year = "2022",
    year = "2023",
    author = person("R Core Team"),
    version = NULL,
    error = "",
    url = "https://www.R-project.org/",
    url = "https://google.com/",
    doi = "10.5281/zenodo.5366600",
    doi = "10.5281/zenodo.5366601",
    doi = "10.5281/zenodo.5366602",
    identifiers = "a,b"
  )

  bibparsed <- as_cff(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = bibparsed
    )
  )

  expect_snapshot(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Test keywords and urls", {
  bib <- bibentry(
    bibtype = "Manual",
    title = "A Language and Environment for Statistical Computing",
    year = "2022",
    author = person("R Core Team"),
    url = "https://www.R-project.org/",
    url = "https://google.com/",
    keywords = "Some, random keywords, in, here, here"
  )

  bibparsed <- as_cff(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = bibparsed
    )
  )

  expect_snapshot(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Coerce persons on CITATION", {
  bib <- bibentry("Manual",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    author = person("R Core Team"),
    contact = "A name and A contact",
    conference = person("A", "conference"),
    "database-provider" = person("Database", "provider"),
    editors = "A editor and {Ben and Jerry}",
    "editors-series" = "An {editor series} and Another",
    "institution" = person("A", "institution"),
    "address" = person("A", "location"),
    "publisher" = person("A", "publisher"),
    "recipients" = "A recipient",
    "senders" = "{A Sender} and Another Sender",
    "translators" = "Translator one and Translator two"
  )

  bibparsed <- as_cff(bib)
  expect_snapshot(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = bibparsed)
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Test inputs", {
  # Remove type

  bib <- bibentry("Book",
    title = "Test",
    author = "Billy Jean",
    year = "2021",
    publisher = "Random House",
    type = "RANDOM"
  )


  bibparsed <- as_cff(bib)
  expect_snapshot(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = bibparsed)
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Fallback date", {
  bib <- bibentry("Misc",
    title = "Test",
    author = "Billy Jean",
    date = "2050-01-12",
    urldate = "2099-02-02",
    publisher = "Random House",
    type = "RANDOM"
  )

  init_cff <- as_cff(bib)

  expect_snapshot(init_cff)
})

test_that("Duplicates", {
  bib <- bibentry("Misc",
    title = "Test",
    author = "Billy Jean",
    date = "2050-01-12",
    urldate = "2099-02-02",
    publisher = "Random House",
    type = "RANDOM"
  )
  bib2 <- bibentry("Manual",
    title = "Test",
    author = "Billy Jean",
    date = "2050-01-12",
    urldate = "2099-02-02",
    publisher = "Random House",
    type = "RANDOM"
  )
  bibend <- c(rep(bib, 3), bib2)
  expect_snapshot(uniq <- as_cff(bibend))
  expect_length(uniq, 2)
})
