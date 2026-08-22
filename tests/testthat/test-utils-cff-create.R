test_that("license helpers parse common CRAN licenses", {
  cran_packs <- read.csv(system.file(
    "extdata/cran_licenses.csv",
    package = "cffr"
  ))
  cran_packs <- cran_packs[order(cran_packs$n, decreasing = TRUE), ]

  sel <- as.character(cran_packs[1:10, "LICENSE"])

  for (license in sel) {
    tmp <- withr::local_tempfile(pattern = "DESCRIPTION")
    file.copy(
      system.file("examples/DESCRIPTION_basic", package = "cffr"),
      tmp,
      overwrite = TRUE
    )
    p <- desc::desc_set("License", license, file = tmp)
    expect_silent(r <- cff_validate(cff_create(tmp), verbose = FALSE))
    expect_true(r, info = license)
  }
})
