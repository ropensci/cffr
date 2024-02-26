#' Previous API: Create BibTeX entries from several sources
#'
#' @description
#' `r lifecycle::badge('superseded')` Please use [cff_to_bibentry()] instead.
#'
#' @rdname deprecated_cff_to_bib
#' @inheritParams cff_to_bibentry
#' @export
#' @keywords internal
#' @family deprecated
#'
#' @return See [cff_to_bibentry()].
#' @examples
#' \donttest{
#' # From a cff object
#' cff_object <- cff()
#'
#' cff_object
#'
#' # bibentry object
#' bib <- cff_to_bibentry(cff_object)
#' }
cff_extract_to_bibtex <- function(x,
                                  what = c("preferred", "references", "all")) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_soft(
      "0.5.0", "cff_extract_to_bibtex()",
      details = "Function renamed, use `cff_to_bibentry()` instead."
    )
  }
  cff_to_bibentry(x, what)
}

#' @rdname deprecated_cff_to_bib
#' @export
#' @keywords internal
cff_to_bibtex <- function(x,
                          what = c("preferred", "references", "all")) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_soft(
      "0.6.0", "cff_extract_to_bibtex()",
      details = "Function renamed, use `cff_to_bibentry()` instead."
    )
  }
  cff_to_bibentry(x, what)
}

#' Previous API: Create a [`cff`][cff-class] object from BibTeX entries
#'
#' @description
#'
#' `r lifecycle::badge('superseded')` Please use either [cff_read_bib()] or
#' [cff_read_biblines()] instead.
#'
#' @rdname deprecated_cff_from_bib
#' @export
#' @keywords internal
#' @family deprecated
#'
#' @param x The source that would be used for generating the
#'   [`cff`][cff-class] object. Must be `character` object indicating either:
#'   - The path to a BibTeX file.
#'   - A vector of characters with the full BibTeX string. See **Examples**.
#' @param encoding Encoding to be assumed for `x`. See [readLines()].
#' @param ... Other arguments passed to [bibtex::read.bib()].
#'
#'
#' @return
#'
#' See [cff_read_bib()].
#'
#'
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
#'   cff_read_biblines(x)
#'
#'   # From a file
#'
#'   x2 <- system.file("examples/example.bib", package = "cffr")
#'   cff_read_bib(x2)
#' }
cff_from_bibtex <- function(x, encoding = "UTF-8", ...) {
  if (length(x) == 1 && file.exists(x)) {
    if (requireNamespace("lifecycle", quietly = TRUE)) {
      lifecycle::deprecate_soft(
        "0.5.0", "cff_from_bibtex()",
        details = "Function renamed, use `cff_read_bib()` instead."
      )
    }

    # Read bib file
    return(cff_read_bib(x, encoding = encoding, ...))
  }

  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_soft(
      "0.5.0", "cff_from_bibtex()",
      details = "Function renamed, use `cff_read_biblines()` instead."
    )
  }
  cff_read_biblines(x, encoding = encoding, ...)
}
