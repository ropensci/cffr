test_that("Parse CITATION_basic", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_equal(length(parsed), 2)

  # Identical to
  meta <- as.list(read.dcf(desc_path)[1, ])
  meta$Encoding <- "UTF-8"

  id <- utils::readCitationFile(cit_path, meta = meta)

  expect_identical(parsed, id)
})

test_that("Parse CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_basic", package = "cffr")

  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_equal(length(parsed), 2)

  # Identical to
  meta <- as.list(read.dcf(desc_path)[1, ])
  # meta$Encoding <- "UTF-8"

  id <- utils::readCitationFile(cit_path, meta = meta)

  expect_identical(parsed, id)
})

test_that("Parse CITATION_auto", {
  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")
  cit_path <- system.file("examples/CITATION_auto", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_equal(length(parsed), 3)

  # Identical to
  meta <- as.list(read.dcf(desc_path)[1, ])
  # meta$Encoding <- "UTF-8"

  id <- utils::readCitationFile(cit_path, meta = meta)

  expect_identical(parsed, id)
})

test_that("Parse CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  parsed <- parse_r_citation(desc_path, cit_path)

  expect_s3_class(parsed, "citation")
  expect_equal(length(parsed), 3)

  # Identical to
  meta <- as.list(read.dcf(desc_path)[1, ])
  meta$Encoding <- "UTF-8"

  id <- utils::readCitationFile(cit_path, meta = meta)

  expect_identical(parsed, id)
})


test_that("Parse CITATION NULL", {
  desc_path <- system.file("x", package = "cffr")
  cit_path <- system.file("y", package = "cffr")

  expect_null(parse_r_citation(
    desc_path,
    cit_path
  ))
})
