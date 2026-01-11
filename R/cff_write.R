#' Write a `CITATION.cff` file
#'
#' @description
#'
#' **This is the core function of the package and likely to be the only one
#' you would need when developing a package**.
#'
#' This function writes out a `CITATION.cff` file for a given package. This
#' function is basically a wrapper around [cff_create()] to both create the
#' [`cff`] object and write it out to a YAML-formatted file in
#' one command.
#'
#' @family writing
#'
#'
#' @param outfile The name and path of the `CITATION.cff` to be created.
#'
#' @param r_citation Logical `TRUE/FALSE`. On `TRUE` the **R** package citation
#'   (i.e. `inst/CITATION`) would be created or updated.
#'   **No backup copy would be created**, for more control use
#'   [cff_write_citation()].
#'
#' @param verbose Logical `TRUE/FALSE`. On `TRUE` the function would display
#'   informative messages.
#'
#' @param validate validate Logical `TRUE/FALSE`. Should the new file be
#'   validated using `cff_validate()`?
#'
#' @param encoding The name of the encoding to be assumed. Default is `"UTF-8"`,
#'   but it can be any other value as accepted by [iconv()], such as
#'   `"ASCII//TRANSLIT"`.
#'
#' @inheritParams cff_create
#' @inheritParams cff_validate
#'
#' @export
#'
#'
#' @return A `CITATION.cff` file and an (invisible) `cff` object.
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
#' This function unifies the workflow [cff_create()] + [cff_validate()] +
#' write a file.
#'
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
#' For details of `authors_roles` see [cff_create()].
#'
#' When creating and writing a `CITATION.cff` for the first time, the function
#' adds the pattern `"^CITATION\.cff$"` to your `.Rbuildignore` file to avoid
#' `NOTE`s and `WARNING`s in `R CMD CHECK`.
#'
cff_write <- function(
  x,
  outfile = "CITATION.cff",
  keys = list(),
  cff_version = "1.2.0",
  gh_keywords = TRUE,
  r_citation = FALSE,
  dependencies = TRUE,
  validate = TRUE,
  verbose = TRUE,
  authors_roles = c("aut", "cre"),
  encoding = "UTF-8"
) {
  # # On missing use NULL
  if (missing(x)) {
    x <- getwd()
  }

  # Issue 86 Need to remove first "inst/CITATION"
  fpath <- "./inst/CITATION"
  if (r_citation) {
    unlink(fpath)
  }

  citat <- cff_create(
    x,
    keys = keys,
    cff_version = cff_version,
    gh_keywords = gh_keywords,
    dependencies = dependencies,
    authors_roles = authors_roles
  )

  # Fix string if it is not cff
  if (!is_substring(outfile, ".cff$")) {
    outfile <- paste0(outfile, ".cff")
  }

  # Check if dir exist and if not create
  outdir <- dirname(outfile)

  if (!dir.exists(outdir)) {
    dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
  }

  # See https://github.com/r-universe-org/help/issues/382
  # Write CITATION with comment
  com <- c(
    "# --------------------------------------------",
    "# CITATION file created with {cffr} R package",
    "# See also: https://docs.ropensci.org/cffr/",
    "# --------------------------------------------",
    " "
  )

  # MAX effort to get right the encoding
  com <- enc2utf8(com)
  out_yaml <- enc2utf8(capture.output(print(citat)))
  full_text <- enc2utf8(c(com, out_yaml, ""))
  fh <- file(outfile, encoding = encoding)
  on.exit(if (isOpen(fh)) close(fh))
  writeLines(full_text, fh)

  if (verbose) {
    cli::cli_alert_success("{.file {outfile}} generated")
  }

  # Add CITATION.cff to .Rbuildignore
  if (!is_cff(x) && x == getwd() && file_exist_abort(".Rbuildignore")) {
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

  # Issue #79
  auto_r_citation(
    r_citation = r_citation,
    outfile = outfile,
    verbose = verbose
  )

  invisible(citat)
}


auto_r_citation <- function(
  r_citation = TRUE,
  outfile = "CITATION.cff",
  verbose = TRUE
) {
  # Do nothing
  if (isFALSE(r_citation)) {
    return(invisible(NULL))
  }

  # Else
  if (verbose) {
    cli::cat_rule("Updating inst/CITATION file", col = "cyan", line = 2)
  }
  cffobj <- cff_read(outfile)
  fpath <- "./inst/CITATION"

  cff_write_citation(cffobj, file = fpath, verbose = verbose)
}
