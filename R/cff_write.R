#' Write a CITATION.cff file
#'
#' @description
#' Write out a CITATION.cff file for a given package. This function is
#' basically a wrapper around [cff_create()] to both create the `cffr` object
#' and write it out to a YAML-formatted file in one command.
#'
#' @family core functions
#'
#' @export
#'
#' @param outfile The name and path of the CITATION.cff to be created.
#'
#' @param keys List of additional keys to add to the `ccfr` object. See
#'  [cff_create()] for details and examples.
#'
#' @param validate Logical `TRUE/FALSE`. Should the new file be validated using
#'   [cff_validate()]?
#'
#'
#' @inheritParams cff_create
#'
#' @return A CITATION.cff file and an (invisible) `cffr` object.
#'
#' @seealso [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).
#'
#' @examples
#'
#' cff_obj <- cff_write("jsonlite", outfile = tempfile(fileext = ".cff"))
#'
#' cff_obj
#' @details
#'
#' When creating and writing a CITATION.cff for the first time, the function
#' adds "CITATION.cff" to .Rbuildignore
cff_write <- function(x = ".",
                      outfile = "CITATION.cff",
                      keys = NULL,
                      cff_version = "1.2.0",
                      validate = TRUE) {
  citat <- cff_create(x,
    keys = keys,
    cff_version = cff_version
  )


  # Write CITATION
  yaml::write_yaml(citat, outfile)

  message(crayon::green(outfile, "generated"))

  # Add CITATION.cff to .Rbuildignore
  if (x == "." && file.exists(".Rbuildignore")) {
    # nocov start
    ignore <- readLines(".Rbuildignore")

    # If not already
    if (!("^CITATION\\.cff$" %in% ignore)) {
      ignore <- c(ignore, "^CITATION\\.cff$")
      ignore <- unique(ignore)

      message(crayon::blue("Adding ", outfile, "to .Rbuildignore"))
      writeLines(ignore, ".Rbuildignore")
    }
    # nocov end
  }

  if (validate) {
    cff_validate(outfile)
  }

  return(invisible(citat))
}
