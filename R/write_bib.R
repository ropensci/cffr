#' Create a `.bib` file
#'
#' Creates `a .bib` file from a `bibentry` object(s)
#'
#' @param x A `bibentry` object created with:
#'    - [cff_to_bibentry()]
#'    - [citation()] or [bibentry()]
#'
#' @param file Name of the file. If `NULL` it would display the lines to be
#'   written.
#' @param append Whether to append the entries to an existing file or not.
#' @param verbose Display informative messages
#' @param ascii Whether to write the entries using ASCII characters only or not.
#'
#' @export
#' @family BibTeX helpers
#'
#' @return Writes an `.bib` file specified on `file` parameter and the
#' equivalent `Bibtex` object created with [utils::toBibtex()]. It also
#' (invisibly) returns the `bibentry` object that has been written to the file.
#'
#' @details
#'
#' For security reasons, if the file already exists the function would create
#' a backup copy on the same directory.
#'
#' @seealso `vignette("bibtex_cff", "cffr")`, [knitr::write_bib()] and the
#' following packages:
#' - \CRANpkg{bibtex}.
#' - \CRANpkg{RefManageR}
#' - \CRANpkg{rbibutils}
#'
#' @examples
#'
#' bib <- bibentry("Misc",
#'   title = "My title",
#'   author = "Fran Pérez"
#' )
#'
#' write_bib(bib)
#'
#' write_bib(bib, ascii = TRUE)
write_bib <- function(x,
                      file = NULL,
                      append = FALSE,
                      verbose = TRUE,
                      ascii = FALSE) {
  if (!inherits(x, "bibentry")) {
    cli::cli_abort("{.arg x} should be a {.cls bibentry} object")
  }

  btex <- toBibtex(x)

  if (ascii) {
    # Base encoding as per file()
    btex <- encoded_utf_to_latex(btex)
    class(btex) <- "Bibtex"
  } else {
    btex <- enc2utf8(btex)
  }

  if (is.null(file)) {
    return(btex)
  }

  if (tools::file_ext(file) != "bib") file <- paste0(file, ".bib")

  # Check that the directory exists, if not create
  dir <- dirname(path.expand(file))
  if (!dir.exists(dir)) {
    if (verbose) cli::cli_alert_info("Creating directory {.path {dir}}")
    dir.create(dir, recursive = TRUE)
  }


  # If exists creates a backup
  if (file.exists(file)) {
    for (i in seq(1, 100)) {
      f <- paste0(file, ".bk", i)
      if (!file.exists(f)) break
    }

    if (verbose) {
      cli::cli_alert_info(
        "Creating a backup of {.file {file}} in {.file {f}}"
      )
    }
    file.copy(file, f)
  }


  fh <- file(file, encoding = "UTF-8", open = if (append) {
    "a+"
  } else {
    "w+"
  })
  on.exit(if (isOpen(fh)) close(fh))
  if (verbose) {
    cli::cli_alert_info("Writing {length(x)} BibTeX entr{?y/ies} ...")
  }
  writeLines(btex, fh)
  if (verbose) {
    cli::cli_alert_success("Results written to {.file {file}}")
  }
  invisible(btex)
}
