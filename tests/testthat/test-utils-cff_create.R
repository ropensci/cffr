test_that("Parse Licenses on CRAN (Top 10)", {
  cran_packs <- read.csv(system.file(
    "extdata/cran_licenses.csv",
    package = "cffr"
  ))
  cran_packs <- cran_packs[order(cran_packs$n, decreasing = TRUE), ]

  sel <- as.character(cran_packs[1:10, "LICENSE"])

  # Tempfile DESCRIPTION that we use for modifications
  tmp <- tempfile("DESCRIPTION")
  file.copy(
    system.file("examples/DESCRIPTION_basic", package = "cffr"),
    tmp,
    overwrite = TRUE
  )
  for (i in seq_along(sel)) {
    p <- desc::desc_set("License", sel[i], file = tmp)
    expect_silent(r <- cff_validate(cff_create(tmp), verbose = FALSE))
    expect_true(r)
  }
})
