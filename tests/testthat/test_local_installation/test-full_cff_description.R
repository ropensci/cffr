test_that("Test DESCRIPTION of all installed packages", {
  expect_snapshot_output({
    # skip("Skip by now") # by now

    packs <- installed.packages()[, "Package"]
    vers <- installed.packages()[, "Version"]

    l <- length(packs)
    if (interactive()) {
      size <- 600

      if (l > size) {
        s <- sample(seq_len(l), size)
        packs <- packs[s]
        vers <- vers[s]
      }
    }
    paths <- file.path(
      unlist(lapply(
        packs,
        find.package
      )),
      "DESCRIPTION"
    )


    res <- c()

    for (i in seq_len(length(paths))) {
      message(packs[i])

      single <- suppressMessages(cff_validate(cff_create(paths[i])))

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
