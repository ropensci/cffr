test_that("Check dependencies", {
  skip_on_cran()
  deps <- parse_dependencies(system.file("DESCRIPTION", package = "cffr"))

  # Extract selected fields
  selected <- lapply(deps, function(x) {
    y <- x[names(x) %in% c("title", "url", "repository")]
    return(y)
  })

  class(selected) <- "cff"
  expect_snapshot(print(selected))
})
