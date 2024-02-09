#' Previous API: Create BibTeX entries from several sources
#'
#' @description
#' `r lifecycle::badge('superseded')`
#' Please use [cff_to_bibentry()] instead.
#'
#' @rdname previous_cff_to_bib
#' @inheritParams cff_to_bibentry
#' @export
#' @keywords internal
#'
#' @return See [cff_to_bibentry()]
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
  cff_to_bibentry(x, what)
}

#' @export
#' @rdname previous_cff_to_bib
#' @keywords internal
cff_to_bibtex <- function(x, what = c("preferred", "references", "all")) {
  cff_to_bibentry(x, what)
}
