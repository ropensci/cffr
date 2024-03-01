#' Coerce lists, `person` and `bibentry` objects to [`cff`][cff-class]
#'
#' @description
#' `as_cff()` turns an existing list-like **R** object into a so-called
#' [`cff`][cff-class], a list with class `cff`.
#'
#' `as_cff` is an S3 generic, with methods for:
#' - `person` objects as produced by `utils::person()`.
#' - `bibentry` objects as produced by `utils::bibentry()`.
#' -  Default: Other inputs are first coerced with [as.list()].
#'
#' @param x A `person`, `bibentry` or other object that could be coerced to a
#'   list.
#' @param ... Additional arguments to be passed on to other methods.
#'
#' @rdname as_cff
#' @export
as_cff <- function(x, ...) {
  UseMethod("as_cff")
}

#' @rdname as_cff
#' @export
as_cff.default <- function(x, ...) {
  as_cff(as.list(x), ...)
}


#' @rdname as_cff
#' @export
as_cff.list <- function(x, ...) {
  # Clean up empty values on top
  clean_up <- vapply(x, is.null, FUN.VALUE = logical(1))
  x_clean <- x[!clean_up]
  new_cff(x_clean)
}

#' @rdname as_cff
#' @export
as_cff.person <- function(x, ...) {
  as_cff(as_cff_person(x), ...)
}


#' @rdname as_cff
#' @export
as_cff.bibentry <- function(x, ...) {
  as_cff(as_cff_bibentry(x), ...)
}
