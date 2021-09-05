#' `cff` objects
#'
#' A class and utility methods for holding CFF information.
#'
#' @name cff
#' @return A `cff` list object.
#'
#' @family **cffr** core functions
#'
#' @export
#'
#' @param x a character string for the [as.cffr] default method
as.cff <- function(x) {
  if (inherits(x, "cff")) {
    return(x)
  }

  x <- unclass(as.list(x))
  x <- unique(x)
  
  class(x) <- "cff"
  x
}


# Print method

#' @export
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}
