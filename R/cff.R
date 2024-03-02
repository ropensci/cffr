#' Read and manipulate `cff` objects
#'
#' A class and utility methods for reading, creating and holding CFF
#' information. See [`cff-class`] to learn more about `cff` objects.
#'
#' @rdname cff
#' @name cff
#' @aliases cff_modify
#' @return
#'
#' A `cff` object. Under the hood, a `cff` object is a regular `list` object
#' with a special [print()] method.
#'
#' @family core
#'
#' @param path `r lifecycle::badge("deprecated")` `path` is no longer supported,
#'   use [cff_read_cff_citation()] instead.
#' @param ... Named arguments to be used for creating a `cff` object. See
#' **Details**.
#'
#' @details
#'
#' If no additional `...` parameters are supplied (the default behavior),
#' a minimal valid `cff` object is created. `cff` would convert `_` in the name
#' of the argument to `-` (e.g, `cff_version = "1.2.0'` would be converted to
#' `cff-version = "1.2.0'`)
#'
#' Valid parameters are those specified on [cff_schema_keys()]:
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
#' # Blank cff
#' cff()
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
#' }
#'
#' # Modify with cff_create
#' new <- cff_create(test, keys = list(
#'   "cff_version" = "1.2.0",
#'   message = "A blank file"
#' ))
#' new
#'
#' # Would pass
#' cff_validate(new)
#'
#' @export
cff <- function(path, ...) {
  if (!missing(path)) {
    if (is_cff_file(path)) {
      lifecycle::deprecate_soft(
        "1.0.0", "cff(path)", "cff_read_cff_citation()"
      )
      return(cff_read_cff_citation(path))
    } else {
      lifecycle::deprecate_soft(
        "1.0.0", "cff(path)",
        details = "Argument ignored."
      )
    }
  }

  cffobj <- list(...)
  if (length(cffobj) == 0) {
    # If nothing is provided use a minimal cff
    path <- system.file("examples/CITATION_skeleton.cff",
      package = "cffr"
    )

    return(cff_read_cff_citation(path))
  }

  # Check names

  has_names <- names(cffobj)
  if (is.null(has_names)) {
    cli::cli_abort(
      "Elements in {.arg ...} should be named."
    )
  }

  if (any(has_names == "")) {
    index <- as.character(which(has_names %in% ""))

    cli::cli_alert_warning(
      "Found {length(index)} not-named argument{?s} in position{?s} {index}."
    )
    cli::cli_alert_info("Removing unnamed arguments")
    cffobj <- cffobj[has_names != ""]
  }



  cffobj <- fuzzy_keys(cffobj)

  if (any(duplicated(names(cffobj)))) {
    cli::cli_alert_warning("Removing duplicated keys.")
    cffobj <- cffobj[!duplicated(names(cffobj))]
  }

  cffobj <- as_cff(cffobj)

  return(cffobj)
}
