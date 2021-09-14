#' Write a `CITATION.cff` file
#'
#' @description
#'
#' **This is the core function of the package and likely to be the only one
#' you would need when developing a package**.
#'
#' This function writes out a `CITATION.cff` file for a given package. This
#' function is basically a wrapper around [cff_create()] to both create the
#' [`cff`] object and writes it out to a YAML-formatted file in one command.
#'
#' @family core functions
#'
#' @param x The source that would be used for generating
#'   the `CITATION.cff` file. It could be:
#'   * A [`cff`] object,
#'   * The path to package root (`"."`),
#'   * The name of an installed package (`"jsonlite"`), or
#'   * Path to a DESCRIPTION file (`"*/DESCRIPTION*"`).
#'
#' @param outfile The name and path of the `CITATION.cff` to be created.
#'
#' @param keys List of additional keys to add to the [`cff`] object. See
#'  [cff_create()] for details and examples.
#'
#' @param validate Logical `TRUE/FALSE`. Should the new file be validated using
#'   [cff_validate()]?
#'
#' @export
#'
#' @inheritParams cff_create
#'
#' @return A `CITATION.cff` file and an (invisible) [`cff`] object.
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
#' When creating and writing a `CITATION.cff` for the first time, the function
#' adds "CITATION.cff" to ".Rbuildignore".
cff_write <- function(x = ".",
                      outfile = "CITATION.cff",
                      keys = NULL,
                      cff_version = "1.2.0",
                      validate = TRUE) {
  citat <- cff_create(x,
    keys = keys,
    cff_version = cff_version
  )


  # Fix string if it is not cff
  if (!is.substring(outfile, ".cff$")) outfile <- paste0(outfile, ".cff")


  # Write CITATION
  yaml::write_yaml(citat, outfile)

  addcomment <- readLines(outfile)
  addcomment <- c(
    "# -----------------------------------------------------------",
    paste0(
      "# CITATION file created with {cffr} R package, v",
      packageDescription("cffr")$Version
    ),
    paste(
      "# See also:",
      strsplit(packageDescription("cffr")$URL, ",")[[1]][1]
    ),
    "# -----------------------------------------------------------",
    " ",
    addcomment
  )

  writeLines(addcomment, outfile)
  message(crayon::green(outfile, "generated"))

  # Add CITATION.cff to .Rbuildignore
  if (!is.cff(x) && x == "." && file.exists(".Rbuildignore")) {
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
