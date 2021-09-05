#' `cffr` objects
#'
#' A class and utility methods for holding CFF information.
#'
#' @rdname cffr
#' @return A `cffr` list object.
#'
#' @family core functions
#'
#' @export
#'
#' @param x a character string for the [as.cffr] default method
as.cffr <- function(x) {
  if (inherits(x, "cffr")) {
    return(x)
  }

  x <- unclass(as.list(x))
  class(x) <- "cffr"
  x
}


# Print method

#' @export
print.cffr <- function(x, ...) {
  cat(yaml::as.yaml(x))
}
