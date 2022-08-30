test_that("Article", {
  bib <- bibentry("Article",
    key = "knuth:1984",
    author = person("R Core Team"),
    title = "Literate Programming",
    journal = "The Computer Journal",
    year = "1984",
    # Optional
    volume = "27",
    number = 2,
    pages = "97--111",
    month = "January",
    note = "Example modified for testing purposes"
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
    key = "latex:companion",
    author = "Frank Mittelbach and Michel Gossens
            and Johannes Braams and David Carlisle
            and Chris Rowley",
    editor = "{Barnes and Noble}",
    title = "The LaTeX Companion",
    publisher = "Addison-Wesley Professional",
    year = "2004",
    # Optional
    volume = "3",
    number = 7,
    series = "The LateX Books",
    address = "Santa Monica",
    edition = "Fourth",
    month = "August",
    note = "Example modified for testing purposes",
    keywords = c("Two, keyword")
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
    key = "Mustermann2016",
    title = "Java Booklet",
    # Optional
    author = "Max Mustermann",
    howpublished = "Internet",
    address = "Stuttgart",
    month = "feb",
    year = "2016",
    note = "Example modified from Jabref",
    keywords = "java"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Conference", {
  bib <- bibentry("InProceedings",
    key = "inproceedings-full",
    author = "Alfred V. Oaho and Jeffrey D. Ullman and Mihalis Yannakakis",
    title = "On Notions of Information Transfer in {VLSI} Circuits",
    title = "{Statistical Machine Translation: Rapid Development with Limited Resources",
    booktitle = "Proc. Fifteenth Annual ACM STOC",
    year = "1983",
    # Optional
    editor = "Wizard V. Oz and Mihalis Yannakakis",
    volume = "41",
    number = 17,
    series = "All ACM Conferences",
    pages = "133--139",
    address = "Boston",
    organization = "ACM",
    publisher = "Academic Press",
    note = "Example modified for testing purposes"
  )

  # Hack to convert to conference
  bib_un <- unclass(bib)[[1]]

  attr(bib_un, "bibtype") <- "Conference"

  bib <- list(bib_un)
  class(bib) <- "bibentry"



  bibparsed <- cff_parse_citation(bib)

  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("InBook", {
  bib <- bibentry("InBook",
    key = "1326",
    author = "A. King",
    editor = "E Tick and G Succi",
    title = "A Framework for Freeness Analysis",
    chapter = "7, 14",
    pages = "137--149",
    publisher = "Kluwer Academic Publishers",
    year = "1994",
    # Optional
    volume = "27",
    number = 2,
    series = "Implementations of Logic Programming Systems",
    type = "A chapter",
    address = "Dordrecht",
    edition = "Second",
    month = "January",
    note = "Example modified for testing purposes"
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
    key = "Mihalcea:2006",
    author = "Rada Mihalcea",
    title = "Knowledge-Based Methods for {WSD}",
    booktitle = "Word Sense Disambiguation: Algorithms
               and Applications",
    publisher = "Springer",
    year = "2006",
    # Optional
    editor = "Eneko Agirre and Philip Edmonds",
    volume = "23",
    number = 3,
    series = "The Word Sense Series",
    type = "A random type",
    chapter = "1,2,3",
    pages = "24--57",
    address = "107--132",
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
    key = "inproceedings-full",
    author = "Alfred V. Oaho and Jeffrey D. Ullman and Mihalis Yannakakis",
    title = "On Notions of Information Transfer in {VLSI} Circuits",
    title = "{Statistical Machine Translation: Rapid Development with Limited Resources",
    booktitle = "Proc. Fifteenth Annual ACM STOC",
    year = "1983",
    # Optional
    editor = "Wizard V. Oz and Mihalis Yannakakis",
    volume = "41",
    number = 17,
    series = "All ACM Conferences",
    pages = "133--139",
    address = "Boston",
    organization = "ACM",
    publisher = "Academic Press",
    note = "Example modified for testing purposes"
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
    organization = "R Foundation for Statistical Computing",
    address = "Vienna, Austria",
    edition = "Fourth",
    month = "August",
    year = "2021",
    note = "Example modified for testing purposes"
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
    key = "Master2006",
    author = "Eesa Alsolami",
    title = "An examination of keystroke dynamics
                for continuous user authentication",
    school = "Queensland University of Technology",
    year = "2012",
    # Optional
    type = "Final thesis",
    address = "Queensland, NZ",
    month = "August",
    note = "Example modified for testing purposes"
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
    author = "Eesa Alsolami",
    title = "An examination of keystroke dynamics
                for continuous user authentication",
    school = "Queensland University of Technology",
    year = "2012",
    # Optional
    type = "Final PhD thesis",
    address = "Queensland, NZ",
    month = "August",
    note = "Example modified for testing purposes"
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
    title = "Proc. Fifteenth Annual STOC",
    year = "1983",
    # Optional
    editor = "Wizard V. Oz and Mihalis Yannakakis",
    volume = 1,
    number = 17,
    series = "All ACM Conferences",
    address = "Boston, US",
    month = "August",
    organization = "The OX Association for Computing Machinery",
    publisher = "Academic Press",
    note = "Example modified for testing purposes"
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
    author = "Matthew C. Jadud and Sally A. Fincher",
    title = "Naive tools for studying compilation histories",
    institution = "University of Kent Canterbury",
    year = "2003",
    # Optional
    type = "techreport",
    number = "3-03",
    address = "Computing Laboratory, University of Kent, Canterbury, Kent, CT2 7NF",
    month = "mar",
    note = "Example modified for testing purposes"
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
    author = "D. Kaplan",
    title = "Demonstratives",
    note = "Unpublished manuscript, UCLA",
    # Optional
    year = "1977",
    month = "aug",
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
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
    "anonymous"
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
    "anonymous"
  )


  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})


test_that("Test entry without author and key", {
  bib <- bibentry("Misc",
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
    "anonymous"
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


test_that("Check extended BibLatex Fields", {
  bib <- bibentry("Article",
    author = "M. A. Kastenholz, and Philippe H. Hünenbergerb",
    title = "Computation of methodology hyphen independent ionic solvation
                  free energies from molecular simulations",
    journal = "J. Chem. Phys.",
    year = 2006,
    note = "Example modified for testing purposes",
    pages = "55--65",

    # Additional BibLatex Fields
    date = "2006-03-15",
    file = "a_file.pdf",
    issuetitle = "Semantic {3D} Media and Content",
    translator = "Wicksteed, P. H. and Cornford, F. M.",
    urldate = "2006-10-01",
    pagetotal = 528,
    abstract = "The computation of ionic solvation free energies from
                  atomistic simulations is a surprisingly difficult problem that
                  has found no satisfactory solution for more than 15 years.",
    doi = "10.1063/1.2172593",
    isbn = "0-816-52066-6",
    issn = "0097-8493",
    url = "http://www.ctan.org"
  )

  bibparsed <- cff_parse_citation(bib)
  expect_snapshot_output(bibparsed)

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))
})
