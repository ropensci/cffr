test_that("Test citations with installed packages", {
  installed <- as.character(installed.packages()[, 1])
  inst <- c(
    "base", "utils", "jsonlite", "jsonvalidate", "rmarkdown",
    "rgeos", "urltools", "thisisanerrorpackage"
  )
  for (i in seq_len(length(inst))) {
    if (inst[i] %in% installed) {
      print(paste("Testing", inst[i]))
      desc <- file.path(find.package(inst[i]))
      desc_cff <- cff_description(file.path(desc, "DESCRIPTION"))
      cit <- cff_parse_citation(citation(inst[i]))
      full <- as.cff(c(desc_cff, list("preferred-citation" = cit)))
      expect_true(cff_validate(full))
    }
  }
})

test_that("Add wrong field to citation", {
  bib <- bibentry(
    bibtype = "InProceedings",
    booktitle = "Some Title",
    title = "Bootstrap Methods and Their Applications",
    author = as.person("Anthony C. Davison [aut], David V. Hinkley [aut]"),
    year = "1997",
    publisher = person(
      given = "Cambridge University Press",
      comment = c("address" = "Madrid")
    ),
    # translators = "Juan Tenorio",
    address = "Cambridge",
    url = "http://statwww.epfl.ch/davison/BMA/",
    key = "boot-book",
    type = "errortype",
    favorite_food = "bananas"
  )

  cffobj <- cff_create("jsonlite",
    keys = list(
      references = list(
        cff_parse_citation(
          bib
        )
      )
    )
  )


  expect_true(cff_validate(cffobj))
})

test_that("Several identifiers and duplicates", {
  bib <- bibentry(
    bibtype = "Manual",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    year = "2023",
    author = person("R Core Team"),
    version = NULL,
    error = "",
    url = "https://www.R-project.org/",
    url = "https://google.com/",
    doi = "10.5281/zenodo.5366600",
    doi = "10.5281/zenodo.5366601",
    doi = "10.5281/zenodo.5366602"
  )

  cffobj <- cff_create(cff(),
    keys = list(references = list(
      cff_parse_citation(
        bib
      )
    ))
  )

  expect_true(cff_validate(cffobj))

  expect_snapshot(cffobj)
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
