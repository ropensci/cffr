test_that("Test CITATION parsing of all installed packages", {
  expect_snapshot_output({
    print_snapshot("Sessioninfo", sessionInfo())

    installed <- installed.packages()[, "Package"]
    vers <- installed.packages()[, "Version"]

    # Has two dois on CITATION
    installed <- installed[installed != "viridis"]
    installed <- installed[installed != "viridisLite"]

    print_snapshot("Summary", paste(
      "testing",
      length(installed), "packages"
    ))



    f <- 0
    withcit <- c()
    for (i in 1:length(installed)) {
      desc_path <- file.path(find.package(installed[i]), "DESCRIPTION")
      cit_path <- file.path(find.package(installed[i]), "CITATION")

      exist_cit <- ifelse(file.exists(cit_path), TRUE, FALSE)


      if (exist_cit) {
        f <- f + 1
        withcit <- c(withcit, installed[i])
        citmeta <- parse_r_citation(desc_path, cit_path)

        citobj <- lapply(citmeta, cff_parse_citation)
        cffobj <- cff_description(desc_path)

        # Add cffobj

        cffobj$doi <- clean_str(citobj[[1]]$doi)
        cffobjend <- c(cffobj,
          "preferred-citation" = citobj[1],
          references = list(citobj[-1])
        )



        # Add DOI to identifiers
        if (!is.null(cffobjend$doi)) {
          oldids <- cffobjend$identifiers
          cffobjend$identifiers <- c(
            list(list(type = "doi", value = cffobjend$doi)),
            oldids
          )
        }
        cffobjend <- as.cff(cffobjend)

        s <- suppressMessages(cff_validate(cffobjend))
        if (!s) {
          print_snapshot(paste("Errors on", installed[i]), cff_validate(cffobjend))
        }
      }
    }

    print_snapshot(
      paste("Packages with CITATION file:", f),
      paste(withcit, collapse = ", ")
    )
  })
})
