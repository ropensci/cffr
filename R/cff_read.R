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
#' @param meta A list of package metadata as obtained by
#'   [utils::packageDescription()] or `NULL` (the default). See **Details**.
#' @param ... Arguments to be passed to other functions.
#'
#' @return
#' A [`cff`][cff-class] object. In the case of [cff_read_cff_citation()] and
#' [cff_read_description()] a full and (potentially) valid `cff` object.
#'
#' In the case of [cff_read_bib()] and [cff_read_citation()], the result is
#' the `cff` version of a [bibentry()] object (i.e. a bibliographic reference),
#' that can be used to complement another `cff` object.
#'
#'
#' @references
#'
#' R Core Team (2023). _Writing R Extensions_.
#' <https://cran.r-project.org/doc/manuals/r-release/R-exts.html>
#'
#' @details
#'
#' Section 1.9 CITATION files of *Writing R Extensions* (R Core Team 2023)
#' specifies how to create dynamic `CITATION` files using `meta` object, hence
#' the `meta` argument in [cff_read_citation()] may be needed for reading
#' some files correctly.
#'
#' @examples
#' # TODO
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
    "citation" = cff_read_citation(path, ...),
    NULL
  )

  endobj
}

#' @export
#' @rdname cff_read
cff_read_cff_citation <- function(path, ...) {
  if (!file.exists(path)) {
    cli::cli_abort(
      paste(
        "{.file {path}} does not exist. ",
        "Check the {.file {dirname(path)}} directory"
      )
    )
  }

  cffobj <- yaml::read_yaml(path)
  new_cff(cffobj)
}

#' @export
#' @rdname cff_read
cff_read_description <- function(path, cff_version = "1.2.0",
                                 gh_keywords = TRUE,
                                 authors_roles = c("aut", "cre"), ...) {
  if (!file.exists(path)) {
    cli::cli_abort(
      paste(
        "{.file {path}} does not exist. ",
        "Check the {.file {dirname(path)}} directory"
      )
    )
  }

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
cff_read_citation <- function(path, meta = NULL, ...) {
  if (!file.exists(path)) {
    cli::cli_abort(
      paste(
        "{.file {path}} does not exist. ",
        "Check the {.file {dirname(path)}} directory"
      )
    )
  }

  if (!any(is.null(meta), inherits(meta, "packageDescription"))) {
    # nolint start
    # Object for cli only
    ex <- packageDescription("cffr")
    # nolint end

    cli::cli_alert_warning(
      paste0(
        "{.arg meta} should be {.val NULL} or {.obj_type_friendly {ex}}",
        " not {.obj_type_friendly {meta}}. Using {.arg meta = NULL}"
      )
    )
    meta <- NULL
  }

  new_meta <- clean_package_meta(meta)
  the_cit <- try(utils::readCitationFile(path, meta = new_meta), silent = TRUE)

  # If error then new try
  if (inherits(the_cit, "try-error")) {
    cli::cli_alert_warning(
      paste0(
        "It was not possible to read {.file {path}} with the {.arg meta} ",
        "provided. Trying with {.code packageDescription('base')}"
      )
    )
    new_meta <- packageDescription("base")
    the_cit <- try(utils::readCitationFile(path, meta = new_meta),
      silent = TRUE
    )
    # nocov start
    if (inherits(the_cit, "try-error")) {
      cli::cli_alert_danger(
        "Can't read {.file path}, returning {.val NULL}"
      )
      return(NULL)
    }
    # nocov end
  }
  tocff <- cff_parse_citation(the_cit)
  new_cff(tocff)
}

#' @export
#' @rdname cff_read
cff_read_bib <- function(path, encoding = "UTF-8", ...) {
  if (!file.exists(path)) {
    cli::cli_abort(
      paste(
        "{.file {path}} does not exist. ",
        "Check the {.file {dirname(path)}} directory"
      )
    )
  }

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

#' Parse and clean data from DESCRIPTION to create metadata
#' @noRd
clean_package_meta <- function(meta) {
  if (!inherits(meta, "packageDescription")) {
    return(NULL)
  }

  # Convert to a desc object

  # First write to a dcf file
  tmp <- tempfile("DESCRIPTION")
  meta_unl <- unclass(meta)
  write.dcf(meta_unl, tmp)
  pkg <- desc::desc(tmp)
  pkg$coerce_authors_at_r()
  # Extract package data
  meta <- pkg$get(desc::cran_valid_fields)

  # Clean missing and drop empty fields
  meta <- drop_null(lapply(meta, clean_str))

  # Check encoding
  if (!is.null(meta$Encoding)) {
    meta <- lapply(meta, iconv, from = meta$Encoding, to = "UTF-8")
  } else {
    meta$Encoding <- "UTF-8"
  }
  unlink(tmp, force = TRUE)
  meta
}

# For testing, packageDescription object from desc
test_meta <- function(x) {
  src <- x
  my_meta <- desc::desc(src)

  # As list
  my_meta_l <- my_meta$get(desc::cran_valid_fields)
  my_meta_l <- as.list(my_meta_l)
  v_nas <- vapply(my_meta_l, is.na, logical(1))

  my_meta_l <- my_meta_l[!v_nas]
  meta_proto <- packageDescription("cffr")

  class(my_meta_l) <- class(meta_proto)
  attr(my_meta_l, "file") <- x

  my_meta_l
}
