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
    desc::desc_set("License", license, file = tmp)
    expect_silent(r <- cff_validate(cff_create(tmp), verbose = FALSE))
    expect_true(r, info = license)
  }
})

test_that("license helpers preserve all recognized alternatives", {
  tmp <- withr::local_tempfile(pattern = "DESCRIPTION")
  file.copy(
    system.file("examples/DESCRIPTION_basic", package = "cffr"),
    tmp,
    overwrite = TRUE
  )

  desc::desc_set("License", "LGPL-2 | LGPL-3 | GPL-2 | GPL-3", file = tmp)
  pkg <- desc::desc(tmp)
  licenses <- get_desc_license(pkg)

  expect_setequal(
    licenses,
    c("LGPL-2.0-only", "LGPL-3.0-only", "GPL-2.0-only", "GPL-3.0-only")
  )
  expect_length(licenses, 4)
  expect_true(cff_validate(cff_create(tmp), verbose = FALSE))

  desc::desc_set("License", "GPL-2 | GPL (== 2) | GPL-3", file = tmp)
  expect_setequal(
    get_desc_license(desc::desc(tmp)),
    c("GPL-2.0-only", "GPL-3.0-only")
  )
  expect_true(cff_validate(cff_create(tmp), verbose = FALSE))
})
