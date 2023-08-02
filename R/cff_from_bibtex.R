#' Create a cff object from BibTeX entries
#'
#' @description
#'
#' Extract the information of a BibTeX file or BibTeX entry and creates the
#' corresponding [`cff`] object with [cff_parse_citation()].
#'
#' @param x The source that would be used for generating the `cff` object. A
#' `character` object indicating either:
#'   - The path to a BibTeX file.
#'   - A vector of characters with the full BibTeX string. See **Examples**
#' @param encoding Encoding to be assumed for `x`. See [readLines()].
#' @param ... Other arguments passed to [bibtex::read.bib()].
#'
#' @family BibTeX helpers
#'
#' @return A [`cff`] object ready to be used on [cff_create()].
#'
#' @export
#'
#' @details
#'
#' This function requires the package \CRANpkg{bibtex} (>= 0.5.0), that is
#' listed as `Suggested` by \CRANpkg{cffr}.
#'
#' @seealso
#'
#' `vignette("bibtex_cff", package = "cffr")` to learn about the mapping of
#' information between BibTeX and CITATION.cff.
#'
#' @examples
#' if (requireNamespace("bibtex", quietly = TRUE)) {
#'   x <- c(
#'     "@book{einstein1921,
#'     title        = {Relativity: The Special and the General Theory},
#'     author       = {Einstein, Albert},
#'     year         = 1920,
#'     publisher    = {Henry Holt and Company},
#'     address      = {London, United Kingdom},
#'     isbn         = 9781587340925
#' }",
#'     "@misc{misc-full,
#'     title        = {Handing out random pamphlets in airports},
#'     author       = {Joe-Bob Missilany},
#'     year         = 1984,
#'     month        = oct,
#'     note         = {This is a full MISC entry},
#'     howpublished = {Handed out at O'Hare}
#' }"
#'   )
#'
#'   cff_from_bibtex(x)
#'
#'   # From a file
#'
#'   x2 <- system.file("examples/example.bib", package = "cffr")
#'   cff_from_bibtex(x2)
#' }
cff_from_bibtex <- function(x, encoding = "UTF-8", ...) {
  # nocov start
  if (!requireNamespace("bibtex", quietly = TRUE)) {
    msg <- paste0(
      "{.pkg bibtex} package required for using this function: ",
      '{.run install.packages("bibtex")}'
    )
    cli::cli_abort(msg)
  }
  # nocov end
  if (!is.character(x)) {
    msg <- paste0(
      "{.arg x} should be a {.cls character} object. ",
      "You provided an object of class(es) {.cls {class(x)}}"
    )
    cli::cli_abort(msg)
  }

  if (length(x) == 1 && file.exists(x)) {
    # Read bib file
    file <- x
  } else {
    # Write x to a tempfile
    file <- tempfile(fileext = ".bib")
    writeLines(x, file)
  }
  # Read from tempfile
  read_bib <- bibtex::read.bib(file = file, encoding = encoding, ...)


  tocff <- cff_parse_citation(read_bib)
  return(tocff)
}
