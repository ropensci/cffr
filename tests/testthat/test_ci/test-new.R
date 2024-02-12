
library(cffr)

installed <- as.data.frame(installed.packages()[, c("Package", "Version")])
installed <- installed[order(installed$Package), ]
# installed <- installed[1:50, ]

rownames(installed) <- seq_len(nrow(installed))

l <- nrow(installed)

dir_path <- "./tests/testthat/test_ci/"
dbcsv <- file.path(dir_path, "allpackages.csv")

# Initial set of packages
write.csv(installed, file = dbcsv, row.names = FALSE)

res <- c()
withcit <- c()
note <- c()
for (i in seq_len(nrow(installed))) {
  pkg <- installed[i, ]$Package
  # Display some advances
  message(
    "Testing ", i, "/", nrow(installed),
    " (", sprintf("%05.02f", i / nrow(installed) * 100), "%) ["
  ,installed[i, ]$Package, "]")
  cit_path <- file.path(find.package(installed[i, ]$Package), "CITATION")


  if (file.exists(cit_path)) {
    withcit <- c(withcit, TRUE)
  } else {
    withcit <- c(withcit, FALSE)
  }

  # Add cffobj
  cffobj <- try(
    cff_create(pkg, gh_keywords = FALSE, dependencies = FALSE), silent = TRUE)

  if(inherits(cffobj, "cff")){
  s <- try(cff_validate(cffobj, verbose = FALSE), silent = TRUE)
  if(!is.logical(s)) s <- FALSE

  res <- c(res, s)
  note <- c(note, "ok, cff")
  } else {
    res <- c(res, FALSE)
    note <- c(note, "Other errors")
  }
}

installed$with_citation <- withcit
installed$is_ok <- res
installed$note <- note


outmd <- file.path(dir_path, "results.md")
capture.output(knitr::kable(installed), file = outmd)


