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
c.cff <-
  function(..., recursive = FALSE) {
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
