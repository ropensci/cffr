test_that("Merge all DESCRIPTION files with CITATION_basic", {
  rvers <- getRversion()
  skip_if(!grepl("^4.5", rvers), "Snapshot created with R 4.5.*")
  skip_on_cran()

  allfiles <- list.files(
    system.file("examples", package = "cffr"),
    pattern = "^DESC",
    full.names = TRUE
  )

  citpath <- system.file("examples/CITATION_basic", package = "cffr")
  for (i in seq_along(allfiles)) {
    desc_cff <- cff_read_description(allfiles[i], gh_keywords = FALSE)
    generate_cit <- cff_safe_read_citation(allfiles[i], citpath)
    merged <- merge_desc_cit(desc_cff, generate_cit)
    merged <- as_cff(merged)

    expect_snapshot(merged)

    expect_true(cff_validate(merged, verbose = FALSE))
  }
})

test_that("Check dependencies", {
  skip_on_cran()
  deps <- get_dependencies(system.file("DESCRIPTION", package = "cffr"))

  # Extract selected fields
  selected <- lapply(deps, function(x) {
    y <- x[names(x) %in% c("title", "url", "repository")]
    y
  })

  class(selected) <- "cff"
  expect_snapshot(print(selected))
})
