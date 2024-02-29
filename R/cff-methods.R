#' Print Values
#'
#' @noRd
#' @export
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}

#' Combine Values into a Vector or List
#'
#' @source
#' Based on `?c.person` \CRANpkg{utils}.
#'
#' <https://github.com/wch/r-source/blob/trunk/src/library/utils/R/citation.R>
#'
#' @noRd
#' @export
c.cff <- function(..., recursive = FALSE) {
  args <- list(...)
  args <- lapply(args, unclass)
  rval <- do.call("c", args)
  class(rval) <- "cff"
  rval
}


#' Coerce to a Data Frame
#'
#' @noRd
#' @export
as.data.frame.cff <- function(x, row.names = NULL, optional = FALSE, ...) {
  # If the cff is unnamed is a list of persons/references
  if (is.null(names(x))) {
    the_df <- cff_list_to_df(x)
  } else {
    the_df <- cff_to_df(x)
  }

  the_df <- as.data.frame(the_df,
    row.names = row.names, optional = optional,
    ...
  )

  return(the_df)
}

#' @rdname cff_create_cff_person
#' @name as.person.cff
#' @order 2
#'
#' @description
#' Additionally, it is also provided a method for [as.person()], that can
#' convert [`cff`][cff-class] objects to `person` objects as
#' provided by [utils::person()].
#'
#' This method only works with CFF persons, not with full `cff` objects.
#'
#' @family s3method
#' @export
#' @seealso [utils::person()]
#'
#' @param x `cff` object representing a person or entity.
#'
#' @return
#'
#' `as.person.cff()` returns a `person` object.
as.person.cff <- function(x) {
  # If single enclose on a list
  is_single <- any(grepl("^name$|^given-names|^family-names", names(x)))

  if (is_single) x <- list(x)


  pers <- lapply(x, make_r_person)

  # If not all extracted, malformed, return null
  if (!all(lengths(pers) > 0)) {
    return(person())
  }
  do.call(c, pers)
}

#' Head
#'
#' @noRd
#' @export
head.cff <- function(x, n = 6L, ...) {
  as.cff(NextMethod())
}

#' Tail
#'
#' @noRd
#' @export
tail.cff <- function(x, n = 6L, ...) {
  as.cff(NextMethod())
}


#' @rdname as_bibentry
#' @name toBibtex.cff
#' @order 2
#'
#' @description
#' Additionally, it is also provided a method for [toBibtex()], that can
#' convert [`cff`][cff-class] objects to `Bibtex` objects as
#' provided by [utils::toBibtex()]. These objects are character vectors with
#' BibTeX markup.
#'
#' @family s3method
#' @export
#' @seealso [utils::toBibtex()]
#'
#' @param object `cff` object.
#' @param ... Arguments passed to [utils::toBibtex()].
#'
#' @return
#'
#' `toBibtex.cff()` returns a `Bibtex` object that can be printed as BibTeX
#' markup.
toBibtex.cff <- function(object, ...,
                         what = c("preferred", "references", "all")) {
  # If a single reference...
  if ("cff-version" %in% names(object)) {
    # If full cff
    biblist_cff <- as_bibentry(x = object, what = what)
  } else {
    # Need to enlist if single
    if ("type" %in% names(object)) {
      object <- list(object)
      class(object) <- c("cff", "list")
    }

    bib_list <- lapply(object, cff_bibtex_parser)
    biblist_cff <- do.call(c, bib_list)
  }
  toBibtex(biblist_cff, ...)
}
