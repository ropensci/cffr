test_that("Test errors on cff_read", {
  expect_snapshot(cff_read(c("abcde", "b")), error = TRUE)
  expect_snapshot(cff_read("abcde"), error = TRUE)

  f <- system.file("schema/schema.json", package = "cffr")
  expect_snapshot(cff_read(f), error = TRUE)
})

test_that("cff_read citation.cff", {
  f <- system.file("examples/CITATION_complete.cff", package = "cffr")
  f1 <- cff_read(f)
  expect_true(cff_validate(f1, verbose = FALSE))
  expect_s3_class(f1, c("cff", "list"), exact = TRUE)

  # With the alias
  f2 <- cff_read_cff_citation(f)
  expect_identical(f1, f2)
})


test_that("cff_read DESCRIPTION", {
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


test_that("cff read bib", {
  skip_if_not_installed("bibtex", "0.5.0")

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
