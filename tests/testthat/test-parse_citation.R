test_that("Parse CITATION_basic", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_snapshot_output(print(parsed, bibtex = TRUE))
})

test_that("Parse CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")

  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_snapshot_output(print(parsed, bibtex = TRUE))
})

test_that("Parse CITATION_auto", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_length(parsed, 3)
  expect_snapshot_output(print(parsed, bibtex = TRUE))
})

test_that("Parse CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_snapshot_output(print(parsed, bibtex = TRUE))
})


test_that("Parse CITATION NULL", {
  desc_path <- system.file("x", package = "cffr")
  cit_path <- system.file("y", package = "cffr")

  expect_null(parse_r_citation(
    desc_path,
    cit_path
  ))
})
