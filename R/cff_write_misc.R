#' Export \R objects to multiple file types
#'
#' @description
#' Export \R objects representing citations to specific file formats:
#' - [cff_write_bib()] creates a `.bib` file.
#' - [cff_write_citation()] creates an \R citation file as described in
#'   Section 1.9 of *Writing R Extensions* (R Core Team 2023).
#'
#' @param x A [`bibentry`] or a [`cff`] object.
#' @param file Name of the file to be created. If `NULL`, the lines are
#'   displayed instead.
#' @param append Logical. Whether to append entries to an existing file.
#' @param verbose Logical. Display informative messages.
#' @param ascii Logical. Whether to write entries using ASCII characters only.
#' @inheritDotParams as_bibentry.cff what
#' @inheritDotParams as_bibentry.cff_ref
#' @inheritDotParams as_bibentry.cff_ref_lst
#'
#' @return
#' Writes the corresponding file specified by the `file` argument.
#'
#' @details
#' When `x` is a `cff` object, it is converted to BibTeX using
#' [toBibtex.cff()].
#'
#' For security reasons, if the file already exists, the function creates
#' a backup copy in the same directory.
#'
#' @references
#' R Core Team (2023). _Writing R Extensions_.
#' <https://cran.r-project.org/doc/manuals/r-release/R-exts.html>
#'
#' @seealso
#' `vignette("bibtex-cff", package = "cffr")`, [knitr::write_bib()] and the
#' following packages:
#' - \CRANpkg{bibtex}.
#' - \CRANpkg{RefManageR}.
#' - \CRANpkg{rbibutils}.
#'
#' @family bibtex
#' @family writing
#' @rdname cff_write_misc
#' @export
#' @encoding UTF-8
#' @examples
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
cff_write_bib <- function(
  x,
  file = tempfile(fileext = ".bib"),
  append = FALSE,
  verbose = TRUE,
  ascii = FALSE,
  ...
) {
  x <- cff_coerce_bibentry(x, ...)

  btex <- toBibtex(x)

  if (ascii) {
    # Use base encoding as in `file()`.
    btex <- encoded_utf_to_latex(btex)
    class(btex) <- "Bibtex"
  } else {
    btex <- enc2utf8(btex)
  }

  if (detect_x_source(file) != "bib") {
    file <- paste0(file, ".bib")
  }
  write_lines_msg(btex, file, verbose, append)
  invisible(NULL)
}

#' @rdname cff_write_misc
#' @name cff_write_citation
#' @export
#' @encoding UTF-8
#' @examples
#' # Create an R citation file.
#' # Use a system file.
#' f <- system.file("examples/preferred-citation-book.cff", package = "cffr")
#' a_cff <- cff_read(f)
#'
#' out <- file.path(tempdir(), "CITATION")
#' cff_write_citation(a_cff, file = out)
#'
#' # Check by reading with a meta object.
#' meta <- packageDescription("cffr")
#' meta$Encoding <- "UTF-8"
#'
#' utils::readCitationFile(out, meta)
cff_write_citation <- function(
  x,
  file = tempfile("CITATION_"),
  append = FALSE,
  verbose = TRUE,
  ...
) {
  x <- cff_coerce_bibentry(x, ...)

  bentr <- format(x, style = "R")
  bentr <- c("", bentr)
  write_lines_msg(bentr, file, verbose, append)
  invisible(NULL)
}

cff_coerce_bibentry <- function(x, ...) {
  error_call <- parent.frame()

  if (inherits(x, "cff")) {
    x <- as_bibentry(x, ...)
  }

  if (!inherits(x, "bibentry")) {
    cli::cli_abort(
      paste0(
        "{.arg x} must be a {.cls bibentry} object, not a ",
        "{.cls {class(x)}} object."
      ),
      call = error_call
    )
  }

  x
}
