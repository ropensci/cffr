test_that("Test CITATION.cff of all installed packages", {
  expect_snapshot_output({

    skip_if(interactive()) # This breaks in R-Studio

    packs <- installed.packages()[, "Package"]
    vers <- installed.packages()[, "Version"]



    res <- c()

    for (i in seq_len(length(packs))) {
      single <- suppressMessages(cff_validate(cff_create(packs[i])))

      res <- c(res, single)
    }

    df <- data.frame(
      package = packs,
      version = vers,
      res = res
    )

    print_snapshot("Installed packages", paste(nrow(df), "packages"))

    print_snapshot("Errors", df[df$res == FALSE, ])
  })
})
