test_that("Article to bibtex", {
  bib <- bibentry("Article",
    author = "Marvin Belzer",
    title = "Intentional Social Action and We-Intentions",
    journal = "Analyse & Kritik",
    year = 2001,
    volume = 8,
    number = 1,
    pages = "86--106",
    keywords = c("Some", "simple", "keywords")
  )

  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})


test_that("Book to bibtex", {
  bib <- bibentry("Book",
    author = "Salwa K. Abd-El-Hafiz and Victor R. Basili",
    title = "Process-Centered Requirements Engineering",
    publisher = "John Wiley and Sons",
    year = 1996,
    address = "New York",
    ISBN = "0863801935 (Research Studies Press)",
  )

  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})


test_that("Booklet to bibtex", {
  bib <- bibentry("Booklet",
    author = "G. H. Gonnet and R. Baeza-Yates",
    title = "Handbook of algorithms and data structures",
    howpublished = "booklet",
    year = "1991",
  )

  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})

test_that("InBook to bibtex", {
  bib <- bibentry("InBook",
    year = "2003",
    pages = "175--196",
    title = "Architectural Mismatch Tolerance",
    chapter = "Tolerances and Other Notes",
    author = "R. de Lemos and C. Gacek and A. Romanovsky",
    URL = "http://www.cs.kent.ac.uk/pubs/2003/1773",
    publication_type = "inbook",
    submission_id = "12884_1074884456",
    ISBN = "3-540-40727-8",
    editor = "A. Lalanda",
    publisher = "Springer",
    volume = "2677",
    series = "Lecture Notes in Computer Science",
    type = "Architecting Dependable Systems",
  )

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
    organization = "IJCAI",
    publisher = "International Joint Conference on Artificial Intelligence",
    address = "Murray Hill, New Jersey",
  )

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
    year = 1996,
    note = "Forthcoming",
  )

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

  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})


test_that("Proceedings to bibtex", {
  bib <- bibentry("Proceedings",
    author = "Chandrabrose Aravindan",
    title = "An Abductive Framework for Negation in Disjunctive
                    Logic Programming",
    booktitle = "{JELIA}'96",
    year = 1996,
    editor = "Jose Julio Alferes and Luis Moniz Pereira and Eva Orlowska",
    publisher = "Springer-Verlag",
    address = "Berlin",
    missinginfo = "pages",
  )

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

  bibparsed <- cff_parse_citation(bib)
  bib <- cff_to_bibtex(bibparsed)
  expect_snapshot_output(toBibtex(bib))
})


test_that("From plain cff with pref citation", {
  s <- cff()
  s <- cff_create(s)
  s$`preferred-citation`$month <- "3"
  s$`preferred-citation`$editors <- list(cff_parse_person("A name"))

  bib <- cff_to_bibtex(s)
  expect_snapshot_output(toBibtex(bib))
})

test_that("From plain cff", {
  bib <- cff_to_bibtex(cff())
  expect_snapshot_output(toBibtex(bib))
})

test_that("From file", {
  file <- system.file("inst/examples/CITATION_complete.cff",
    package = "cffr"
  )

  bib <- cff_to_bibtex(file)
  expect_snapshot_output(toBibtex(bib))
})
