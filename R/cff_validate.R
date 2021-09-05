#' Validate a CITATION.cff file or a `cffr` object
#'
#' @description
#' Validate a CITATION.cff file or a `cffr` object created with
#' [cff_create()] using the corresponding validation
#' [schema.json](https://github.com/citation-file-format/citation-file-format/blob/main/schema.json).
#'
#' @export
#'
#' @family core functions
#'
#' @seealso [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).
#'
#' @return A message indicating the result of the validation and an invisible
#'   value `TRUE/FALSE`.
#'
#' @param path This is expected to be either a `cffr` object created
#'   with [cff_create()] or the path to a *.cff file to be validated.
#'
#' @examples
#' # Full .cff example
#' cff_validate(system.file("examples/CITATION_full.cff", package = "cffr"))
#'
#' # Validate a cffr object
#' cffr <- cff_create("jsonlite")
#' class(cffr)
#' cff_validate(cffr)
#'
#' # .cff with errors
#' cff_validate(system.file("examples/CITATION_error.cff", package = "cffr"))
#' \dontrun{
#' # If a CITATION file (note that is not .cff) it throws an error
#' cff_validate(system.file("CITATION", package = "cffr"))
#' }
cff_validate <- function(path = "./CITATION.cff") {
  is_object <- inherits(path, "cffr")

  # If is a cffr create the object
  if (is_object) {
    tmpfile <- tempfile(fileext = ".cff")
    suppressMessages(yaml::write_yaml(path, tmpfile))
    path <- tmpfile
  }


  if (!file.exists(path)) {
    stop("File ", path, " doesn't exists",
      call. = FALSE
    )
  }

  if (tools::file_ext(path) != "cff") {
    stop(path, " is not a .cff file or a 'cffr' object",
      call. = FALSE
    )
  }


  # Read file
  citfile <- yaml::read_yaml(path)

  # Convert all elements to character
  # This prevent errors with jsonvalidate
  citfile <- rapply(citfile, function(x) as.character(x), how = "replace")

  # Convert to json on a temporary file
  cit_temp <- tempfile(fileext = ".json")
  jsonlite::write_json(citfile, cit_temp, pretty = TRUE)

  # Brackets management. jsonlite adds unwanted extra brackets----
  citfile_clean <- readLines(cit_temp)

  # Search brackets to keep
  # Lists
  keep_lines <- grep('", "', citfile_clean)
  # Keep ending and starting
  keep_lines <- c(keep_lines, grep("\\[$", citfile_clean))
  keep_lines <- c(keep_lines, grep(" \\],", citfile_clean))
  keep_lines <- c(keep_lines, grep(" \\]$", citfile_clean))
  keep_lines <- sort(unique(keep_lines))

  # Split citation
  if (all(keep_lines > 0)) {
    keep_string <- citfile_clean[keep_lines]
    citfile_clean[keep_lines] <- ""
  }

  # Remove unneded brackets
  citfile_clean <- gsub('["', '"', citfile_clean, fixed = TRUE)
  citfile_clean <- gsub('"]', '"', citfile_clean, fixed = TRUE)

  # Add "good" brackets back
  if (all(keep_lines > 0)) {
    citfile_clean[keep_lines] <- keep_string
  }

  # Rewrite json
  writeLines(citfile_clean, cit_temp)

  # End Brackets management

  # Download latest scheme
  schema_temp <- file.path(tempdir(), "cff_schema.json")

  if (isFALSE(file.exists(schema_temp))) {
    download.file("https://raw.githubusercontent.com/citation-file-format/citation-file-format/main/schema.json",
      schema_temp,
      mode = "wb",
      quiet = TRUE
    )
  }
  # Validate
  result <- jsonvalidate::json_validate(cit_temp,
    schema_temp,
    verbose = TRUE
  )

  # Results
  message_obj <- ifelse(is_object,
    "cffr object",
    ".cff file"
  )

  message("\ncff_validate results-----")
  if (result == FALSE) {
    message(
      crayon::red(
        "Oops! This ", message_obj,
        "has the following errors:\n\n"
      )
    )
    print(attributes(result)$errors)
    return(invisible(FALSE))
  } else {
    message(crayon::green(
      "Congratulations! This",
      message_obj,
      "is valid"
    ))
    return(invisible(TRUE))
  }
}
