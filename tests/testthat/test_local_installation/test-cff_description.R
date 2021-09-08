test_that("Test DESCRIPTION of all installed packages", {
  expect_snapshot_output({
    packs <- installed.packages()[, "Package"]

    paths <- file.path(
      unlist(lapply(
        packs,
        find.package
      )),
      "DESCRIPTION"
    )


    res <- c()
    vers <- c()
    for (i in seq_len(length(paths))) {
      single <- suppressMessages(cff_validate(cff_create(paths[i])))
      version <- packageVersion(packs[i])
      res <- c(res, single)
      vers <- c(vers, version)
    }

    df <- data.frame(package = packs, 
    version = vers,
    res = res)
    
    print_snapshot("Summary of installed packages", df)
  })
})


# For all the example DESCRIPTION files the test is part of test-cff_create
