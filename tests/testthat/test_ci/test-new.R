library(cffr)
installed <- as.data.frame(installed.packages()[, c("Package", "Version")])
installed <- installed[order(installed$Package), ]


rownames(installed) <- seq_len(nrow(installed))

l <- nrow(installed)

dir_path <- "./tests/testthat/test_ci/"

message("Testing a sample of ", nrow(installed), " packages")

res <- c()
withcit <- c()
note <- c()
for (i in seq_len(nrow(installed))) {
  pkg <- installed[i, ]$Package
  # Display some advances
  message(
    "Testing ", i, "/", nrow(installed),
    " (", sprintf("%05.02f", i / nrow(installed) * 100), "%) [",
    installed[i, ]$Package, "]"
  )
  cit_path <- file.path(find.package(installed[i, ]$Package), "CITATION")


  if (file.exists(cit_path)) {
    withcit <- c(withcit, TRUE)
  } else {
    withcit <- c(withcit, FALSE)
  }

  # Add cffobj
  cffobj <- try(
    cff_create(pkg, gh_keywords = FALSE, dependencies = FALSE),
    silent = TRUE
  )

  if (inherits(cffobj, "cff")) {
    s <- try(cff_validate(cffobj, verbose = FALSE), silent = TRUE)
    if (!is.logical(s)) s <- FALSE

    res <- c(res, s)
    note <- c(note, "")
  } else {
    res <- c(res, FALSE)
    note <- c(note, "Other errors")
  }
}

installed$with_citation <- withcit
installed$is_ok <- res
installed$note <- note

# Create report

options(cli.width = 60)
outmd <- file.path(dir_path, "results.md")
unlink(outmd)

cat("# Test all files\n\n", file = outmd)
write("## Session info\n", outmd, append = TRUE)
write("<details>", outmd, append = TRUE)
write("\n```r", outmd, append = TRUE)
conn <- file(outmd, "a")
capture.output(sessioninfo::session_info(), file = conn)
close(conn)
write("```\n", outmd, append = TRUE)
write("</details>", outmd, append = TRUE)

errors <- installed[installed$is_ok == FALSE, ]
errother <- errors$Package[errors$note == "Other errors"]
errcff <- setdiff(errors$Package, errother)
errother_df <- installed[installed$Package %in% errother, c(1, 2)]



write("\n## High level summary", outmd, append = TRUE)
write(paste0("\n- I checked ", nrow(installed), " packages"),
  outmd,
  append = TRUE
)
write(paste0("- Invalid cff in ", length(errcff), " packages"),
  outmd,
  append = TRUE
)
write(paste0("- I failed to generate cff in ", length(errother), " packages"),
  outmd,
  append = TRUE
)

okrate <- 100 * (1 - length(errcff) / (nrow(installed) - length(errother)))
write(paste0("- OK Rate: ", round(okrate, 2), "%"), outmd, append = TRUE)


if (nrow(errors) == 0) {
  write("\nNo errors, hooray!", outmd, append = TRUE)
} else {
  write("\nPackages with errors:", outmd, append = TRUE)
  conn <- file(outmd, "a")
  capture.output(knitr::kable(errors, row.names = FALSE),
    file = conn
  )
  close(conn)


  if (length(errother) > 0) {
    pk <- paste0(errother, collapse = ", ")
    line <- paste0("\n## Packages with errors not coming from cff")
    write(line, outmd, append = TRUE)
    conn <- file(outmd, "a")
    capture.output(knitr::kable(errother_df, row.names = FALSE),
      file = conn
    )
    close(conn)
  }

  if (length(errcff) > 0) {
    write("\n## cff errors reported", outmd, append = TRUE)
    # Prepare links
    cfflist <- paste0("- [", errcff, "](#", tolower(errcff), ")",
      collapse = "\n"
    )
    write(cfflist, outmd, append = TRUE)

    for (j in errcff) {
      write(paste0("\n### ", j, ""), outmd, append = TRUE)
      write("\n#### cff object\n", outmd, append = TRUE)
      write("<details>", outmd, append = TRUE)
      write("\n```r", outmd, append = TRUE)
      cff <- cff_create(j, gh_keywords = FALSE, dependencies = FALSE)
      conn <- file(outmd, "a")
      capture.output(print(cff), file = conn)
      close(conn)
      write("```\n", outmd, append = TRUE)
      write("</details>", outmd, append = TRUE)


      write("\n#### Validation results", outmd, append = TRUE)

      s <- cff_validate(cff, verbose = FALSE)
      df <- attr(s, "errors")
      conn <- file(outmd, "a")
      capture.output(knitr::kable(df, row.names = FALSE), file = conn)
      close(conn)
    }
  }
}
