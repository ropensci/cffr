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
#' ```
#'
#' @param x A full `cff` object created with [cff_create()] or the path to a
#'   `CITATION.cff` file to be validated. A `*.cff` file is read with
#'   [cff_read_cff_citation()].
#' @inheritParams cff_write
#'
#' @return
#' Invisibly returns a logical value indicating the validation result. On
#' error, the result has an `"errors"` attribute with the error summary. If
#' `verbose` is `TRUE`, the function also displays the result. See **Examples**
#' and [base::attr()].
#'
#' @seealso
#' [jsonvalidate::json_validate()], which is the function that performs the
#' validation.
#'
#' ```{r child = "man/chunks/schema-guide.Rmd"}
#' ```
#'
#' @family core
#' @export
#' @encoding UTF-8
#' @examples
#' \donttest{
#' # Full `.cff` example.
#' cff_validate(system.file("examples/CITATION_complete.cff", package = "cffr"))
#'
#' # Validate a `cff` object.
#' cffr <- cff_create("jsonlite")
#' class(cffr)
#' cff_validate(cffr)
#' }
#'
#' # `.cff` with errors.
#' err_f <- system.file("examples/CITATION_error.cff", package = "cffr")
#' # You can manipulate the errors as a data frame.
#' res <- try(cff_validate(err_f))
#'
#' isTRUE(res)
#' isFALSE(res)
#'
#' # Detailed results.
#' df_errors <- attr(res, "errors")
#'
#' df_errors[, c("field", "message")]
#'
#' # An R citation file is not a `.cff` file, so it throws an error.
#' try(cff_validate(system.file("CITATION", package = "cffr")))
cff_validate <- function(x = "CITATION.cff", verbose = TRUE) {
  # Read the file if the input is not a `cff` object.
  if (!is_cff(x)) {
    # Check the source.
    abort_if_not_cff(x)
    is_a <- paste0("{.file ", x, "}")
    # nolint end
    x <- cff_read_cff_citation(x)
  } else {
    is_a <- "This {.cls cff} object"
  }

  # Convert to a list.
  citfile <- as.list(x)

  # This prevents errors with `jsonvalidate`.
  citfile <- rapply(citfile, function(x) as.character(x), how = "replace")

  # Convert to JSON.
  cit_temp <- jsonlite::toJSON(citfile, pretty = TRUE, auto_unbox = TRUE)

  # Use the local copy of the validator schema.
  schema_local <- system.file("schema/schema.json", package = "cffr")

  # Validate.
  result <- validate_schema(cit_temp, schema_local)

  if (!result) {
    get_errors <- attr(result, "errors")
    field <- get_errors$instancePath
    field[!nzchar(field)] <- "/"
    field <- paste0("cff", field)
    get_errors$field <- field
    msg <- get_errors$message
    # Escape braces.
    msg <- gsub("{", "{{", msg, fixed = TRUE)
    msg <- gsub("}", "}}", msg, fixed = TRUE)

    if (verbose) {
      cli::cat_rule("Validating CFF", col = "cyan", line = 2)
      ll <- paste0(
        "* {.dt {.strong ",
        get_errors$field,
        "}}{.dd ",
        msg,
        "}\n",
        collapse = ""
      )
      cli::cli_alert_danger(paste0(
        "Validation failed. ",
        is_a,
        " has the following errors:\n",
        ll
      ))
    }

    # Prepare output.
    attr(result, "errors") <- get_errors[, unique(c(
      "field",
      "message",
      names(get_errors)
    ))]
    return(invisible(result))
  }

  if (verbose) {
    cli::cat_rule("Validating CFF", col = "cyan", line = 2)
    cli::cli_alert_success(paste0(is_a, " is valid."))
  }
  invisible(result)
}

# Validate schema.
#' @noRd
validate_schema <- function(cit_temp, schema_temp) {
  x <- suppressMessages(jsonvalidate::json_validate(
    cit_temp,
    schema_temp,
    verbose = TRUE,
    engine = "ajv"
  ))

  x
}
