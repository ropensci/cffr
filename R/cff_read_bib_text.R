#' Read BibTeX markup as a [`cff_ref_lst`] object
#'
#' @description
#' Convert a [`character`][character()] representing a BibTeX entry to a
#' [`cff_ref_lst`] object.
#'
#' @family bibtex
#' @family reading
#'
#' @seealso
#'
#' [cff_read_bib()] for reading `*.bib` files.
#'
#' @export
#'
#' @param x A vector of `character` objects with the full BibTeX string.
#' @param encoding Encoding to be assumed for `x`, see [readLines()].
#' @param ... Arguments passed on to [cff_read_bib()].
#'
#' @return
#'
#' An object of classes [`cff_ref_lst, cff`][cff_ref_lst] according to the
#' `definitions.references` specified in
#' the
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Citation File Format schema]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md). "))
#'
#'
#' ```
#' Each element of the `cff_ref_lst` object would have classes
#' [`cff_ref, cff`][cff_ref].
#'
#'
#' @details
#'
#' This is a helper function that writes `x` to a `*.bib` file and reads it with
#' [cff_read_bib()].
#'
#' This function requires \CRANpkg{bibtex} (>= 0.5.0) and uses
#' [bibtex::read.bib()].
#'
#' @examples
#' if (requireNamespace("bibtex", quietly = TRUE)) {
#'   x <- c(
#'     "@book{einstein1921,
#'       title        = {Relativity: The Special and the General Theory},
#'       author       = {Einstein, Albert},
#'       year         = 1920,
#'       publisher    = {Henry Holt and Company},
#'       address      = {London, United Kingdom},
#'       isbn         = 9781587340925
#'   }",
#'     "@misc{misc-full,
#'       title        = {Handing out random pamphlets in airports},
#'       author       = {Joe-Bob Missilany},
#'       year         = 1984,
#'       month        = oct,
#'       note         = {This is a full MISC entry},
#'       howpublished = {Handed out at O'Hare}
#'   }"
#'   )
#'
#'
#'   cff_read_bib_text(x)
#' }
cff_read_bib_text <- function(x, encoding = "UTF-8", ...) {
  # Validations
  if (!inherits(x, "character")) {
    cli::cli_abort(
      paste0(
        "{.arg x} should be a {.cls character}, not a ",
        "{.cls {class(x)}}."
      )
    )
  }

  if (any(grepl("\\.bib$", x, ignore.case = TRUE))) {
    cli::cli_alert_warning(
      paste0("{.arg x} seems to be a {.val .bib} file, not a BibTeX entry.")
    )
    cli::cli_alert_info("Reading {.arg x} with {.fn cffr:cff_read_bib}")
    the_cff <- cff_read_bib(x, encoding = encoding, ...)
    return(the_cff)
  }

  if (!any(grepl("^@", x))) {
    cli::cli_alert_warning(
      paste0("{.arg x} doesn't look as a BibTeX entry. Check the results.")
    )
  }
  # Write x to a tempfile
  file <- tempfile(fileext = ".bib")
  writeLines(x, file)
  the_cff <- cff_read_bib(file, encoding = encoding, ...)
  unlink(file)
  the_cff
}
