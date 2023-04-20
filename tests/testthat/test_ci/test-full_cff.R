test_that("Test ALL installed packages", {
  expect_snapshot(print_snapshot("Sessioninfo", sessionInfo()))

  installed <- as.data.frame(installed.packages()[, c("Package", "Version")])
  installed <- installed[order(installed$Package), ]

  rownames(installed) <- seq_len(nrow(installed))

  # # Small sample
  # installed <- installed[sample(seq_len(nrow(installed)), 20), ]

  l <- nrow(installed)

  # Initial set of packages
  write.csv(installed, "allpackages.csv", row.names = FALSE)
  expect_snapshot(print_snapshot("Summary", paste(
    "testing a sample of",
    nrow(installed), "installed packages"
  )))
  message("Sample of ", nrow(installed))

  res <- c()
  withcit <- c()

  for (i in seq_len(nrow(installed))) {
    pkg <- installed[i, ]$Package
    # Display some advances
    message(
      "Testing ", i, "/", nrow(installed),
      " (", sprintf("%05.02f", i / nrow(installed) * 100), "%)"
    )
    cit_path <- file.path(find.package(installed[i, ]$Package), "CITATION")


    if (file.exists(cit_path)) {
      withcit <- c(withcit, TRUE)
    } else {
      withcit <- c(withcit, FALSE)
    }

    # Add cffobj
    cffobj <- suppressMessages(
      cff_create(pkg, gh_keywords = FALSE, dependencies = FALSE)
    )

    s <- suppressMessages(cff_validate(cffobj))


    res <- c(res, s)
  }


  expect_snapshot({
    installed$with_citation <- withcit
    installed$is_ok <- res

    errors <- installed[installed$is_ok == FALSE, ]

    okrate <- 1 - nrow(errors) / nrow(installed)

    expect_snapshot(print_snapshot(
      "OK rate",
      sprintf("%1.2f%%", 100 * okrate)
    ))


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
        cff <- cff_create(pkg, gh_keywords = FALSE, dependencies = FALSE)

        print_snapshot(paste0(pkg, ": cffr object"), cff)

        print_snapshot("Validation results", cff_validate(cff))
      }
    } else {
      print_snapshot(obj = "No errors, hooray!")
    }
  })

  write.csv(installed, "allpackages.csv", row.names = FALSE)
})
