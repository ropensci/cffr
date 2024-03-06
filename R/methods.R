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


# nolint start
#' Coerce to a Data Frame
#'
#' @noRd
#' @export
as.data.frame.cff <- function(x, row.names = NULL, optional = FALSE, ...) {
  # List of references
  if (inherits(x, "cff_ref_list")) {
    x_n <- list("references" = x)
    the_df <- cff_to_df(x_n)
  } else if (inherits(x, "cff_pers_list")) {
    n_l <- seq_len(length(x))
    end_df <- lapply(n_l, function(i) {
      df <- as.data.frame(x[[i]])
      nm <- names(df)
      names(df) <- paste0("person", ".", sprintf("%02d", i - 1), ".", nm)
      return(df)
    })

    the_df <- do.call(cbind, end_df)
  } else {
    the_df <- cff_to_df(x)
  }

  the_df <- as.data.frame(the_df,
    row.names = row.names, optional = optional,
    ...
  )

  return(the_df)
}

# nolint end

#' Head
#'
#' @noRd
#' @export
head.cff <- function(x, n = 6L, ...) {
  as_cff(NextMethod())
}

#' Tail
#'
#' @noRd
#' @export
tail.cff <- function(x, n = 6L, ...) {
  as_cff(NextMethod())
}


#' List
#'
#' @noRd
#' @export
as.list.cff <- function(x, ...) {
  xl <- rapply(x, function(x) {
    if (is.list(x) || length(x) > 1) {
      return(unclass(x))
    }
    return(unclass(x))
  },
  how = "list"
  )

  as.list(xl)
}





#' @rdname as_bibentry
#' @name toBibtex.cff
#' @order 9
#'
#' @description
#'
#' `toBibtex.cff()` method can convert [`cff`] objects to `Bibtex` objects on
#' the fly, see **Examples**.
#'
#' @family s3method
#' @export
#' @seealso
#'
#' [utils::toBibtex()] to get more information about the `toBibtex.cff()`
#' method.
#'
#' @param object For `toBibtex.cff()` a [`cff`] object.
#' @param ... Arguments passed to [utils::toBibtex()].
#'
#' @return
#'
#' `toBibtex.cff()` returns a `Bibtex` object that can be printed as BibTeX
#' markup.
toBibtex.cff <- function(object, ...,
                         what = c("preferred", "references", "all")) {
  toBibtex(as_bibentry(object, what = what), ...)
}

#' @rdname as_bibentry
#' @order 10
#' @export
toBibtex.cff_pers_list <- function(object, ...) {
  toBibtex(as.person(object), ...)
}

#' @rdname as_bibentry
#' @order 11
#' @export
toBibtex.cff_pers <- function(object, ...) {
  toBibtex(as.person(object), ...)
}

#' @rdname as_cff_person
#' @order 2
#'
#' @description
#'
#' The inverse transformation (`cff_pers / cff_pers_list` to
#' [`person`][utils::as.person()]) object can be done through the
#' `as.person.cff_pers()` / `as.person().cff_pers_list()` methods.
#'
#' The output also can printed on BibTeX markup via the corresponding
#' [`toBibtex()`][toBibtex.cff_pers] methods.
#'
#'
#'
#' @family s3method
#' @export
#'
#' @param x A `cff_pers` or `cff_pers_list` object.
#'
#' @return
#'
#' `as.person.cff_pers()` / `as.person.cff_pers_list()` returns a
#' [`person`][utils::person] object.
#'
as.person.cff_pers <- function(x) {
  # Enlist to dispatch to Next method
  x_l <- list(as.list(x))
  as.person(as_cff(x_l))
}

#' @rdname as_cff_person
#' @order 3
#' @export
as.person.cff_pers_list <- function(x) {
  pers <- lapply(x, make_r_person)

  # If not all extracted, malformed, return null
  if (!all(lengths(pers) > 0)) {
    return(person())
  }
  do.call(c, pers)
}


#  as.person methods not implemented ----

#' @export
#' @noRd
as.person.cff <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cff} method not implemented yet."
  )
}

#' @export
#' @noRd
as.person.cff_ref <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cff_ref} method not implemented yet."
  )
}

#' @export
#' @noRd
as.person.cff_ref_list <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cff_ref_list} method not implemented yet."
  )
}
