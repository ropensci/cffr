#' Create BibTeX entries from a package
#'
#' @description
#'
#' Extract the information of a package to BibTeX. This is done by creating a
#' `cff` object with `cff_create()` and extracting the corresponding entries
#' with `cff_to_bibtex()`.
#'
#' @inheritParams cff_create
#' @param what Fields to extract. The value could be:
#'   - `preferred`: This would create a single entry with the main citation
#'      info of the package.
#'   - `references`: Extract all the entries on `references`.
#'   - `all`: A combination of the previous two options. This would extract
#'      both the preferred citation info and the references.
#'
#' @family bibtex
#'
#' @return A `bibentry` object or a list of `bibentry` objects. This could
#' be parsed to BibTeX using [toBibtex()]
#'
#' @export
#'
#' @examples
#' \donttest{
#'
#' jsonvalidate <- cff_extract_to_bibtex("jsonvalidate")
#'
#' jsonvalidate
#'
#' toBibtex(jsonvalidate)
#'
#' lite <- cff_extract_to_bibtex("jsonlite", "references")
#'
#' lite
#'
#' toBibtex(lite)
#' }
cff_extract_to_bibtex <- function(x,
                                  what = "preferred") {
  if (!(what %in% c("preferred", "references", "all"))) {
    stop("'what' should be on of 'preferred, 'references' or 'all'",
      call. = FALSE
    )
  }


  obj <- cff_create(x)

  if (what == "preferred") {
    return(cff_to_bibtex(obj))
  }

  if (what == "references") {
    if (is.null(obj$references)) {
      return(NULL)
    }

    ref <- lapply(obj$references, cff_to_bibtex)
    return(do.call(c, ref))
  }

  pref <- cff_to_bibtex(obj)

  if (!is.null(obj$references)) {
    ref <- lapply(obj$references, cff_to_bibtex)
    ref <- do.call(c, ref)
    return(c(pref, ref))
  }

  return(pref)
}
