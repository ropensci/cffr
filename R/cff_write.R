#' Write a `CITATION.cff` file
#'
#' @description
#' **This is the core function of the package and likely to be the only one
#' you need when developing a package**.
#'
#' This function writes a `CITATION.cff` file for a given package. It wraps
#' [cff_create()] to create the [`cff`] object, then writes it to a
#' YAML-formatted file in one command.
#'
#' @param outfile The name and path of the `CITATION.cff` to be created.
#' @param r_citation Logical `TRUE/FALSE`. When `TRUE`, the \R package
#'   citation (for example, `inst/CITATION`) is created or updated.
#'   **No backup copy is created**. For more control, use
#'   [cff_write_citation()].
#' @param verbose Logical `TRUE/FALSE`. When `TRUE`, the function displays
#'   informative messages.
#' @param validate Logical `TRUE/FALSE`. Whether to validate the new file with
#'   [cff_validate()].
#' @param encoding The name of the encoding to be assumed. Default is `"UTF-8"`,
#'   but it can be any other value as accepted by [iconv()], such as
#'   `"ASCII//TRANSLIT"`.
#' @inheritParams cff_create
#'
#' @return A `CITATION.cff` file and an invisible `cff` object.
#'
#' @details
#' For details of `authors_roles`, see [cff_create()].
#'
#' When creating and writing a `CITATION.cff` for the first time, this function
#' adds the pattern `"^CITATION\.cff$"` to your `.Rbuildignore` file.
#'
#' @seealso
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("[Guide to Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#' ```
#' This function unifies the [cff_create()] and [cff_validate()] workflow for
#' writing a file.
#'
#' @family writing
#' @export
#' @encoding UTF-8
#' @examples
#' \donttest{
#' tmpfile <- tempfile(fileext = ".cff")
#' cff_obj <- cff_write("jsonlite", outfile = tmpfile)
#'
#' cff_obj
#'
#' # Force cleanup.
#' file.remove(tmpfile)
#' }
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
  # Use the working directory when `x` is missing.
  if (missing(x)) {
    x <- getwd()
  }

  cff_remove_existing_r_citation(r_citation)

  citat <- cff_create(
    x,
    keys = keys,
    cff_version = cff_version,
    gh_keywords = gh_keywords,
    dependencies = dependencies,
    authors_roles = authors_roles
  )

  outfile <- cff_normalize_outfile(outfile)
  cff_write_file(citat, outfile, encoding, verbose)
  cff_update_rbuildignore(x, outfile, verbose)

  if (validate) {
    cff_validate(outfile, verbose)
  }

  # Update `inst/CITATION` when requested.
  auto_r_citation(r_citation = r_citation, outfile = outfile, verbose = verbose)

  invisible(citat)
}

cff_remove_existing_r_citation <- function(r_citation) {
  # Issue 86: remove "inst/CITATION" first.
  if (r_citation) {
    unlink("./inst/CITATION")
  }
}

cff_normalize_outfile <- function(outfile) {
  # Ensure the output file uses a `.cff` extension.
  if (!is_substring(outfile, ".cff$")) {
    outfile <- paste0(outfile, ".cff")
  }

  outfile
}

cff_write_file <- function(citat, outfile, encoding, verbose) {
  cff_ensure_output_dir(outfile)

  full_text <- cff_output_lines(citat)
  fh <- file(outfile, encoding = encoding)
  on.exit(if (isOpen(fh)) close(fh))
  writeLines(full_text, fh)

  if (verbose) {
    cli::cli_alert_success("{.file {outfile}} generated.")
  }
}

cff_ensure_output_dir <- function(outfile) {
  outdir <- dirname(outfile)

  if (!dir.exists(outdir)) {
    dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
  }
}

cff_output_lines <- function(citat) {
  # See https://github.com/r-universe-org/help/issues/382
  # Write `CITATION.cff` with a header comment.
  header <- c(
    "# ------------------------------------------------",
    "# CITATION.cff file created with {cffr} R package",
    "# See also: https://docs.ropensci.org/cffr/",
    "# ------------------------------------------------",
    " "
  )

  # Make the best effort to get the encoding right.
  header <- enc2utf8(header)
  out_yaml <- enc2utf8(capture.output(print(citat)))
  enc2utf8(c(header, out_yaml, ""))
}

cff_update_rbuildignore <- function(x, outfile, verbose) {
  # Add `CITATION.cff` to `.Rbuildignore`.
  if (is_cff(x) || x != getwd() || !file_exist_abort(".Rbuildignore")) {
    return(invisible(NULL))
  }

  ignore <- readLines(".Rbuildignore")

  # If not already present.
  if ("^CITATION\\.cff$" %in% ignore) {
    return(invisible(NULL))
  }

  ignore <- unique(c(ignore, "^CITATION\\.cff$"))

  if (verbose) {
    cli::cli_alert_info(
      "Adding {.file {outfile}} to {.file .Rbuildignore}."
    )
  }
  writeLines(ignore, ".Rbuildignore")

  invisible(NULL)
}

auto_r_citation <- function(
  r_citation = TRUE,
  outfile = "CITATION.cff",
  verbose = TRUE
) {
  # Do nothing.
  if (isFALSE(r_citation)) {
    return(invisible(NULL))
  }

  # Otherwise update `inst/CITATION`.
  if (verbose) {
    cli::cat_rule("Updating {.file inst/CITATION}", col = "cyan", line = 2)
  }
  cffobj <- cff_read(outfile)
  fpath <- "./inst/CITATION"

  cff_write_citation(cffobj, file = fpath, verbose = verbose)
}
