test_that("Test ALL installed packages", {

  # skip("Skip by now") # by now

  expect_snapshot_output(print_snapshot("Sessioninfo", sessionInfo()))

  installed <- as.data.frame(installed.packages()[, c("Package", "Version")])
  installed <- installed[order(installed$Package), ]
  # installed <- installed[1:200,]
  # Remove bugs
  bugs <- sort(c(
    "DCluster", "surveillance"
  ))
  msg <- paste(
    "Skipping ", paste(bugs, collapse = ", "),
    ". cffr fails on this batch testing."
  )
  message(msg)


  expect_snapshot_output(print(msg))

  installed <- installed[!installed$Package %in% bugs, ]


  l <- nrow(installed)

  if (interactive()) {
    size <- 3000
    if (l > size) {
      s <- sort(sample(seq_len(l), size))
      installed <- installed[s, ]

      expect_snapshot_output(print_snapshot(
        "Interactive detected",
        paste("Running on a sample of size:", nrow(installed))
      ))
    }
  }


  expect_snapshot_output(print_snapshot("Summary", paste(
    "testing a sample of",
    nrow(installed), "installed packages"
  )))
  message("Sample of ", nrow(installed))

  res <- c()
  withcit <- c()

  for (i in seq_len(nrow(installed))) {
    pkg <- installed[i, ]$Package
    message(pkg)
    cit_path <- file.path(find.package(installed[i, ]$Package), "CITATION")


    if (file.exists(cit_path)) {
      message("with CITATION file")
      withcit <- c(withcit, TRUE)
    } else {
      withcit <- c(withcit, FALSE)
    }

    # Add cffobj
    cffobj <- cff_create(pkg)

    s <- suppressMessages(cff_validate(cffobj))


    res <- c(res, s)

    if (!s) {
      message("with CITATION file")
    }
  }


  expect_snapshot_output({
    installed$with_citation <- withcit
    installed$is_ok <- res

    errors <- installed[installed$is_ok == FALSE, ]


    if (nrow(errors) > 0) {
      print_snapshot(
        "Errors",
        errors
      )

      print_snapshot(
        "Error reports for ",
        paste(errors$Package, collapse = ", ")
      )

      for (j in seq_len(nrow(errors))) {
        pkg <- errors[j, ]$Package
        cff <- cff_create(pkg)

        print_snapshot(paste0(pkg, ": cffr object"), cff)

        print_snapshot("Validation results", cff_validate(cff))
      }
    } else {
      print_snapshot(obj = "No errors, hooray!")
    }
  })

  write.csv(installed, "allpackages.csv", row.names = FALSE)
})
