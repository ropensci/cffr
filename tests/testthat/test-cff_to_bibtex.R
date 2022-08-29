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
    keywords = c("Some", "simple", "keywords")
  )
  expect_snapshot_output(toBibtex(bib))
  x <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(x)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
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

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})

test_that("TechReport to bibtex", {
  bib <- bibentry("TechReport",
    author = "John M. Aronis",
    title = "Implementing Inheritance on the Connection Machine",
    institution = "Intelligent Systems Program, University of Pittsburgh",
    number = "ISP 93-1",
    year = 1993,
    address = "Pittsburgh, PA 15260",
  )

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})

test_that("Unpublished to bibtex", {
  bib <- bibentry("Unpublished",
    author = "John M. Aronis and Foster J. Provost",
    title = "Efficiently Constructing Relational Features from Background",
    year = 1959,
    note = "Unpublished MS, Computer Science Department, University of Pittsburgh.",
    missinginfo = "Date is  guess.",
  )

  expect_snapshot_output(toBibtex(bib))
  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})


test_that("particle names", {
  bib <- bibentry("Book",
    title        = "A Handbook for Scholars",
    author       = person("Mary-Claire", "van Leunen"),
    year         = 1979,
    publisher    = "Knopf"
  )


  bibparsed <- cff_parse_citation(bib)
  bibparsed$authors <- cff_parse_person_bibtex("van Leunen, Mary-Claire and Davis, Jr., Sammy")

  cffobj <- cff_create(cff(),
    keys = list(references = list(bibparsed))
  )

  expect_true(cff_validate(cffobj, verbose = FALSE))

  expect_snapshot_output(bibparsed)

  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})

test_that("From plain cff with a citation", {
  s <- cff()
  s <- cff_create(s)

  acit <- bibentry(
    bibtype = "misc", title = "title", year = 1999,
    author = "John Doe",
    month = 3
  )

  s$`preferred-citation` <- cff_parse_citation(acit)
  s$`preferred-citation`$editors <- list(cff_parse_person("A name"))

  bib <- cff_to_bibtex(s)
  expect_snapshot_output(toBibtex(bib))
})

test_that("From plain cff", {
  bib <- cff_to_bibtex(cff())
  expect_snapshot_output(toBibtex(bib))
})

test_that("From file", {
  file <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )

  bib <- cff_to_bibtex(file)
  expect_snapshot_output(toBibtex(bib))
})

test_that("NULL", {
  s <- NULL
  expect_null(cff_to_bibtex(s))
})


test_that("Test anonymous", {
  bib <- bibentry("Booklet",
    title = "A booklet"
  )


  back <- cff_to_bibtex(cff_parse_citation(bib))
  expect_snapshot_output(toBibtex(back))


  bib <- bibentry("manual",
    title = "A manual"
  )


  back <- cff_to_bibtex(cff_parse_citation(bib))
  expect_snapshot_output(toBibtex(back))

  bib <- bibentry("misc",
    title = "A misc"
  )


  back <- cff_to_bibtex(cff_parse_citation(bib))
  expect_snapshot_output(toBibtex(back))

  bib <- bibentry("proceedings",
    title = "proceedings",
    year = 1984
  )


  back <- cff_to_bibtex(cff_parse_citation(bib))
  expect_snapshot_output(toBibtex(back))
})

test_that("Fallback month", {
  bib <- bibentry("Article",
    title = "An Article",
    author = "John Doe",
    journal = "El Adelantado de Segovia",
    year = "1678",
    date = "1678-04-23"
  )

  expect_snapshot_output(toBibtex(bib))
  x <- cff_parse_citation(bib)

  # Delete here the month
  x$month <- NULL

  bibback <- cff_to_bibtex(x)
  expect_snapshot_output(toBibtex(bibback))
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
  expect_snapshot_output(toBibtex(bib))
  x <- cff_parse_citation(bib)


  parsed <- cff_to_bibtex(x)
  expect_snapshot_output(toBibtex(parsed))
})
