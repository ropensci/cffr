#' Read and manipulate `cff` objects
#'
#' A class and utility methods for reading, creating and holding CFF
#' information. See [`cff-class`] to learn more about `cff` objects.
#'
#' @rdname cff
#' @name cff
#' @aliases cff_modify
#' @return
#' A `cff` object. Under the hood, a `cff` object is a regular `list` object
#' with a special [print()] method.
#'
#' @family core
#'
#' @param path The path to a `CITATION.cff` file.
#' @param ... Named arguments to be used for creating a `cff` object. See
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
#'   authors = as_cff_person("New author")
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
#' @export
cff <- function(path, ...) {
  if (!missing(path) && is_cff(path)) {
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

  cffobj <- as_cff(cffobj)

  return(cffobj)
}
