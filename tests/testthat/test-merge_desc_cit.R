test_that("Merge all DESCRIPTION files with CITATION_basic", {
  allfiles <- list.files(
    system.file("examples", package = "cffr"),
    pattern = "^DESC", full.names = TRUE
  )

  citpath <- system.file("examples/CITATION_basic",
    package = "cffr"
  )
  for (i in seq_len(length(allfiles))) {
    desc_parse <- cff_read_description(allfiles[i], gh_keywords = FALSE)
    generate_cit <- parse_r_citation(allfiles[i], citpath)
    parse_cit <- lapply(generate_cit, cff_parse_citation)
    merged <- merge_desc_cit(desc_parse, parse_cit)
    merged <- as.cff(merged)

    expect_snapshot(merged)

    expect_true(cff_validate(merged, verbose = FALSE))
  }
})
