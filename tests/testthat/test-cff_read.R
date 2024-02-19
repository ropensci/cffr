test_that("Test errors on cff_read", {
  expect_snapshot(cff_read(c("abcde", "b")), error = TRUE)
  expect_snapshot(cff_read("abcde"), error = TRUE)

  f <- system.file("schema/schema.json", package = "cffr")
  expect_error(cff_read(f), "Don't recognize the file type of")
})

test_that("cff_read citation.cff", {
  expect_snapshot(cff_read_cff_citation("a"), error = TRUE)

  f <- system.file("examples/CITATION_complete.cff", package = "cffr")
  f1 <- cff_read(f)
  expect_true(cff_validate(f1, verbose = FALSE))
  expect_s3_class(f1, c("cff", "list"), exact = TRUE)

  # With the alias
  f2 <- cff_read_cff_citation(f)
  expect_identical(f1, f2)
})


test_that("cff_read DESCRIPTION", {
  expect_snapshot(cff_read_description("a"), error = TRUE)


  f <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  f1 <- cff_read(f, gh_keywords = FALSE)
  expect_true(cff_validate(f1, verbose = FALSE))
  expect_s3_class(f1, c("cff", "list"), exact = TRUE)

  # With the alias
  f2 <- cff_read_description(f, gh_keywords = FALSE)
  expect_identical(f1, f2)


  # Use other params
  f1_1 <- cff_read(f,
                   gh_keywords = FALSE, cff_version = 3000,
                   authors_roles = c("aut", "cre", "ctb")
  )

  expect_equal(f1_1$`cff-version`, "3000")

  expect_gt(length(f1_1$authors), length(f1$authors))

  f2_1 <- cff_read_description(f,
                               gh_keywords = FALSE, cff_version = 3000,
                               authors_roles = c("aut", "cre", "ctb")
  )

  expect_identical(f1_1, f2_1)
})


test_that("cff_read bib", {
  skip_if_not_installed("bibtex", "0.5.0")

  expect_snapshot(cff_read_bib("a"), error = TRUE)


  f <- system.file("REFERENCES.bib", package = "cffr")

  f1 <- cff_read(f)
  expect_s3_class(f1, c("cff", "list"), exact = TRUE)
  expect_gt(length(f1), 1)

  # Specific
  f2 <- cff_read_bib(f)
  expect_identical(f1, f2)


  # With encodings

  f <- system.file("examples/example.bib", package = "cffr")
  f1_2 <- cff_read(f)
  expect_s3_class(f1_2, c("cff", "list"), exact = TRUE)
  expect_length(f1_2, 2)

  d <- f1_2[[2]]

  expect_snapshot(d)
  f2_2 <- cff_read_bib(f)
  expect_identical(f1_2, f2_2)
})

test_that("cff_read citation messages", {
  expect_snapshot(cff_read_citation("a"), error = TRUE)


  f <- system.file("examples/CITATION_basic", package = "cffr")
  my_meta <- packageDescription("testthat")

  expect_snapshot(s <- cff_read(f, meta = "aa"))
  expect_silent(s <- cff_read(f, meta = NULL))
  expect_silent(s <- cff_read(f, meta = my_meta))

  # Now try with a file that needs meta
  f <- system.file("examples/CITATION_auto", package = "cffr")

  expect_message(s <- cff_read(f), "Trying with")
  expect_s3_class(s, c("cff", "list"), exact = TRUE)
})

test_that("cff_read CITATION_basic", {
  a_desc <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  my_meta <- test_meta(a_desc)

  path <- system.file("examples/CITATION_basic", package = "cffr")
  parsed <- cff_read(path, my_meta)
  expect_s3_class(parsed, c("cff", "list"), exact = TRUE)
  expect_equal(length(parsed), 2)

  # Identical to
  meta <- as.list(read.dcf(a_desc)[1, ])
  meta$Encoding <- "UTF-8"

  id <- utils::readCitationFile(path, meta = meta)

  id <- cff_parse_citation(id)
  id <- new_cff(id)

  expect_identical(parsed, id)
})

test_that("cff_read CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")

  my_meta <- test_meta(desc_path)
  parsed <- cff_read_citation(cit_path, my_meta)

  # Identical to
  meta <- as.list(read.dcf(desc_path)[1, ])
  id <- utils::readCitationFile(cit_path, meta = meta)

  id <- cff_parse_citation(id)
  id <- new_cff(id)

  expect_identical(parsed, id)
})

test_that("cff_read CITATION_auto", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  my_meta <- test_meta(desc_path)

  parsed <- cff_read(cit_path, my_meta)

  expect_equal(length(parsed), 3)

  # Identical to
  meta <- as.list(read.dcf(desc_path)[1, ])
  id <- utils::readCitationFile(cit_path, meta = meta)
  id <- cff_parse_citation(id)
  id <- new_cff(id)


  expect_identical(parsed, id)
})

test_that("cff_read CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  my_meta <- test_meta(desc_path)
  parsed <- cff_read(cit_path, my_meta)

  expect_equal(length(parsed), 3)

  # Identical to
  meta <- as.list(read.dcf(desc_path)[1, ])
  meta$Encoding <- "UTF-8"

  id <- utils::readCitationFile(cit_path, meta = meta)
  id <- cff_parse_citation(id)
  id <- new_cff(id)

  expect_identical(parsed, id)
})
