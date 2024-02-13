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
#' @family Core functions
#'
#' @param x The source that would be used for generating
#'   the `CITATION.cff` file. It could be:
#'   * A missing value. That would retrieve the DESCRIPTION
#'     file on your in-development package.
#'   * A [`cff`] object,
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
#' @param verbose Logical `TRUE/FALSE`. On `TRUE` the function would display
#'   informative messages.
#'
#' @param authors_roles Roles to be considered as authors of the package when
#'   generating the `CITATION.cff` file. See **Details** on [cff_create()].
#'
#' @export
#'
#' @inheritParams cff_create
#'
#' @return A `CITATION.cff` file and an (invisible) [`cff`] object.
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
#' @examples
#' \donttest{
#' tmpfile <- tempfile(fileext = ".cff")
#' cff_obj <- cff_write("jsonlite", outfile = tmpfile)
#'
#' cff_obj
#'
#' # Force clean-up
#' file.remove(tmpfile)
#' }
#' @details
#'
#' When creating and writing a `CITATION.cff` for the first time, the function
#' adds "CITATION.cff" to ".Rbuildignore".
cff_write <- function(x,
                      outfile = "CITATION.cff",
                      keys = list(),
                      cff_version = "1.2.0",
                      gh_keywords = TRUE,
                      dependencies = TRUE,
                      validate = TRUE,
                      verbose = TRUE,
                      authors_roles = c("aut", "cre")) {
  # On missing use package root
  if (missing(x)) x <- getwd()

  citat <- cff_create(x,
    keys = keys,
    cff_version = cff_version,
    gh_keywords = gh_keywords,
    dependencies = dependencies,
    authors_roles = authors_roles
  )


  # Fix string if it is not cff
  if (!is_substring(outfile, ".cff$")) outfile <- paste0(outfile, ".cff")

  # Check if dir exist and if not create
  outdir <- dirname(outfile)

  if (!dir.exists(outdir)) {
    dir.create(outdir,
      showWarnings = FALSE,
      recursive = TRUE
    )
  }


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
  if (verbose) {
    cli::cli_alert_success("{.file {outfile}} generated")
  }

  # Add CITATION.cff to .Rbuildignore
  if (!is_cff(x) && x == getwd() && file.exists(".Rbuildignore")) {
    ignore <- readLines(".Rbuildignore")

    # If not already
    if (!("^CITATION\\.cff$" %in% ignore)) {
      ignore <- c(ignore, "^CITATION\\.cff$")
      ignore <- unique(ignore)

      if (verbose) {
        cli::cli_alert_info("Adding {.val {outfile}} to {.file .Rbuildignore}")
      }
      writeLines(ignore, ".Rbuildignore")
    }
  }

  if (validate) {
    cff_validate(outfile, verbose)
  }

  return(invisible(citat))
}
