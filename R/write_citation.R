#' Create a `inst/CITATION` file
#'
#' @description
#'
#' Creates a R CITATION file (inst/CITATION) from the metadata of a
#' CITATION.cff file or `cff` object.
#'
#' @param x It could be
#'    - A `bibentry` object created with [cff_to_bibtex()], [citation()] or
#'      [bibentry()]
#'    - Any of the valid inputs of [cff_to_bibtex()]:
#'      * A missing value. That would retrieve the DESCRIPTION file on your
#'       in-development package.
#'      * An existing [`cff`] object,
#'      * Path to a CITATION.cff file (`"*/CITATION.cff*"`),
#'      * The name of an installed package (`"jsonlite"`), or
#'      * Path to a DESCRIPTION file (`"*/DESCRIPTION*"`).
#' @param file Name of the file to write.
#' @inheritParams write_bib
#' @inheritDotParams cff_to_bibtex
#'
#' @export
#' @family bibtex
#'
#' @return Writes an `inst/CITATION` file and (invisibly) returns the
#' `bibentry` object that has been written to the file.
#'
#' @seealso [bibentry()] and `style` argument.
#'
#' @details
#'
#' For security reasons, if the file already exists the function would create
#' a backup copy on the same directory.
#'
#' @references
#'
#' R Core Team (2023). "CITATION files." In Writing R Extensions, chapter 1.9,
#' R version 4.3.0 (2023-04-21) edition.
#' <https://cran.r-project.org/doc/manuals/R-exts.html#CITATION-files>.
#'
#'
#' @examples
#' # Use a system file
#' f <- system.file("examples/preferred-citation-book.cff", package = "cffr")
#'
#' # Write to tmp dir
#' out <- file.path(tempdir(), "CITATION")
#' write_citation(f, file = out)
#'
#' # Check by reading, use meta object
#'
#' meta <- packageDescription("cffr")
#' meta$Encoding <- "UTF-8"
#'
#' utils::readCitationFile(out, meta)
#'
#'
#' # Append to the same file
#' bib2 <- citation()
#' write_citation(bib2, file = out, append = TRUE)
#'
#' utils::readCitationFile(out, meta)
write_citation <- function(x,
                           file = "./inst/CITATION",
                           append = FALSE,
                           verbose = TRUE,
                           ...) {
  if (!inherits(x, "bibentry")) {
    x <- cff_to_bibtex(x, ...)
  }

  bentr <- format(x, style = "R")

  # Check that the directory exists, if not create
  dir <- dirname(path.expand(file))
  if (!dir.exists(dir)) {
    if (verbose) cli::cli_alert_info("Creating directory {.path {dir}}")
    dir.create(dir, recursive = TRUE)
  }


  # If exists creates a backup
  if (file.exists(file)) {
    for (i in seq(1, 100)) {
      f <- paste0(file, ".bk", i)
      if (!file.exists(f)) break
    }

    if (verbose) {
      cli::cli_alert_info(
        "Creating a backup of {.file {file}} in {.file {f}}"
      )
    }
    file.copy(file, f)
  }


  fh <- file(file, encoding = "UTF-8", open = if (append) {
    "a+"
  } else {
    "w+"
  })
  on.exit(if (isOpen(fh)) close(fh))
  if (verbose) {
    cli::cli_alert_info("Writing {length(bentr)} entr{?y/ies} ...")
  }
  # Odd bug in RStudio... add empty lines
  writeLines(c("", bentr), fh)
  if (verbose) {
    cli::cli_alert_success("Results written to {.file {file}}")
  }
  invisible(x)
}
