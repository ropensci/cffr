#' Export **R** objects to different file types
#'
#' @description
#'
#' Export **R** objects representing citations to specific file types:
#' - [cff_write_bib()] creates a `.bib` file.
#' - [cff_write_citation()] creates a **R** citation file as explained in
#'   Section 1.9 CITATION files of *Writing R Extensions* (R Core Team 2023).
#'
#' @param x A [`bibentry`][bibentry()] or a [`cff`][cff-class] object.
#' @param file Name of the file to be created. If `NULL` it would display the
#'   lines to be written.
#' @param append Whether to append the entries to an existing file or not.
#' @param verbose Display informative messages
#' @param ascii Whether to write the entries using ASCII characters only or not.
#' @inheritDotParams as_bibentry
#'
#' @references
#'
#' - R Core Team (2023). _Writing R Extensions_.
#'   <https://cran.r-project.org/doc/manuals/r-release/R-exts.html>
#'
#' @export
#' @rdname cff_write_misc
#' @family bibtex
#' @family writing
#'
#' @return
#' Writes the corresponding file specified on the `file` parameter.
#'
#' @details
#'
#' When `x` is a `cff` object it would be converted to `bibentry` using
#' [as_bibentry()].
#'
#' For security reasons, if the file already exists the function would create
#' a backup copy on the same directory.
#'
#' @seealso
#' `vignette("bibtex_cff", "cffr")`, [knitr::write_bib()] and the
#' following packages:
#' - \CRANpkg{bibtex}.
#' - \CRANpkg{RefManageR}
#' - \CRANpkg{rbibutils}
#'
#' @examples
#'
#' bib <- bibentry("Misc",
#'   title = "My title",
#'   author = "Fran Pérez"
#' )
#'
#' my_temp_bib <- tempfile(fileext = ".bib")
#'
#' cff_write_bib(bib, file = my_temp_bib)
#'
#' cat(readLines(my_temp_bib), sep = "\n")
#'
#' cff_write_bib(bib, file = my_temp_bib, ascii = TRUE, append = TRUE)
#'
#' cat(readLines(my_temp_bib), sep = "\n")
cff_write_bib <- function(x, file = tempfile(fileext = ".bib"), append = FALSE,
                          verbose = TRUE, ascii = FALSE, ...) {
  if (inherits(x, "cff")) {
    x <- as_bibentry(x, ...)
  }

  if (!inherits(x, "bibentry")) {
    cli::cli_abort(
      paste0(
        "{.arg x} should be a {.cls bibentry} object, not a ",
        "{.cls {class(x)}} object."
      )
    )
  }

  btex <- toBibtex(x)

  if (ascii) {
    # Base encoding as per file()
    btex <- encoded_utf_to_latex(btex)
    class(btex) <- "Bibtex"
  } else {
    btex <- enc2utf8(btex)
  }

  if (tools::file_ext(file) != "bib") file <- paste0(file, ".bib")
  write_lines_msg(btex, file, verbose, append)
  return(invisible(NULL))
}

#' @export
#' @rdname cff_write_misc
#' @name cff_write_citation
#' @examples
#'
#' # Create a CITATION file
#'
#' # Use a system file
#' f <- system.file("examples/preferred-citation-book.cff", package = "cffr")
#' a_cff <- cff_read(f)
#'
#' out <- file.path(tempdir(), "CITATION")
#' cff_write_citation(a_cff, file = out)
#'
#' # Check by reading, use meta object
#' meta <- packageDescription("cffr")
#' meta$Encoding <- "UTF-8"
#'
#' utils::readCitationFile(out, meta)
cff_write_citation <- function(x, file = tempfile("CITATION_"),
                               append = FALSE, verbose = TRUE, ...) {
  if (inherits(x, "cff")) {
    x <- as_bibentry(x, ...)
  }

  if (!inherits(x, "bibentry")) {
    cli::cli_abort(
      paste0(
        "{.arg x} should be a {.cls bibentry} object, not a ",
        "{.cls {class(x)}} object."
      )
    )
  }

  bentr <- format(x, style = "R")
  bentr <- c("", bentr)
  write_lines_msg(bentr, file, verbose, append)
  return(invisible(NULL))
}


write_lines_msg <- function(lines, file, verbose, append) {
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


  fh <- file(file, encoding = "UTF-8", open = ifelse(append, "a+", "w+"))
  on.exit(if (isOpen(fh)) close(fh))
  if (verbose) {
    cli::cli_alert_info("Writing {length(lines)} entr{?y/ies} ...")
  }

  writeLines(lines, fh)
  if (verbose) {
    cli::cli_alert_success("Results written to {.file {file}}")
  }
}
