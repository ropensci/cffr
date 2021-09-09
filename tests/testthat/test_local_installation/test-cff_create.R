test_that("Test CITATION.cff of all installed packages", {
  expect_snapshot_output({
    packs <- installed.packages()[, "Package"][1:10]
    vers <- installed.packages()[, "Version"][1:10]

    res <- c()
    i <- 1
    for (i in seq_len(length(packs))) {
      single <- suppressMessages(cff_validate(cff_create(packs[i])))

      res <- c(res, single)
    }

    df <- data.frame(
      package = packs,
      version = vers,
      res = res
    )

    print(sessionInfo())
    options(max.print = 20000)
    print_snapshot("Summary of installed packages", df)
  })
})


# For all the example DESCRIPTION files the test is part of test-cff_create
