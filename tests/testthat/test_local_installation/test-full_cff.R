test_that("Test ALL installed packages", {
  expect_snapshot_output({
    # skip("Skip by now") # by now

    print_snapshot("Sessioninfo", sessionInfo())

    installed <- as.data.frame(installed.packages()[, c("Package", "Version")])
    installed <- installed[order(installed$Package), ]
    l <- nrow(installed)

    if (interactive()) {
      size <- 1000
      if (l > size) {
        s <- sample(seq_len(l), size)
        installed <- installed[s, ]
      }
    }


    print_snapshot("Summary", paste(
      "testing a sample of",
      nrow(installed), "installed packages"
    ))




    res <- c()
    withcit <- c()



    for (i in c(1:nrow(installed))) {
      message(installed[i, ]$Package)
      desc_path <- file.path(find.package(installed[i, ]$Package), "DESCRIPTION")
      cit_path <- file.path(find.package(installed[i, ]$Package), "CITATION")


      if (file.exists(cit_path)) {
        message("with CITATION file")
        withcit <- c(withcit, TRUE)
        citobj <- parse_r_citation(desc_path, cit_path)
        citobj <- lapply(citobj, cff_parse_citation)
        if (length(citobj) == 0) citobj <- NULL
      } else {
        citobj <- NULL
        withcit <- c(withcit, FALSE)
      }

      # Add cffobj
      cffobj <- cff_description(desc_path)

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

      # Order
      cffobjend <- cffobjend[cff_schema_keys()]

      cffobjend <- as.cff(cffobjend)
      cffobjend

      s <- suppressMessages(cff_validate(cffobjend))

      res <- c(res, s)

      if (!s) {
        print_snapshot(paste("Errors on", installed[i]), cff_validate(cffobjend))
      }
    }



    installed$with_citation <- withcit
    installed$is_ok <- res


    print_snapshot(
      "Errors",
      installed[installed$is_ok == FALSE, ]
    )

    print_snapshot(
      paste("Packages processed:", nrow(installed)),
      installed
    )
  })

  write.csv(installed, "allpackages.csv", row.names = FALSE)

})
