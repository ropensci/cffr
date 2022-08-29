#' Read and manipulate `cff` objects
#'
#' A class and utility methods for reading, creating and holding CFF
#' information.
#'
#' @name cff_read
#' @aliases cff
#' @return
#' A `cff` object. Under the hood, a `cff` object is a regular [`list`] object
#' with a special [print()] method.
#'
#' @family core functions
#'
#' @param path The path to a `CITATION.cff` file.
#' @param ... Named arguments to be used for creating a [`cff`] object. See
#' **Details**.
#'
#' @details
#'
#' This object can be manipulated using [cff_create()].
#'
#' **Note that** this function reads `CITATION.cff` files. If you want to
#' create `cff` objects from DESCRIPTION files use [cff_create()].
#'
#' If no additional `...` parameters are supplied (the default behavior),
#' a minimal valid `cff` object is created. Valid parameters are those
#' specified on [cff_schema_keys()]:
#'
#'
#'
#' ```{r, echo=FALSE}
#'
#'
#' valid_keys <- cff_schema_keys()
#'
#' knitr::kable(valid_keys, col.names = "**valid cff keys**")
#'
#'
#' ```
#' @export
#' @examples
#'
#' # Blank cff
#' cff()
#'
#' # From file
#' cff_read(system.file("examples/CITATION_basic.cff",
#'   package = "cffr"
#' ))
#'
#' # Use custom params
#' test <- cff(
#'   title = "Manipulating files",
#'   keywords = c("A", "new", "list", "of", "keywords"),
#'   authors = list(cff_parse_person("New author"))
#' )
#' test
#' \donttest{
#' # Would fail
#' cff_validate(test)
#'
#'
#' # Modify with cff_create
#' new <- cff_create(test, keys = list(
#'   "cff-version" = "1.2.0",
#'   message = "A blank file"
#' ))
#' new
#'
#' # Would pass
#' cff_validate(new)
#' }
cff_read <- function(path) {
  cffobj <- cff(path = path)

  return(cffobj)
}

#' @rdname cff_read
#' @export
cff <- function(path, ...) {
  if (!missing(path) && is.cff(path)) {
    return(path)
  }

  # Capture args
  cffobj <- list(...)

  if (!missing(path)) {
    stopifnotexists(path)
    stopifnotcff(path)
    cffobj <- yaml::read_yaml(path)
  } else if (length(cffobj) != 0) {
    cffobj <- fuzzy_keys(cffobj)

    cffobj <- cffobj
  } else {
    # If nothing is provided use a minimal cff
    path <- system.file("examples/CITATION_skeleton.cff",
      package = "cffr"
    )
    cffobj <- yaml::read_yaml(path)
  }
  cffobj <- drop_null(cffobj)

  cffobj <- as.cff(cffobj)

  return(cffobj)
}




#' @rdname cff_read
#'
#' @param x a character string for the [`as.cff`] default method
#'
#' @export
#'
#' @examples
#'
#'
#' # Convert a list to "cff" object
#' cffobj <- as.cff(list(
#'   "cff-version" = "1.2.0",
#'   title = "Manipulating files"
#' ))
#'
#' class(cffobj)
#'
#' # Nice display thanks to yaml package
#' cffobj
as.cff <- function(x) {
  if (is.cff(x)) {
    return(x)
  }

  # Clean all strings recursively

  x <- rapply(x, function(x) {
    if (is.list(x) || length(x) > 1) {
      return(x)
    }
    return(clean_str(x))
  },
  how = "list"
  )

  # Remove NULLs
  x <- drop_null(x)

  # Remove duplicated names
  x <- x[!duplicated(names(x))]

  # Now apply cff class to nested lists
  x <- lapply(x, rapply_cff)

  class(x) <- "cff"
  x
}


# Print method

#' @export
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}

# c method
# Based on c.person (utils package)
# https://github.com/wch/r-source/blob/trunk/src/library/utils/R/citation.R

#' @export
c.cff <-
  function(..., recursive = FALSE) {
    args <- list(...)
    args <- lapply(args, unclass)
    rval <- do.call("c", args)
    class(rval) <- "cff"
    rval
  }

# Helper----

#' Recursively clean lists and assign cff classes
#' to all nested lists
#'
#'
#' @noRd
rapply_cff <- function(x) {
  if ("cff" %in% class(x)) {
    return(x)
  }

  if (is.list(x) && length(x) > 0) {
    x <- drop_null(x)
    x <- lapply(x, rapply_cff)
    return(structure(x, class = "cff"))
  } else {
    return(x)
  }
}
