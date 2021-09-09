test_that("Test CITATION.cff of all installed packages", {
  expect_snapshot_output({
    # skip_if(interactive()) # This breaks in R-Studio

    packs <- installed.packages()[, "Package"]
    vers <- installed.packages()[, "Version"]


    l <- length(packs)
    if (interactive()) {
      size <- 20
      if (l > size) {
        s <- sample(seq_len(l), size)
        packs <- packs[s]
        vers <- vers[s]
      }
    }
    res <- c()

    for (i in seq_len(length(packs))) {
      single <- suppressMessages(cff_validate(cff_create(packs[i])))
      
      if (!single) print_snapshot(obj= cff_create(packs[i]))

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
