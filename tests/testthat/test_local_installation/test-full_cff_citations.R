test_that("Test CITATION parsing of a random sample of installed packages", {
  expect_snapshot_output({
    print_snapshot("Sessioninfo", sessionInfo())

    installed <- installed.packages()[, "Package"]
    vers <- installed.packages()[, "Version"]


    l <- length(installed)

    if (interactive()) {
      size <- 1000
      if (l > size) {
        s <- sample(seq_len(l), size)
        installed <- installed[s]
        vers <- vers[s]
      }
    }


    print_snapshot("Summary", paste(
      "testing a sample of",
      length(installed), "installed packages"
    ))



    f <- 0
    withcit <- c()
    res <- c()
    for (i in 1:length(installed)) {
      message(installed[i])
      desc_path <- file.path(find.package(installed[i]), "DESCRIPTION")
      cit_path <- file.path(find.package(installed[i]), "CITATION")

      exist_cit <- ifelse(file.exists(cit_path), TRUE, FALSE)


      if (exist_cit) {
        f <- f + 1
        withcit <- c(withcit, installed[i])
        citmeta <- parse_r_citation(desc_path, cit_path)

        citobj <- lapply(citmeta, cff_parse_citation)
        if (length(citobj) == 0) citobj <- NULL
        cffobj <- cff_description(desc_path)

        # Add cffobj

        cffobj$doi <- clean_str(citobj[[1]]$doi)
        cffobjend <- c(cffobj,
          "preferred-citation" = citobj[1],
          references = list(citobj[-1])
        )



        # Merge identifiers
        oldids <- cffobjend$identifiers
        cffobjend$identifiers <- c(
          citobj[[1]]$identifiers,
          oldids
        )

        cffobjend <- as.cff(cffobjend)

        s <- suppressMessages(cff_validate(cffobjend))

        res <- c(res, s)

        if (!s) {
          print_snapshot(paste("Errors on", installed[i]), cff_validate(cffobjend))
        }
      }
    }

    v <- unname(vers[installed %in% withcit])

    print_snapshot(
      paste("Packages with CITATION file:", f),
      data.frame(
        package = withcit, version = v,
        valid = res
      )
    )
  })
})
