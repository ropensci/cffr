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

# Real world examples

test_that("Article", {
  bib <- bibentry("Article",
    key = "article",
    title = "Bit-Vector Algorithms for Binary Constraint Satisfaction and Subgraph Isomorphism",
    author = "Julian R. Ullmann",
    year = 2011,
    month = "feb",
    journal = "ACM Journal of Experimental Algorithmics",
    publisher = "Association for Computing Machinery",
    address = "New York, NY, USA",
    volume = 15,
    number = "1.6",
    pages = "1--64",
    doi = "10.1145/1671970.1921702",
    issn = "1084-6654",
    url = "https://doi.org/10.1145/1671970.1921702",
    issue_date = 2010,
    articleno = "1.6",
    numpages = 64,
    keywords = "constraint propagation, signature file, prematching, constraint satisfaction, binary constraints, graph indexing, bit-vector, focus search, molecule matching, subgraph isomorphism, AllDifferent constraint, backtrack, domain reduction, forward checking"
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
    key = "book",
    title = "Gray's anatomy",
    author = "Henry Gray and Peter L. Williams and Roger Warwick",
    year = "1973",
    publisher = "Longman London",
    address = "London, United Kingdom",
    pages = "xvi, 1471 p.",
    isbn = "0443010110",
    edition = "35th ed.; edited by Roger Warwick and Peter L. Williams with the assistance of others.",
    type = "Book",
    language = "English",
    subjects = "Human anatomy"
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
    key = "booklet",
    title = "The title of the work",
    author = "Peter Caxton",
    howpublished = "How it was published",
    address = "The address of the publisher",
    month = 7,
    year = 1993,
    note = "An optional note"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Conference", {
  # R does not handle conference, however this is the same
  # than InProceedings

  bib <- bibentry("InProceedings",
    key = "conference",
    author = "Peter Draper",
    title = "The title of the work",
    booktitle = "The title of the book",
    year = 1993,
    editor = "The editor",
    volume = 4,
    series = 5,
    pages = 213,
    address = "The address of the publisher",
    month = 7,
    organization = "The organization",
    publisher = "The publisher",
    note = "An optional note"
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
    key = "inbook",
    author = "Peter Eston",
    title = "The title of the work",
    chapter = 8,
    pages = "201-213",
    publisher = "The name of the publisher",
    year = 1993,
    volume = 4,
    series = 5,
    address = "The address of the publisher",
    edition = 3,
    month = 7,
    note = "An optional note"
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
    key = "InCollection",
    author = "Peter Farindon",
    title = "The title of the work",
    booktitle = "The title of the book",
    publisher = "The name of the publisher",
    year = 1993,
    editor = "The editor",
    volume = 4,
    series = 5,
    chapter = 8,
    pages = "201-213",
    address = "The address of the publisher",
    edition = 3,
    month = 7,
    note = "An optional note"
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
    key = "inproceedings",
    author = "Paul Holleis and Matthias Wagner and Sebastian Böhm and Johan Koolwaaij",
    title = "Studying Mobile Context-Aware Social Services in the Wild",
    year = "2010",
    isbn = "9781605589343",
    publisher = "Association for Computing Machinery",
    address = "New York, NY, USA",
    url = "https://doi.org/10.1145/1868914.1868941",
    doi = "10.1145/1868914.1868941",
    abstract = "We have implemented and evaluated IYOUIT, a context-aware application for the mobile phone that promotes a digital lifestyle, sharing, and life-logging approach for people on the go. The service incorporates context management technology to abstract data about and around the user into meaningful interpretations of the user's digital trace in the real world. Complementary to the public release of our service, we have conducted a longitudinal field study with 19 users for a period of one month. In this paper, we present findings from this coordinated user trial and provide researchers with advice on the design and implementation of similar systems.",
    booktitle = "Proceedings of the 6th Nordic Conference on Human-Computer Interaction: Extending Boundaries",
    pages = "207–216",
    numpages = "10",
    keywords = "mobile services, context awareness, social networking",
    location = "Reykjavik, Iceland",
    series = "NordiCHI '10"
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
    key = "manual",
    title = "The title of the work",
    author = "Peter Gainsford",
    organization = "The organization",
    address = "The address of the publisher",
    edition = 3,
    month = 7,
    year = 1993,
    note = "An optional note"
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
    key = "masterthesis",
    author = "Peter Harwood",
    title = "The title of the work",
    school = "The school of the thesis",
    year = 1993,
    address = "The address of the publisher",
    month = 7,
    note = "An optional note"
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
    key = "misc",
    author = "Peter Isley",
    title = "The title of the work",
    howpublished = "How it was published",
    month = 7,
    year = 1993,
    note = "An optional note"
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
    key = "phdthesis",
    author = "Peter Joslin",
    title = "The title of the work",
    school = "The school of the thesis",
    year = 1993,
    address = "The address of the publisher",
    month = 7,
    note = "An optional note"
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
    key = "proc",
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
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Proceedings with custom key", {
  bib <- bibentry("Proceedings",
    key = "proc",
    title = "Proceedings of the 6th European Conference on Computer Systems",
    booktitle = "Proceedings of the 6th European Conference on Computer Systems",
    publisher = "ACM",
    venue = "Leuven, Belgium",
    month = "apr",
    year = 2006,
    isbn = "1-59593-322-02",
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Proceedings with auto key", {
  bib <- bibentry("Proceedings",
    title = "Proceedings of the 6th European Conference on Computer Systems",
    booktitle = "Proceedings of the 6th European Conference on Computer Systems",
    publisher = "ACM",
    venue = "Leuven, Belgium",
    month = "apr",
    year = 2006,
    isbn = "1-59593-322-02",
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
    author       = "Peter Lambert",
    title        = "The title of the work",
    institution  = "The institution that published",
    year         = 1993,
    number       = 2,
    address      = "The address of the publisher",
    month        = 7,
    note         = "An optional note"
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
    author       = "Peter Marcheford",
    title        = "The title of the work",
    note         = "An optional note",
    month        = 7,
    year         = 1993
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
    editor = person("A", "editor"),
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
