#' Read an external file as a [`cff`] object
#'
#' @description
#' Read files and convert them to [`cff`] objects. Files supported
#' are:
#' - `CITATION.cff` files.
#' - `DESCRIPTION` files.
#' - **R** citation files (usually located in `inst/CITATION`).
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
#' @family reading
#' @seealso
#'
#' The underlying functions used for reading external files:
#' - [yaml::read_yaml()] for `CITATION.cff` files.
#' - [desc::desc()] for `DESCRIPTION` files.
#' - [utils::readCitationFile()] for **R** citation files.
#' - [bibtex::read.bib()] for BibTeX files (extension `*.bib`).
#'
#'
#' @param path Path to a file.
#' @param encoding Encoding to be assumed for `path`. See [readLines()].
#' @param meta A list of package metadata as obtained by
#'   [utils::packageDescription()] or `NULL` (the default). See **Details**.
#' @param ... Arguments to be passed to other functions (i.e. to
#'   [yaml::read_yaml()], [bibtex::read.bib()], etc.).
#'
#' @inheritParams cff_create
#'
#' @return
#'
#' * `cff_read_cff_citation()` and `cff_read_description()` returns a object
#'   with class `cff`.
#' * `cff_read_citation()` and `cff_read_bib()` returns an object of classes
#'   [`cff_ref_lst, cff`][cff_ref_lst] according to the `definitions.references`
#'   specified in the
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Citation File Format schema]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' Learn more about the \CRANpkg{cffr} class system in [cff_class].
#'
#' @references
#'
#' - R Core Team (2023). _Writing R Extensions_.
#'   <https://cran.r-project.org/doc/manuals/r-release/R-exts.html>
#'
#' - Hernangomez D (2022). "BibTeX and CFF, a potential crosswalk."
#'   *The cffr package, Vignettes*. \doi{10.21105/joss.03900},
#'   <https://docs.ropensci.org/cffr/articles/bibtex_cff.html>.
#'
#' @details
#'
#' For details of `cff_read_description()` see [cff_create()].
#'
#' ## The `meta` object
#'
#' Section 1.9 CITATION files of *Writing R Extensions* (R Core Team 2023)
#' specifies how to create dynamic `CITATION` files using `meta` object, hence
#' the `meta` argument in [cff_read_citation()] may be needed for reading
#' some files correctly.
#'
#' @examples
#'
#' # Create cff object from cff file
#'
#' from_cff_file <- cff_read(system.file("examples/CITATION_basic.cff",
#'   package = "cffr"
#' ))
#'
#' head(from_cff_file, 7)
#'
#' # Create cff object from DESCRIPTION
#' from_desc <- cff_read(system.file("examples/DESCRIPTION_basic",
#'   package = "cffr"
#' ))
#'
#' from_desc
#'
#' # Create cff object from BibTex
#'
#' if (requireNamespace("bibtex", quietly = TRUE)) {
#'   from_bib <- cff_read(system.file("examples/example.bib",
#'     package = "cffr"
#'   ))
#'
#'   # First item only
#'   from_bib[[1]]
#' }
#' # Create cff object from CITATION
#' from_citation <- cff_read(system.file("CITATION", package = "cffr"))
#'
#' # First item only
#' from_citation[[1]]
#'
cff_read <- function(path, ...) {
  if (length(path) > 1) {
    cli::cli_abort(
      "Use a single value, {.arg path} has length {.val {length(path)}}"
    )
  }

  file_exist_abort(path, abort = TRUE)
  filetype <- detect_x_source(path)

  if (filetype == "dontknow") {
    cli::cli_abort(
      paste0(
        "Don't recognize the file type of {.file {path}}.",
        " Use a specific function (e.g. {.fn cffr:cff_read_description}"
      )
    )
  }

  endobj <- switch(filetype,
    "cff_citation" = cff_read_cff_citation(path, ...),
    "description" = cff_read_description(path, ...),
    "bib" = cff_read_bib(path, ...),
    "citation" = cff_read_citation(path, ...),
    cli::cli_abort("Don't know how to read {.val {x}}.")
  )

  endobj
}

#' @export
#' @rdname cff_read
cff_read_cff_citation <- function(path, ...) {
  file_exist_abort(path, abort = TRUE)

  cffobj <- yaml::read_yaml(path, ...)
  new_cff(cffobj)
}

#' @export
#' @rdname cff_read
cff_read_description <- function(path, cff_version = "1.2.0",
                                 gh_keywords = TRUE,
                                 authors_roles = c("aut", "cre"), ...) {
  file_exist_abort(path, abort = TRUE)

  pkg <- desc::desc(path)
  pkg$coerce_authors_at_r()

  msg <- paste0(
    'To cite package "', pkg$get("Package"),
    '" in publications use:'
  )


  field_list <- list(
    "cff-version" = cff_version,
    message = msg,
    type = "software",
    title = get_desc_title(pkg),
    version = get_desc_version(pkg),
    authors = get_desc_authors(pkg, authors_roles = authors_roles),
    abstract = get_desc_abstract(pkg),
    repository = get_desc_repository(pkg),
    "repository-code" = get_desc_urls(pkg)$repo,
    url = get_desc_urls(pkg)$url,
    identifiers = get_desc_urls(pkg)$identifiers,
    "date-released" = get_desc_date_released(pkg),
    contact = get_desc_contacts(pkg),
    keywords = get_desc_keywords(pkg),
    license = unlist(get_desc_license(pkg)),
    commit = get_desc_sha(pkg),
    doi = get_desc_doi(pkg)
  )

  if (gh_keywords) {
    ghtopics <- get_gh_topics(field_list)
    field_list$keywords <- unique(c(field_list$keywords, ghtopics))
  }

  new_cff(field_list)
}

#' @export
#' @rdname cff_read
cff_read_citation <- function(path, meta = NULL, ...) {
  file_exist_abort(path, abort = TRUE)

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
  tocff <- as_cff(the_cit)

  tocff
}

#' @export
#' @family bibtex
#' @rdname cff_read
cff_read_bib <- function(path, encoding = "UTF-8", ...) {
  file_exist_abort(path, abort = TRUE)

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


  tocff <- as_cff(read_bib)
  tocff
}

# Internal safe ----
#' Internal version of cff_read_citation, safe
#' @noRd
cff_safe_read_citation <- function(desc_path, cit_path) {
  if (!file_exist_abort(cit_path) || !file_exist_abort(desc_path)) {
    return(NULL)
  }
  # Create meta
  meta <- desc_to_meta(desc_path)
  meta <- clean_package_meta(meta)


  the_cit <- try(utils::readCitationFile(cit_path, meta = meta), silent = TRUE)
  # Try
  if (inherits(the_cit, "try-error")) {
    return(NULL)
  }

  # Need to be named here
  tocff <- as_cff(the_cit)
  tocff
}

# See utils.R
