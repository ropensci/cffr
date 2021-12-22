test_that("Test citations with installed packages", {
  installed <- as.character(installed.packages()[, 1])
  inst <- c(
    "base", "utils", "jsonlite", "jsonvalidate", "rmarkdown",
    "thisisanerrorpackage", "DCluster", "surveillance"
  )
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
  parsed <- parse_r_citation(desc_path, cit_path)
  expect_s3_class(parsed, "bibentry")

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    references = lapply(parsed, cff_parse_citation)
  ))

  expect_s3_class(cffobj, "cff")
  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Parsed several citations", {

  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)
  expect_s3_class(parsed, "bibentry")

  # Create citation obj
  citobj <- cff_parse_citation(parsed)

  expect_s3_class(citobj, "cff")
  expect_snapshot_output(citobj)
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

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
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

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
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

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
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

  bibparsed <- cff_parse_citation(bib)

  expect_s3_class(bibparsed, "cff")

  cffobj <- cff_create(cff(),
    keys = list(
      references = list(bibparsed)
    )
  )

  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Article", {
  bib <- bibentry("Article",
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    journal = "JOSS",
    year = "2021",
    # Optional
    volume = "vol1",
    number = 3,
    pages = "3--7",
    month = "January",
    note = "a note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Book", {
  bib <- bibentry("Book",
    author = person("R Core Team"),
    editor = "{Barnes and Noble}",
    title = "A Language and Environment for Statistical Computing",
    publisher = "Graham and Hill",
    year = "2021",
    # Optional
    month = "August",
    chapter = "A chapter",
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Booklet", {
  bib <- bibentry("Booklet",
    title = "Handbook of algorithms and data structures",
    # Optional
    author = "G. H. Gonnet and R. Baeza-Yates",
    howpublished = "booklet",
    address = "Barcelona, ES",
    month = "apr",
    year = "1991",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("InBook", {
  bib <- bibentry("InBook",
    author = person("R Core Team"),
    editor = "{McGraw Hill}",
    title = "A Language and Environment for Statistical Computing",
    chapter = "A chapter",
    pages = "3--7",
    publisher = "Graham Hill",
    year = "2021",
    # Optional
    volume = "vol1",
    number = 3,
    series = "The {R} series",
    type = "A chapter",
    address = "Barcelona, ES",
    edition = "Second",
    month = "January",
    note = "a note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("InCollection", {
  bib <- bibentry("InCollection",
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    booktitle = "A book",
    publisher = "Graham Hill",
    year = "2021",
    # Optional
    editor = "{McGraw Hill}",
    volume = "vol1",
    number = 3,
    series = "The {R} series",
    type = "Some type",
    chapter = "A chapter",
    pages = 123,
    address = "Madrid, ES",
    edition = "Third",
    month = "August",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("InProceedings", {
  bib <- bibentry("InProceedings",
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    booktitle = "A book",
    year = "2021",
    # Optional
    editor = "{McGraw Hill}",
    volume = "vol1",
    number = 3,
    series = "The {R} series",
    pages = 123,
    address = "Madrid, ES",
    organization = "An org",
    publisher = "Graham Hill",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Manual", {
  bib <- bibentry("Manual",
    title = "A Language and Environment for Statistical Computing",

    # Optional
    author = person("R Core Team"),
    organization = "An org",
    address = "Leganes, ES",
    edition = "Fourth",
    month = "August",
    year = "2021",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("MastersThesis", {
  bib <- bibentry("MastersThesis",
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    school = "Trinity College",
    year = "2021",

    # Optional
    type = "Master thesis",
    address = "Leganes, Madrid",
    month = "August",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Misc", {
  bib <- bibentry("Misc",
    # Optional
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    howpublished = "CD-ROM",
    month = 1,
    year = "2021",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("PhdThesis", {
  bib <- bibentry("PhdThesis",
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    school = "Trinity College",
    year = "2021",

    # Optional
    type = "Some type",
    address = "Leganes, Madrid",
    month = "August",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Proceedings", {
  bib <- bibentry("Proceedings",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",

    # Optional
    editor = "Aaronson",
    volume = 1,
    number = 3,
    series = "The {R} series",
    address = "Some address, FR",
    month = "August",
    organization = "An org",
    publisher = "{Publishing Co.}",
    note = "A note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("TechReport", {
  bib <- bibentry("TechReport",
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    institution = "MIT",
    year = "2021",
    # Optional
    type = "Some type",
    number = 900,
    address = "An address, FR",
    month = "aug",
    note = "Some note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Unpublished", {
  bib <- bibentry("Unpublished",
    author = person("R Core Team"),
    title = "A Language and Environment for Statistical Computing",
    note = "Preprint",

    # Optional
    year = "2021",
    month = "8",
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Parse persons on CITATION", {
  bib <- bibentry("Manual",
    title = "A Language and Environment for Statistical Computing",
    year = "2021",
    author = person("R Core Team"),
    contact = person("A", "name"),
    conference = person("A", "conference"),
    "database-provider" = person("Database", "provider"),
    editors = c(person("A", "editor"), person("{Ben and Jerry}")),
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

  expect_true(cff_validate(cffobj, verbose = FALSE))
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

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("NULL bibs and others strange errors", {
  bib <- 1
  expect_null(cff_parse_citation(bib))
  class(bib) <- "bibentry"
  bib <- NULL
  expect_null(cff_parse_citation(bib))
})




test_that("Test entry without author", {
  bib <- bibentry("Proceedings",
    editor = "Yolande Berbers and Willy Zwaenepoel",
    title = "Proceedings of the 6th European Conference on Computer Systems",
    booktitle = "Proceedings of the 6th European Conference on Computer Systems",
    publisher = "ACM",
    venue = "Leuven, Belgium",
    month = "apr",
    year = 2006,
    isbn = "1-59593-322-02",
  )

  bibparsed <- cff_parse_citation(bib)

  expect_identical(
    bibparsed$authors[[1]]$name,
    paste(bib$editor, collapse = " and ")
  )


  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Test entry without author but has a key", {
  bib <- bibentry("Misc",
    key = "I am the key",
    title = "Proceedings of the 6th European Conference on Computer Systems",
    booktitle = "Proceedings of the 6th European Conference on Computer Systems",
    publisher = "ACM",
    venue = "Leuven, Belgium",
    month = "apr",
    year = 2006,
    isbn = "1-59593-322-02",
  )

  bibparsed <- cff_parse_citation(bib)

  expect_identical(
    bibparsed$authors[[1]]$name,
    bib$key
  )


  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Skip misc without title", {
  bib <- bibentry(
    bibtype = "misc",
    author = c(person("SHERPA/RoMEO")),
    url = "http://www.sherpa.ac.uk/romeo/",
    year = 2018
  )

  expect_message(cff_parse_citation(bib))

  bibparsed <- cff_parse_citation(bib)

  expect_null(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_snapshot_output(cffobj)

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Skip misc without title, not skipping the good one", {
  bib <- c(
    bibentry(
      bibtype = "misc",
      author = c(person("SHERPA/RoMEO")),
      url = "http://www.sherpa.ac.uk/romeo/",
      year = 2018
    ),
    bibentry(
      bibtype = "misc",
      title = "{rromeo}: An {R} Client for {SHERPA/RoMEO} {API}",
      author = c(
        person("Matthias", "Grenié"),
        person("Hugo", "Gruson")
      ),
      year = 2019,
      header = "To cite this package in publications, please use:",
      url = "https://CRAN.R-project.org/package=rromeo"
    )
  )



  expect_message(cff_parse_citation(bib))

  bibparsed <- cff_parse_citation(bib)

  expect_length(bibparsed, 2)

  expect_null(bibparsed[[1]])

  expect_s3_class(bibparsed[[2]], "cff")

  cffobj <- cff_create(cff(),
    keys = list(references = bibparsed)
  )

  expect_snapshot_output(cffobj)

  expect_equal(
    cffobj$references[[1]]$title,
    "rromeo: An R Client for SHERPA/RoMEO API"
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})
