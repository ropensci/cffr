test_that("Parse CITATION_rmarkdown", {
  desc_path <- system.file("examples/DESCRIPTION_installed", package = "cffr")
  cit_path <- system.file("examples/CITATION_rmarkdown", package = "cffr")

  expect_s3_class(parse_r_citation(desc_path, cit_path), "citation")
})

test_that("Parse CITATION_ex2", {
  desc_path <- system.file("examples/DESCRIPTION_installed", package = "cffr")
  cit_path <- system.file("examples/CITATION_ex2", package = "cffr")

  expect_s3_class(parse_r_citation(desc_path, cit_path), "citation")
})

test_that("Parse CITATION_ex", {
  desc_path <- system.file("examples/DESCRIPTION_demo", package = "cffr")
  cit_path <- system.file("examples/CITATION_ex", package = "cffr")

  expect_s3_class(parse_r_citation(desc_path, cit_path), "citation")
})

test_that("CITATION NULL", {
  desc_path <- system.file("x", package = "cffr")
  cit_path <- system.file("y", package = "cffr")

  expect_null(parse_r_citation(desc_path, 
    cit_path))
    
})


test_that("Parse CITATION with no encoding", {
  desc_path <- system.file("examples/DESCRIPTION_no_encoding", package = "cffr")
  cit_path <- system.file("examples/CITATION_ex", package = "cffr")

  s <- expect_warning(parse_r_citation(desc_path, 
    cit_path))
    
    expect_s3_class(s, "citation")
})
