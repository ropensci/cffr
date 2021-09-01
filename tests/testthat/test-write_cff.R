test_that("Validate all DESCRIPTION files", {
  allfiles <- list.files(system.file("examples",
    package = "cffR"
  ), pattern = "^DESC", full.names = TRUE)

  names <- list.files(system.file("examples",
    package = "cffR"
  ), pattern = "^DESC", full.names = FALSE)

  for (i in seq_len(length(allfiles))) {
    tmp <- tempfile(pattern = names[i], fileext = ".cff")
    write_cff(allfiles[i], outfile = tmp)
    expect_true(suppressMessages(cff_validate(tmp)))
  }
})
