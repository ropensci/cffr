#' `cff` objects
#'
#' A class and utility methods for reading, creating and holding CFF
#' information.
#'
#' @name cff
#' @return A `cff` list object.
#'
#' @family core functions
#'
#' @param path The path to a `CITATION.cff` file.
#' @param ... Named arguments to be used for creating a [`cff`] object.
#'
#' @details
#' If no parameters are supplied (the default behavior), a minimal
#' valid `cff` object is created.
#'
#' This object can be manipulated using [cff_create()].
#'
#' **Note that** this function reads `CITATION.cff` files. If you want to
#' create `cff` objects from DESCRIPTION files use [cff_create()]
#'
#' @export
#' @examples
#'
#' # Blank cff
#' cff()
#'
#' # From file
#' cff(system.file("examples/CITATION_basic.cff",
#'   package = "cffr"
#' ))
#'
#' # Use custom params
#' test <- cff(
#'   message = "A blank file",
#'   keywords = c("A", "new", "list", "of", "keywords"),
#'   authors = list(cff_parse_person("New author"))
#' )
#' test
#'
#' # Would fail
#' cff_validate(test)
#'
#'
#' # Modify with cff_create
#' new <- cff_create(test, keys = list(
#'   "cff-version" = "1.2.0",
#'   title = "Manipulating files"
#' ))
#' new
#'
#' # Would pass
#' cff_validate(new)
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




#' @rdname cff
#'
#' @param x a character string for the [`as.cff`] default method
#'
#' @export
#'
#' @examples
#'
#' as.cff(list(
#'   "cff-version" = "1.2.0",
#'   title = "Manipulating files"
#' ))
as.cff <- function(x) {
  if (is.cff(x)) {
    return(x)
  }

  # Clean all strings recursively

  x <- rapply(x, function(x) {
    if (is.vector(x)) {
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
  x <- lapply(x, rapply.cff)

  class(x) <- "cff"
  x
}


# Print method

#' @export
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}


# Helper----

#' Recursively clean lists and assign cff classes
#' to all nested lists
#'
#' Suggestions? There is a test for this
#'
#' @noRd
rapply.cff <- function(x) {
  if ("cff" %in% class(x)) {
    return(x)
  }

  if (is.list(x)) {
    # First level
    x <- drop_null(x)
    # Second level
    x <- lapply(x, function(y) {
      if (is.list(y)) {
        y <- drop_null(y)

        # Third level
        y <- lapply(y, function(z) {
          if (is.list(z)) {
            z <- drop_null(z)
            # Last level

            z <- lapply(z, function(w) {
              if (is.list(w)) {
                w <- drop_null(w)
                return(structure(w, class = "cff"))
              } else {
                return(w)
              }
            })

            return(structure(z, class = "cff"))
          } else {
            return(z)
          }
        })
        return(structure(y, class = "cff"))
      } else {
        return(y)
      }
    })

    return(structure(x, class = "cff"))
  }
  return(x)
}
