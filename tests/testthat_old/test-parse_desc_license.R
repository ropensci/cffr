test_that("Parse Licenses on CRAN (Top 50, 98% cov)", {
  cran_packs <- read.csv(system.file("extdata/cran_licenses.csv",
    package = "cffr"
  ))
  cran_packs <- cran_packs[order(cran_packs$n, decreasing = TRUE), ]

  sel <- as.character(cran_packs[1:50, "LICENSE"])

  # Tempfile DESCRIPTION that we use for modifications
  tmp <- tempfile("DESCRIPTION")
  file.copy(system.file("examples/DESCRIPTION_demo", package = "cffr"),
    tmp,
    overwrite = TRUE
  )
  for (i in seq_len(length(sel))) {
    p <- desc::desc_set("License", sel[i], file = tmp)
    r <- suppressMessages(cff_validate(cff_create(tmp)))
    expect_true(r)
  }
})
