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
#' @family core functions
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
#'   value `TRUE/FALSE`.
#'
#' @param x This is expected to be either a [`cff`] object created
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
#' \dontrun{
#' # .cff with errors
#' cff_validate(system.file("examples/CITATION_error.cff", package = "cffr"))
#' # If a CITATION file (note that is not .cff) it throws an error
#' cff_validate(system.file("CITATION", package = "cffr"))
#' }
cff_validate <- function(x = "CITATION.cff", verbose = TRUE) {
  message_obj <- ifelse(is.cff(x),
    "cff object",
    ".cff file"
  )

  # If is a cff create the object
  if (is.cff(x)) {
    tmpfile <- tempfile(fileext = ".cff")
    suppressMessages(yaml::write_yaml(x, tmpfile))
    path <- tmpfile
    is_tmpfile <- TRUE
  } else {
    path <- x
    is_tmpfile <- FALSE
  }


  stopifnotexists(path)

  # Check
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

  if (verbose) message("\ncff_validate results-----")
  if (result == FALSE) {
    if (verbose) {
      message(
        cli::col_red(
          "Oops! This ", message_obj,
          " has the following errors:\n\n"
        )
      )

      print(attributes(result)$errors)
    }
    return(invisible(FALSE))
  } else {
    if (verbose) {
      message(cli::col_green(
        "Congratulations! This ",
        message_obj,
        " is valid"
      ))
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
