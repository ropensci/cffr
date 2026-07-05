#' Create [`cff`] objects from direct inputs
#'
#' A class and utility methods for reading, creating and storing CFF
#' information. See [cff_class] to learn more about `cff` objects.
#'
#' @param path `r lifecycle::badge("deprecated")` `path` is no longer supported,
#'   use [cff_read_cff_citation()] instead.
#' @param ... Named arguments to be used for creating a [`cff`] object. If no
#'   arguments are supplied (the default behavior), a minimal valid `cff`
#'   object is created.
#'
#' @return
#' A [`cff`] object. Under the hood, a `cff` object is a regular [base::list()]
#' object with a special [`print`][print.cff()] method.
#'
#' @details
#' `cff()` converts `_` in the argument name to `-`. For example,
#' `cff_version = "1.2.0"` is converted to `cff-version = "1.2.0"`.
#'
#' Valid arguments are those specified on [cff_schema_keys()]:
#'
#' ```{r, echo=FALSE, results='asis'}
#' p <- paste0('  - `', cffr::cff_schema_keys(), '`', collapse = "\n")
#'
#' cat(p)
#'
#' ```
#'
#' @family core
#' @rdname cff
#' @name cff
#' @export
#' @encoding UTF-8
#' @examples
#' # Blank `cff` object.
#' cff()
#'
#' # Use custom parameters.
#' test <- cff(
#'   title = "Manipulating files",
#'   keywords = c("A", "new", "list", "of", "keywords"),
#'   authors = as_cff_person("New author")
#' )
#' test
#' \donttest{
#' # This would fail.
#' cff_validate(test)
#' }
#'
#' # Modify with cff_create().
#' new <- cff_create(test, keys = list(
#'   "cff_version" = "1.2.0",
#'   message = "A blank file"
#' ))
#' new
#'
#' # This would pass.
#' cff_validate(new)
cff <- function(path, ...) {
  if (!missing(path)) {
    src <- detect_x_source(path)
    if (src == "cff_citation") {
      lifecycle::deprecate_warn("1.0.0", "cff(path)", "cff_read_cff_citation()")
      return(cff_read_cff_citation(path))
    } else {
      lifecycle::deprecate_warn(
        "1.0.0",
        "cff(path)",
        details = "Argument ignored."
      )
    }
  }

  cffobj <- list(...)
  if (length(cffobj) == 0) {
    # Use a minimal `cff` object when nothing is provided.
    path <- system.file("examples/CITATION_skeleton.cff", package = "cffr")

    return(cff_read_cff_citation(path))
  }

  # Check names.

  cffobj <- validate_extra_keys(cffobj)
  cffobj <- fuzzy_keys(cffobj)

  if (anyDuplicated(names(cffobj)) > 0) {
    cli::cli_alert_warning("Removing duplicate keys.")
    cffobj <- cffobj[!duplicated(names(cffobj))]
  }

  cffobj <- as_cff(cffobj)

  cffobj
}
