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
