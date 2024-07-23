#' Create [`cff`] objects from direct inputs
#'
#' A class and utility methods for reading, creating and holding CFF
#' information. See [cff_class] to learn more about `cff` objects.
#'
#' @rdname cff
#' @name cff
#' @return
#'
#' A [`cff`] object. Under the hood, a `cff` object is a regular [`list`]
#' object with a special [`print`][print.cff()] method.
#'
#' @family core
#'
#' @param path `r lifecycle::badge("deprecated")` `path` is no longer supported,
#'   use [cff_read_cff_citation()] instead.
#' @param ... Named arguments to be used for creating a `cff` object. If no
#'   arguments are supplied (the default behavior), a minimal valid `cff`
#'   object is created.
#'
#' @details
#'
#' `cff()` would convert `_` in the name of the argument to `-`, e.g.
#' `cff_version = "1.2.0'` would be converted to `cff-version = "1.2.0'`.
#'
#' Valid parameters are those specified on [cff_schema_keys()]:
#'
#'
#' ```{r, echo=FALSE, results='asis'}
#' p <- paste0('  - `', cffr::cff_schema_keys(), '`', collapse = "\n")
#'
#' cat(p)
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
    src <- detect_x_source(path)
    if (src == "cff_citation") {
      lifecycle::deprecate_warn("1.0.0", "cff(path)", "cff_read_cff_citation()")
      return(cff_read_cff_citation(path))
    } else {
      lifecycle::deprecate_warn("1.0.0", "cff(path)",
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

  cffobj <- validate_extra_keys(cffobj)
  cffobj <- fuzzy_keys(cffobj)

  if (any(duplicated(names(cffobj)))) {
    cli::cli_alert_warning("Removing duplicated keys.")
    cffobj <- cffobj[!duplicated(names(cffobj))]
  }

  cffobj <- as_cff(cffobj)

  return(cffobj)
}
