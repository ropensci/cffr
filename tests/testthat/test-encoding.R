test_that("Creating cff from packages encoded in latin1", {
  # Surveillance package
  desc_path <- system.file("examples/DESCRIPTION_surveillance", package = "cffr")
  cit_path <- system.file("examples/CITATION_surveillance", package = "cffr")

  expect_true(desc::desc(desc_path)$get("Encoding") == "latin1")

  # Parse citation
  bib <- parse_r_citation(desc_path, cit_path)
  expect_false("UTF-8" %in% Encoding(unlist(bib)))

  # Parse to cff citation
  bibparsed <- lapply(bib, cff_parse_citation)

  expect_true("UTF-8" %in% Encoding(unlist(bibparsed)))
  expect_false("latin1" %in% Encoding(unlist(bibparsed)))

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    references = bibparsed
  ))

  expect_s3_class(cffobj, "cff")
  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj))
})
