#' Read an external file as a [`cff`][cff-class] object
#'
#' @description
#' Read files and convert them to [`cff`][cff-class] objects. Files supported
#' are:
#' - `CITATION.cff` files
#' - `DESCRIPTION` files
#' - **R** citation files (usually located in `inst/CITATION`)
#' - BibTeX files (with extension `*.bib`).
#'
#' [cff_read()] would try to guess the type of file provided in `path`. However
#' we provide a series of alias for each specific type of file:
#' - [cff_read_cff_citation()], that uses [yaml::read_yaml()].
#' - [cff_read_description()], using [desc::desc()].
#' - [cff_read_citation()] uses [utils::readCitationFile()].
#' - [cff_read_bib()]  requires \CRANpkg{bibtex} (>= 0.5.0) and uses
#'   [bibtex::read.bib()].
#'
#' @export
#' @rdname cff_read
#'
#' @param path Path to a file
#' @param cff_version The Citation File Format schema version that the
#'   `CITATION.cff` file adheres to for providing the citation metadata.
#' @param gh_keywords Logical `TRUE/FALSE`. If the package is hosted on
#'   GitHub, would you like to add the repo topics as keywords?
#' @param authors_roles Roles to be considered as authors of the package when
#'   generating the [`cff`][cff-class] object.
#' @param encoding Encoding to be assumed for `path`. See [readLines()].
#' @param ... Arguments to be passed to other functions.
#'
#' @return A [`cff`][cff-class] object.
#'
#'
cff_read <- function(path, ...) {
  if (length(path) > 1) {
    cli::cli_abort(
      "Use a single value, {.arg path} has length {.val {length(path)}}"
    )
  }

  if (!file.exists(path)) {
    cli::cli_abort(
      paste(
        "{.file {path}} does not exist. ",
        "Check the {.file {dirname(path)}} directory"
      )
    )
  }
  filetype <- guess_type_file(path)

  endobj <- switch(filetype,
    "cff_citation" = cff_read_cff_citation(path, ...),
    "description" = cff_read_description(path, ...),
    "bib" = cff_read_bib(path, ...),
    NULL
  )

  endobj
}

#' @export
#' @rdname cff_read
cff_read_cff_citation <- function(path, ...) {
  cffobj <- yaml::read_yaml(path)
  new_cff(cffobj)
}

#' @export
#' @rdname cff_read
cff_read_description <- function(path, cff_version = "1.2.0",
                                 gh_keywords = TRUE,
                                 authors_roles = c("aut", "cre"), ...) {
  pkg <- desc::desc(path)
  pkg$coerce_authors_at_r()

  msg <- paste0(
    'To cite package "', pkg$get("Package"),
    '" in publications use:'
  )


  list_fields <- list(
    "cff-version" = cff_version,
    message = msg,
    type = "software",
    title = parse_desc_title(pkg),
    version = parse_desc_version(pkg),
    authors = parse_desc_authors(pkg, authors_roles = authors_roles),
    abstract = parse_desc_abstract(pkg),
    repository = parse_desc_repository(pkg),
    "repository-code" = parse_desc_urls(pkg)$repo,
    url = parse_desc_urls(pkg)$url,
    identifiers = parse_desc_urls(pkg)$identifiers,
    "date-released" = parse_desc_date_released(pkg),
    contact = parse_desc_contacts(pkg),
    keywords = parse_desc_keywords(pkg),
    license = unlist(parse_desc_license(pkg))
  )

  if (gh_keywords) {
    ghtopics <- parse_ghtopics(list_fields)
    list_fields$keywords <- unique(c(list_fields$keywords, ghtopics))
  }

  new_cff(list_fields)
}

#' @export
#' @rdname cff_read
cff_read_cff_citation <- function(path, ...) {
  cffobj <- yaml::read_yaml(path)
  new_cff(cffobj)
}

#' @export
#' @rdname cff_read
cff_read_bib <- function(path, encoding = "UTF-8", ...) {
  # nocov start
  if (!requireNamespace("bibtex", quietly = TRUE)) {
    msg <- paste0(
      "{.pkg bibtex} package required for using this function: ",
      '{.run install.packages("bibtex")}'
    )
    cli::cli_abort(msg)
  }
  # nocov end

  # Read from tempfile
  read_bib <- bibtex::read.bib(file = path, encoding = encoding, ...)


  tocff <- cff_parse_citation(read_bib)
  new_cff(tocff)
}


guess_type_file <- function(path) {
  if (grepl("\\.cff$", path, ignore.case = TRUE)) {
    return("cff_citation")
  }
  if (grepl("\\.bib$", path, ignore.case = TRUE)) {
    return("bib")
  }
  if (grepl("citat", path, ignore.case = TRUE)) {
    return("citation")
  }
  if (grepl("desc", path, ignore.case = TRUE)) {
    return("description")
  }

  cli::cli_abort(
    paste0(
      "Don't recognize the file type of {.file {path}}.",
      " Use a specific function (e.g. {.fn cffr:cff_read_description}"
    )
  )
}
