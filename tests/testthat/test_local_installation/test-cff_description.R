test_that("Test DESCRIPTION of all installed packages", {
  expect_snapshot_output({
    packs <- installed.packages()[, "Package"]
    vers <- installed.packages()[, "Version"]

    paths <- file.path(
      unlist(lapply(
        packs,
        find.package
      )),
      "DESCRIPTION"
    )


    res <- c()

    for (i in seq_len(length(paths))) {
      single <- suppressMessages(cff_validate(cff_create(paths[i])))

      res <- c(res, single)
    }

    df <- data.frame(
      package = packs,
      version = vers,
      res = res
    )

    print_snapshot("Summary of installed packages", df)
  })
})


# For all the example DESCRIPTION files the test is part of test-cff_create
