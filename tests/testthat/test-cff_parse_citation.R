test_that("Test citations with installed packages", {
  installed <- as.character(installed.packages()[, 1])
  inst <- c(
    "base", "utils", "jsonlite", "jsonvalidate", "rmarkdown",
    "rgeos", "thisisanerrorpackage", "DCluster", "surveillance"
  )
  for (i in seq_len(length(inst))) {
    if (inst[i] %in% installed) {
      desc <- cff_create(inst[i])
      cit <- cff_parse_citation(citation(inst[i]))
      full <- as.cff(c(desc, list("preferred-citation" = cit)))
      expect_true(cff_validate(full))
    }
  }
})

test_that("Test full with CITATION and (option = author)", {

  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)
  expect_s3_class(parsed, "bibentry")

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    references = lapply(parsed, cff_parse_citation)
  ))

  expect_s3_class(cffobj, "cff")
  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj))
})

test_that("Add wrong field to citation", {
  bib <- bibentry(
    bibtype = "Manual",
    title = "favoritefood is not valid on cff schema",
    author = "Jane Smith",
    favoritefood = "bananas",
    type = "I should be removed"
  )

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj))
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

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj))
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

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj))
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

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj))
})


test_that("Article", {
  bib <- bibentry("Article",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    journal = "JOSS",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})


test_that("Book", {
  bib <- bibentry("Book",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    month = "August",
    publisher = "Graham Hill",
    chapter = "A chapter",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})

test_that("InBook", {
  bib <- bibentry("InBook",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    month = "August",
    publisher = "Graham Hill",
    chapter = "A chapter",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})

test_that("InCollection", {
  bib <- bibentry("InCollection",
    title = "A Language and Environment for Statistical Computing",
    booktitle = "A book",
    year = "2021",
    month = "August",
    publisher = "Graham Hill",
    chapter = "A chapter",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})


test_that("InProceedings", {
  bib <- bibentry("InProceedings",
    title = "A Language and Environment for Statistical Computing",
    booktitle = "A book",
    year = "2021",
    month = "August",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})


test_that("Manual", {
  bib <- bibentry("Manual",
    title = "A Language and Environment for Statistical Computing",
    title = "A book",
    year = "2021",
    month = "August",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})


test_that("MastersThesis", {
  bib <- bibentry("MastersThesis",
    title = "A Language and Environment for Statistical Computing",
    title = "A book",
    year = "2021",
    school = "Trinity College",
    month = "August",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})


test_that("PhdThesis", {
  bib <- bibentry("PhdThesis",
    title = "A Language and Environment for Statistical Computing",
    title = "A book",
    year = "2021",
    school = "Trinity College",
    month = "August",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})


test_that("Proceedings", {
  bib <- bibentry("Proceedings",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    month = "August",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})

test_that("TechReport", {
  bib <- bibentry("TechReport",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    institution = "MIT",
    month = "aug",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})

test_that("Unpublished", {
  bib <- bibentry("Unpublished",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    note = "Not published",
    month = "8",
    author = person("R Core Team")
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})


test_that("Parse persons on CITATION", {
  bib <- bibentry("Manual",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    author = person("R Core Team"),
    contact = person("A", "name"),
    conference = person("A", "conference"),
    "database-provider" = person("Database", "provider"),
    editors = person("A", "editor"),
    "editors-series" = person("A", "editor series"),
    "institution" = person("A", "institution"),
    "location" = person("A", "location"),
    "publisher" = person("A", "publisher"),
    "recipients" = person("A", "recipient"),
    "senders" = person("A", "sender"),
    "translators" = c(
      person("Translator", "one"),
      person("Translator", "two")
    )
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})

test_that("Test inputs", {
  bib <- c(1:5)
  expect_null(cff_parse_citation(bib))

  # Remove type

  bib <- bibentry("Book",
    title = "Test",
    author = "Billy Jean",
    year = "2021",
    publisher = "Random House",
    type = "RANDOM"
  )


  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj))
})

test_that("NULL bibs and others strange errors", {
  bib <- 1
  class(bib) <- "bibentry"
  bib <- NULL
  expect_null(cff_parse_citation(bib))
})
