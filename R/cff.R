#' `cff` objects
#'
#' A class and utility methods for holding CFF information.
#'
#' @name cff
#' @return A `cff` list object.
#'
#' @family core functions
#'
#' @export
#'
#' @param x a character string for the [`as.cff`] default method
as.cff <- function(x) {
  if (inherits(x, "cff")) {
    return(x)
  }

  class(x) <- "cff"
  x
}


# Print method

#' @export
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}
