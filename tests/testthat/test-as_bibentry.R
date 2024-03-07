test_that("as_bibentry default", {
  bib_coerced <- as_bibentry(
    bibtype = "Article",
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

  direct <- bibentry(
    bibtype = "Article",
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
  expect_identical(bib_coerced, direct)

  with_number_first <- as_bibentry(
    number = 2,
    bibtype = "Article",
    key = "knuth:1984",
    author = person("R Core Team"),
    title = "Literate Programming",
    journal = "The Computer Journal",
    year = "1984",
    # Optional
    volume = "27",
    pages = "97--111",
    month = "January",
    keywords = "Some, simple, keywords"
  )

  direct <- bibentry(
    number = 2,
    bibtype = "Article",
    key = "knuth:1984",
    author = person("R Core Team"),
    title = "Literate Programming",
    journal = "The Computer Journal",
    year = "1984",
    # Optional
    volume = "27",
    pages = "97--111",
    month = "January",
    keywords = "Some, simple, keywords"
  )

  expect_identical(with_number_first, direct)

  # No additional dots
  expect_snapshot(s <- as_bibentry(a = 1))
})

test_that("as_bibentry NULL", {
  skip_on_cran()
  current_dir <- getwd()

  name <- paste0("mock-pack", runif(1) * 10)
  new_dir <- file.path(tempdir(), name)

  dir.create(new_dir, recursive = TRUE)

  expect_true(dir.exists(new_dir))

  setwd(new_dir)

  # Move files
  file.copy(system.file("examples/DESCRIPTION_basic", package = "cffr"),
    to = "DESCRIPTION"
  )

  # Get bibentry
  a_bib <- as_bibentry()


  # Revert to initial wd
  setwd(current_dir)

  expect_snapshot(toBibtex(a_bib))

  unlink(new_dir, recursive = TRUE, force = TRUE)
})



test_that("as_bibentry character", {
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

  # If an invented package
  expect_snapshot(as_bibentry("invented_package"), error = TRUE)

  # If another kind of file
  f <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  s <- as_bibentry(f)
  expect_s3_class(s, "bibentry")
})

test_that("as_bibentry cff", {
  f <- system.file("examples/CITATION_basic.cff", package = "cffr")

  a_cff <- cff_read(f)
  theref <- a_cff$references[[1]]
  a_cff <- cff_modify(a_cff, references = NULL)
  expect_null(a_cff$references)

  expect_snapshot(end <- as_bibentry(a_cff, what = "references"))
  expect_identical(end, bibentry())


  expect_s3_class(theref, c("cff_ref", "cff"), exact = TRUE)
  mod_ref <- cff_modify(theref,
    type = "manual",
    authors = as_cff_person("{anonymous}")
  )

  expect_snapshot(toBibtex(as_bibentry(mod_ref)))
})
