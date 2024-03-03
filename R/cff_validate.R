#' Validate a `CITATION.cff` file or a [`cff`] object
#'
#' @description
#' Validate a `CITATION.cff` file or a [`cff`] object created with
#' [cff_create()] using the corresponding validation
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("\n", "[schema.json]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema.json)."))
#'
#'
#' ```
#' @export
#'
#' @family core
#'
#' @seealso
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("[Guide to Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' @return A message indicating the result of the validation and an invisible
#'   value `TRUE/FALSE`. On error, the results would have an attribute
#'   `"errors"` containing the error summary (see **Examples** and [attr()]).
#'
#' @param x This is expected to be either a `cff` object created
#'   with [cff_create()] or the path to a `CITATION.cff` file to be validated.
#' @inheritParams cff_write
#'
#' @examples
#' \donttest{
#' # Full .cff example
#' cff_validate(system.file("examples/CITATION_complete.cff", package = "cffr"))
#'
#' # Validate a cffr object
#' cffr <- cff_create("jsonlite")
#' class(cffr)
#' cff_validate(cffr)
#' }
#'
#' # .cff with errors
#' err_f <- system.file("examples/CITATION_error.cff", package = "cffr")
#' # Can manipulate the errors as data frame
#' res <- try(cff_validate(err_f))
#'
#' isTRUE(res)
#' isFALSE(res)
#'
#' attr(res, "errors")
#'
#' # If a CITATION file (note that is not .cff) it throws an error
#' try(cff_validate(system.file("CITATION", package = "cffr")))
cff_validate <- function(x = "CITATION.cff", verbose = TRUE) {
  # If is a cff create the object
  if (is_cff(x)) {
    tmpfile <- tempfile(fileext = ".cff")
    suppressMessages(yaml::write_yaml(x, tmpfile))
    path <- tmpfile
    is_tmpfile <- TRUE
  } else {
    path <- x
    is_tmpfile <- FALSE
  }

  # Check
  stopifnotexists(path)
  stopifnotcff(path)


  # Read file
  citfile <- yaml::read_yaml(path)

  # Clean up
  if (is_tmpfile) file.remove(path)

  # Convert all elements to character
  # This prevent errors with jsonvalidate
  citfile <- rapply(citfile, function(x) as.character(x), how = "replace")

  # Convert to json
  cit_temp <- jsonlite::toJSON(citfile, pretty = TRUE, auto_unbox = TRUE)

  # Use local copy of the validator schema
  schema_local <- system.file("schema/schema.json", package = "cffr")


  # Validate
  result <- validate_schema(cit_temp, schema_local)

  if (result == FALSE) {
    get_errors <- attr(result, "errors")
    get_errors$field <- gsub("^data", "cff", get_errors$field)

    if (verbose) {
      cli::cat_rule("Validating cff", col = "cyan", line = 2)
      ll <- paste0("* {.dt {.strong ", get_errors$field, "}}{.dl ",
        get_errors$message, "}\n",
        collapse = ""
      )
      if (is_tmpfile) {
        cli::cli_alert_danger(
          paste0(
            "Oops! This {.cls cff} has the following errors:\n",
            ll
          )
        )
      } else {
        cli::cli_alert_danger(
          paste0(
            "Oops! {.file {x}} has the following errors:\n",
            ll
          )
        )
      }
    }
    # Prepare output
    r <- FALSE
    attr(r, "errors") <- get_errors
    return(invisible(r))
  } else {
    if (verbose) {
      cli::cat_rule("Validating cff", col = "cyan", line = 2)
      if (is_tmpfile) {
        cli::cli_alert_success("Congratulations! This {.cls cff} is valid")
      } else {
        cli::cli_alert_success("Congratulations! {.file {x}} is valid")
      }
    }
    return(invisible(TRUE))
  }
}

# Validate schema
#' @noRd
validate_schema <- function(cit_temp, schema_temp) {
  x <- suppressMessages(
    jsonvalidate::json_validate(cit_temp,
      schema_temp,
      verbose = TRUE
    )
  )

  x
}
