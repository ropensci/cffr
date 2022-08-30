#' Create a .bib file
#'
#' Creates a .bib file from a `bibentry` object(s)
#'
#' @param x A `bibentry` object created with:
#'    - [cff_extract_to_bibtex()], [cff_to_bibtex()]
#'    - [citation()] or [bibentry()]
#'
#' @param file Name of the file. If `NULL` it would display the lines to be
#'   written.
#' @param append Whether to append the entries to an existing file or not.
#' @param verbose Display informative messages
#' @param ascii Whether to write the entries using ASCII characters only or not.
#'
#' @export
#' @family bibtex
#'
#' @return Writes an `.bib` file specified on `file` parameter and the
#' equivalent `Bibtex` object created with [utils::toBibtex()].
#'
#' @details
#'
#' For security reasons, if the file already exists the function would create
#' a backup copy on the same directory.
#'
#' @seealso `vignette("bibtex_cff", "cffr")`, [knitr::write_bib()] and the
#' following packages:
#' - [bibtex](https://github.com/ropensci/bibtex) package.
#' - [RefManageR](https://github.com/ropensci/RefManageR) package.
#' - [rbibutils](https://github.com/GeoBosh/rbibutils/)
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
  if (!"bibentry" %in% class(x)) {
    stop("bibentry should be a class 'bibentry' object")
  }

  btex <- toBibtex(x)

  if (ascii) {
    # Base encoding as per file()
    encoding <- getOption("encoding")
    btex <- encoded_utf_to_latex(btex)
    class(btex) <- "Bibtex"
  } else {
    encoding <- "UTF-8"
    btex <- enc2utf8(btex)
  }

  if (is.null(file)) {
    return(btex)
  }

  if (tools::file_ext(file) != "bib") file <- paste0(file, ".bib")

  # If exists creates a backup
  if (file.exists(file)) {
    for (i in seq(1, 100)) {
      f <- paste0(file, ".bk", i)
      if (!file.exists(f)) break
    }

    if (verbose) {
      message(
        "Creating a backup of ",
        file, " in ", f
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
    message("Writing ", length(bibentry), " Bibtex entries ... ",
      appendLF = FALSE
    )
  }
  writeLines(btex, fh)
  if (verbose) {
    message(
      "OK\nResults written to file '", file,
      "'"
    )
  }
  invisible(btex)
}
