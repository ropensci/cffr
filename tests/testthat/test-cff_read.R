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
  expect_s3_class(f1, "cff", exact = TRUE)

  # With the alias
  f2 <- cff_read_cff_citation(f)
  expect_identical(f1, f2)
})


test_that("cff_read DESCRIPTION", {
  expect_snapshot(cff_read_description("a"), error = TRUE)


  f <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  f1 <- cff_read(f, gh_keywords = FALSE)
  expect_true(cff_validate(f1, verbose = FALSE))
  expect_s3_class(f1, "cff", exact = TRUE)

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

  skip_on_cran()
  # With gh keywords
  f <- system.file("examples/DESCRIPTION_posit_package_manager",
    package = "cffr"
  )
  fno <- cff_read_description(f, gh_keywords = FALSE)
  f2 <- cff_read_description(f, gh_keywords = TRUE)

  expect_false(is.null(f2$keywords))
  expect_gt(length(f2$keywords), length(fno$keywords))
})


test_that("cff_read bib", {
  skip_if_not_installed("bibtex", "0.5.0")

  expect_snapshot(cff_read_bib("a"), error = TRUE)


  f <- system.file("REFERENCES.bib", package = "cffr")

  f1 <- cff_read(f)
  expect_s3_class(f1, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_gt(length(f1), 1)

  # Specific
  f2 <- cff_read_bib(f)
  expect_identical(f1, f2)


  # With encodings

  f <- system.file("examples/example.bib", package = "cffr")
  f1_2 <- cff_read(f)
  expect_s3_class(f1_2, c("cff_ref_lst", "cff"), exact = TRUE)
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
  expect_s3_class(s, c("cff_ref_lst", "cff"), exact = TRUE)
})

test_that("cff_read CITATION_basic", {
  a_desc <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  my_meta <- desc_to_meta(a_desc)

  path <- system.file("examples/CITATION_basic", package = "cffr")
  a_cff <- cff_read(path, my_meta)
  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_equal(length(a_cff), 2)
})

test_that("cff_read CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")

  my_meta <- desc_to_meta(desc_path)
  a_cff <- cff_read_citation(cit_path, my_meta)
  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
})

test_that("cff_read CITATION_auto", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  my_meta <- desc_to_meta(desc_path)

  a_cff <- cff_read(cit_path, my_meta)

  expect_equal(length(a_cff), 3)
})

test_that("cff_read CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  my_meta <- desc_to_meta(desc_path)
  a_cff <- cff_read(cit_path, my_meta)

  expect_equal(length(a_cff), 3)
})

test_that("cff_read_safe CITATION_basic", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")
  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_equal(length(a_cff), 2)
})

test_that("cff_read_safe CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")

  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_equal(length(a_cff), 2)
})

test_that("cff_read_safe CITATION_auto", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_equal(length(a_cff), 3)
})

test_that("cff_read_safe CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  a_cff <- cff_safe_read_citation(desc_path, cit_path)

  expect_s3_class(a_cff, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_equal(length(a_cff), 3)
})


test_that("cff_read_safe CITATION NULL", {
  desc_path <- system.file("x", package = "cffr")
  cit_path <- system.file("y", package = "cffr")

  expect_null(cff_safe_read_citation(
    desc_path,
    cit_path
  ))
})

test_that("Corrupt CITATION", {
  tmp <- tempfile("CITATION")
  writeLines("I am a bad CITATION", tmp)
  expect_message(
    expect_message(anull <- cff_read(tmp), "It was not possible to read"),
    "Can't"
  )
  expect_null(anull)


  # Internal
  desc_path <- system.file("examples/DESCRIPTION_basic",
    package = "cffr"
  )
  expect_silent(anull <- cff_safe_read_citation(desc_path = desc_path, tmp))

  expect_null(anull)
})

test_that("Creating cff from packages encoded in latin1", {
  # Surveillance package
  desc_path <- system.file("examples/DESCRIPTION_surveillance",
    package = "cffr"
  )
  cit_path <- system.file("examples/CITATION_surveillance", package = "cffr")

  expect_true(desc::desc(desc_path)$get("Encoding") == "latin1")

  # Parse citation
  bib <- cff_safe_read_citation(desc_path, cit_path)

  expect_true("UTF-8" %in% Encoding(unlist(bib)))
  expect_false("latin1" %in% Encoding(unlist(bib)))

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    references = bib
  ))

  expect_s3_class(cffobj, "cff")
  expect_snapshot(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})
