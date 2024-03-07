test_that("Merge all DESCRIPTION files with CITATION_basic", {
  allfiles <- list.files(
    system.file("examples", package = "cffr"),
    pattern = "^DESC", full.names = TRUE
  )

  citpath <- system.file("examples/CITATION_basic",
    package = "cffr"
  )
  for (i in seq_len(length(allfiles))) {
    desc_cff <- cff_read_description(allfiles[i], gh_keywords = FALSE)
    generate_cit <- cff_safe_read_citation(allfiles[i], citpath)
    merged <- merge_desc_cit(desc_cff, generate_cit)
    merged <- as_cff(merged)

    expect_snapshot(merged)

    expect_true(cff_validate(merged, verbose = FALSE))
  }
})
