#' Validate a `CITATION.cff` file
#'
#' @description
#' Validate a `CITATION.cff` file using the corresponding
#' [schema.json](https://github.com/citation-file-format/citation-file-format/blob/main/schema.json)
#'
#' @export
#'
#' @return A message indicating the result of the validation.
#'
#' @param path The path to the `CITATION.cff` file to validate
#'
#' @examples
#' # Full .cff example
#' cff_validate(system.file("examples/CITATION_full.cff", package = "cffr"))
#'
#' # .cff with errors
#' cff_validate(system.file("examples/CITATION_error.cff", package = "cffr"))
#' \dontrun{
#' # If a CITATION file (note that is not .cff) it throws an error
#' cff_validate(system.file("CITATION", package = "cffr"))
#' }
cff_validate <- function(path = "./CITATION.cff") {
  if (!file.exists(path)) {
    stop("File ", path, " doesn't exists",
      call. = FALSE
    )
  }

  if (tools::file_ext(path) != "cff") {
    stop(path, " is not a .cff file",
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
  schema_temp <- file.path(tempdir(), "schema.json")

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
  message("\ncff_validate results-----")
  if (result == FALSE) {
    message(
      crayon::red("Oops! This CITATION.cff file has the following errors:\n\n")
    )
    print(attributes(result)$errors)
    return(invisible(FALSE))
  } else {
    message(crayon::green("Congratulations! This CITATION.cff file is valid"))
    return(invisible(TRUE))
  }
}
