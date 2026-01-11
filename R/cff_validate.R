#' Validate a `CITATION.cff` file or a [`cff`] object
#'
#' @description
#' Validate a `CITATION.cff` file or a [`cff`] object using the corresponding
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [validation schema]",
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
#' @return
#'
#' A message indicating the result of the validation and an invisible value
#' `TRUE/FALSE`. On error, the results would have an attribute `"errors"`
#' containing the error summary (see **Examples** and [attr()]).
#'
#' @param x This is expected to be either a full `cff` object created
#'   with [cff_create()] or the path to a `CITATION.cff` file to be validated.
#'   In the case of a `*cff` file it would read with [cff_read_cff_citation()].
#' @inheritParams cff_write
#'
#' @seealso
#' [jsonvalidate::json_validate()], that is the function that performs the
#' validation.
#'
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
  if (!is_cff(x)) {
    # Check
    abort_if_not_cff(x)
    is_a <- paste0("{.file ", x, "}")
    # nolint end
    x <- cff_read_cff_citation(x)
  } else {
    is_a <- "This {.cls cff}"
  }

  # Convert to list
  citfile <- as.list(x)

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
      ll <- paste0(
        "* {.dt {.strong ",
        get_errors$field,
        "}}{.dl ",
        get_errors$message,
        "}\n",
        collapse = ""
      )
      cli::cli_alert_danger(
        paste0("Oops! ", is_a, " has the following errors:\n", ll)
      )
    }

    # Prepare output
    attr(result, "errors") <- get_errors
    return(invisible(result))
  }

  if (verbose) {
    cli::cat_rule("Validating cff", col = "cyan", line = 2)
    cli::cli_alert_success(
      paste0("Congratulations! ", is_a, " is valid")
    )
  }
  invisible(result)
}

# Validate schema
#' @noRd
validate_schema <- function(cit_temp, schema_temp) {
  x <- suppressMessages(
    jsonvalidate::json_validate(cit_temp, schema_temp, verbose = TRUE)
  )

  x
}
