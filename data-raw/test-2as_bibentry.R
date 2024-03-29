# Test Bibtex ----
test_that("Article to bibtex", {
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
    keywords = "Some, simple, keywords"
  )
  expect_snapshot(toBibtex(bib))
  x <- as_cff(bib)
  bib <- as_bibentry(x)
  expect_snapshot(toBibtex(bib))
})


test_that("Book to bibtex", {
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

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})


test_that("Booklet to bibtex", {
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

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})

test_that("InBook to bibtex with pages", {
  bib <- bibentry("InBook",
    year = "2003",
    month = "oct",
    pages = "175--196",
    title = "Architectural Mismatch Tolerance",
    chapter = "Tolerances and Other Notes",
    author = "R. de Lemos and C. Gacek and A. Romanovsky",
    URL = "http://www.cs.kent.ac.uk/pubs/2003/1773",
    publication_type = "inbook",
    submission_id = "12884_1074884456",
    ISBN = "3-540-40727-8",
    editor = "A. Lalanda",
    edition = "Fifth",
    publisher = "Springer",
    volume = "2677",
    number = "234",
    address = "Lozoya",
    series = "Lecture Notes in Computer Science",
    type = "Architecting Dependable Systems",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})

test_that("InCollection to bibtex", {
  bib <- bibentry("InCollection",
    author = "Klaus Abels",
    title = "Who Gives a Damn about Minimizers in Questions?",
    booktitle = "Proceedings from Semantics and Linguistic Theory {XIII}",
    publisher = "Cornell University",
    year = 2003,
    editor = "Robert B. Young and Yuping Zhou",
    pages = "1--18",
    address = "Ithaca, New York",
    topic = "interrogatives;nl-semantics;polarity;"
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})


test_that("InProceedings to bibtex", {
  bib <- bibentry("InProceedings",
    author = "John Aberdeen and Samuel Bayer and Sasha Caskey and Laurie
                    Damianos and Alan Goldschen and Lynette Hirschman and
                    Dan Loehr and Hugo Trapper",
    title = "Implementing Practical Dialogue Systems with the
                    {DARPA} Communicator Architecture",
    booktitle = "Proceedings of the {IJCAI}-99 Workshop on
                    Knowledge and Reasoning in Practical Dialogue Systems",
    year = 1999,
    editor = "Jan Alexandersson",
    pages = "81--86",
    series = "A Series",
    organization = "IJCAI",
    publisher = "International Joint Conference on Artificial Intelligence",
    address = "Murray Hill, New Jersey",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))

  # If we remove collection title use conference
  bibparsed[[1]]$`collection-title` <- NULL
  bibparsed[[1]]$conference$name <- "I Am a conference"
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})


test_that("Manual to bibtex", {
  bib <- bibentry("Manual",
    author = "Gerhard Allwein and Dave Barker-Plummer and Jon Barwise
                    and John Etchemendy",
    title = "{LPL} Software Manual",
    publisher = "{CSLI} Publications",
    year = 1999,
    address = "Stanford, California",
    howpublished = "CD-Rom",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})


test_that("MastersThesis to bibtex", {
  bib <- bibentry("MastersThesis",
    author = "Murat Bayraktar",
    title = "Computer-Aided Analysis of {E}nglish Punctuation on a
                    Parsed Corpus: The Special Case of Comma",
    school = "Department of Computer Engineering and Information
                    Science, Bilkent University, Turkey",
    address = "Ankara, Turkey",
    year = 1996,
    note = "Forthcoming",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})


test_that("PhdThesis to bibtex", {
  bib <- bibentry("PhdThesis",
    author = "David I. Beaver",
    title = "Presupposition and Assertion in Dynamic Semantics",
    school = "Centre for Cognitive Science, University of Edinburgh",
    year = 1995,
    type = "Ph.D. Dissertation",
    address = "Edinburgh",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})


test_that("Proceedings to bibtex", {
  bib <- bibentry("Proceedings",
    title = "An Abductive Framework for Negation in Disjunctive
                    Logic Programming",
    organization = "{JELIA}'96",
    year = 1996,
    editor = "Jose Julio Alferes and Luis Moniz Pereira and Eva Orlowska",
    publisher = "Springer-Verlag",
    address = "Berlin",
    missinginfo = "pages",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})

test_that("TechReport to bibtex", {
  bib <- bibentry("TechReport",
    author = person("John M.", "Aronis",
      comment = c(affiliation = "rOpenSci")
    ),
    title = "Implementing Inheritance on the Connection Machine",
    institution = "Intelligent Systems Program, University of Pittsburgh",
    number = "ISP 93-1",
    year = 1993,
    address = "Pittsburgh, PA 15260",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))

  # Fallback when missing institution
  bibparsed[[1]]$institution <- NULL

  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})

test_that("Unpublished to bibtex", {
  bib <- bibentry("Unpublished",
    author = "John M. Aronis and Foster J. Provost",
    title = "Efficiently Constructing Relational Features from Background",
    year = 1959,
    note = paste0(
      "Unpublished MS, Computer Science Department, ",
      "University of Pittsburgh."
    ),
    missinginfo = "Date is  guess.",
  )

  expect_snapshot(toBibtex(bib))
  bibparsed <- as_cff(bib)
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))

  # With custom note
  bibparsed[[1]]$notes <- NULL
  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})

test_that("Test BibLateX entry", {
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
    translator = "Wicksteed, P. H. and {The translator factory}",
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
  expect_snapshot(toBibtex(bib))
  x <- as_cff(bib)


  parsed <- as_bibentry(x)
  expect_snapshot(toBibtex(parsed))
})


# Other testers ----

test_that("particle names", {
  bib <- bibentry("Book",
    title        = "A Handbook for Scholars",
    author       = person("Mary-Claire", "van Leunen"),
    year         = 1979,
    publisher    = "Knopf"
  )


  bibparsed <- as_cff(bib)
  bibparsed[[1]]$authors <- as_cff_person(
    "van Leunen, Mary-Claire and Davis, Jr., Sammy"
  )

  cffobj <- cff_create(cff(),
    keys = list(references = bibparsed)
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))

  expect_snapshot(bibparsed)

  bib <- as_bibentry(bibparsed)
  expect_snapshot(toBibtex(bib))
})

test_that("From plain cff with a citation", {
  s <- cff()
  s <- cff_create(s)

  acit <- bibentry(
    bibtype = "misc", title = "title", year = 1999,
    author = "John Doe",
    month = 3
  )

  s$`preferred-citation` <- as_cff(acit)[[1]]
  s$`preferred-citation`$editors <- as_cff_person("A name")

  bib <- as_bibentry(s)
  expect_snapshot(toBibtex(bib))
})

test_that("From plain cff", {
  expect_silent(bib <- as_bibentry(cff()))
  expect_snapshot(toBibtex(bib))


  expect_snapshot(as_bibentry(cff(), what = "anda"), error = TRUE)
})

test_that("From file", {
  file <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )

  bib <- as_bibentry(file)
  expect_snapshot(toBibtex(bib))

  expect_snapshot(as_bibentry("anunkonwpackage"), error = TRUE)
})


test_that("Test anonymous", {
  bib <- bibentry("Booklet",
    title = "A booklet"
  )


  expect_silent(back <- as_bibentry(as_cff(bib)))
  expect_snapshot(toBibtex(back))


  bib <- bibentry("manual",
    title = "A manual"
  )


  expect_silent(back <- as_bibentry(as_cff(bib)))
  expect_snapshot(toBibtex(back))

  bib <- bibentry("misc",
    title = "A misc"
  )


  expect_silent(back <- as_bibentry(as_cff(bib)))
  expect_snapshot(toBibtex(back))

  bib <- bibentry("proceedings",
    title = "proceedings",
    year = 1984
  )


  expect_silent(back <- as_bibentry(as_cff(bib)))
  expect_snapshot(toBibtex(back))
})

test_that("Fallback month", {
  bib <- bibentry("Article",
    title = "An Article",
    author = "John Doe",
    journal = "El Adelantado de Segovia",
    year = "1678",
    date = "1678-04-23"
  )

  expect_snapshot(toBibtex(bib))
  x <- as_cff(bib)

  # Delete here the month
  x$month <- NULL

  bibback <- as_bibentry(x)
  expect_snapshot(toBibtex(bibback))
})


test_that("Test Fallback year", {
  x <- cff()

  expect_silent(msg <- as_bibentry(x))

  expect_snapshot(toBibtex(msg))


  x$`date-released` <- "2020-01-01"

  expect_true(cff_validate(x, verbose = FALSE))

  parsed <- as_bibentry(x)

  expect_snapshot(toBibtex(parsed))
})

test_that("Errors", {
  expect_silent(b <- as_bibentry("testthat"))
  expect_s3_class(b, "bibentry")
  expect_error(as_bibentry("testthat", what = "aa"))
})

test_that("From package", {
  skip_if_not_installed("rmarkdown")

  base <- as_bibentry("rmarkdown")

  expect_s3_class(base, "bibentry")

  expect_length(base, 1)

  refs <- as_bibentry("rmarkdown", what = "references")
  expect_s3_class(refs, "bibentry")

  expect_gte(length(refs), 1)

  all <- as_bibentry("rmarkdown", what = "all")
  expect_s3_class(all, "bibentry")

  expect_length(all, length(base) + length(refs))
})

test_that("NULL references", {
  basic <- cff()

  expect_identical(
    as_bibentry(basic, what = "references"),
    bibentry()
  )

  # Test all
  expect_silent(l <- as_bibentry(basic, what = "all"))
  expect_length(l, 1)
})


test_that("From CITATION.cff", {
  p <- system.file("examples/smith-et-al.cff", package = "cffr")

  base <- as_bibentry(p)

  expect_s3_class(base, "bibentry")

  expect_length(base, 1)
})

test_that("Corrupt entry", {
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
    keywords = "Some, simple, keywords"
  )
  x <- as_cff(bib)[[1]]
  x$year <- NULL
  x$journal <- NULL
  expect_snapshot(n <- as_bibentry(x))
  expect_identical(bibentry(), bibentry())
})
