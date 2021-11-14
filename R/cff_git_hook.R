
cff_git_hook <- function() {
  # nocov start
  bash_file <- system.file("bash/citation-cff-pre-commit.sh", package = "cffr")

  if (requireNamespace("usethis", quietly = TRUE)) {
    usethis::use_git_hook(
      "pre-commit",
      readLines(con = bash_file)
    )
  }
  # nocov end
}
