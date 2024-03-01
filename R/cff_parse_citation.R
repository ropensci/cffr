#' Parse a `bibentry` to `cff`
#'
#' Parse a `bibentry` object to a valid format for a `CITATION.cff` file.
#'
#' @seealso [cff_create()], `vignette("bibtex_cff", "cffr")`, [bibentry()]
#'
#' @export
#'
#' @family coercing
#'
#' @param bib A `bibentry` object, either created with [bibentry()]
#'   (preferred) or [citEntry()].
#'
#' @return A list [`cff`] object ready to be used on [cff_create()].
#'
#' @details
#' This is a helper function designed to help on adding or
#' replacing the auto-generated authors of the package. See **Examples**.
#'
#' This function tries to adapt a `bibentry` object (generated with [bibentry()]
#' or [citEntry()]) to the CFF standard.
#'
#' ## Entry types considered
#'
#' - **Article**, **Book**, **Booklet**, **InBook**, **InCollection**,
#'   **InProceedings**, **Manual**, **MastersThesis**, **Misc**, **PhDThesis**,
#'   **Proceedings**, **TechReport**, **Unpublished**. See [bibentry()]
#'   for more information.
#'
#'  Note that **Conference** is not implemented in
#'  [bibentry()], however is equivalent to **InProceedings** (Patashnik (1988)).
#'
#' ## Fields considered
#'
#' - **address**, **author**, **booktitle**, **chapter**, **edition**,
#'   **editor**, **howpublished**, **institution**,  **journal**, **key**,
#'   **month**, **note**, **number**, **organization**, **pages**,
#'   **publisher**, **school**, **series**, **title**, **type**, **year**.
#'
#'  **annote** and **crossref** fields are ignored.
#'
#'
#' @references
#' - Patashnik, Oren. "BIBTEXTING" February 1988.
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' - Haines, R., & The Ruby Citation File Format Developers. (2021).
#'   *Ruby CFF Library (Version 0.9.0)* (Computer software).
#'   \doi{10.5281/zenodo.1184077}.
#'
#' @examples
#' \donttest{
#' bib <- citation("base")
#' bib
#'
#'
#' # To cff
#' bib_to_cff <- cff_parse_citation(bib)
#' bib_to_cff
#'
#' # Create the object
#' new_cff <- cff()
#'
#' full <- cff_create(new_cff, keys = list("preferred-citation" = bib_to_cff))
#'
#' full
#' # Validate
#' cff_validate(full)
#'
#' # Several citations
#'
#' cff_parse_citation(citation("rmarkdown"))
#' }
cff_parse_citation <- function(bib) {
  if (!inherits(bib, "bibentry")) {
    return(NULL)
  }

  ## Unname
  bib <- unname(bib)

  the_obj <- lapply(bib, make_cff_reference)
  clean_up <- vapply(the_obj, is.null, FUN.VALUE = logical(1))

  # No results
  if (all(clean_up)) {
    return(NULL)
  }
  the_obj <- the_obj[!clean_up]
  new_cff(the_obj)
}
