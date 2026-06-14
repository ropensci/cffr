#' Create [`bibentry`] objects from several sources
#'
#' @description
#' This function creates [`bibentry`] objects from different metadata sources
#' ([`cff`] objects, `DESCRIPTION` files and other sources). The inverse
#' transformation (`bibentry` object to [`cff_ref_lst`]) can be done with the
#' corresponding [as_cff.bibentry()] method.
#'
#' With [`toBibtex()`][toBibtex.cff()], you can convert [`cff`]
#' objects to BibTeX markup on the fly. See **Examples**.
#'
#' @param x The source used to generate the `bibentry` object with
#'   \CRANpkg{cffr}. It can be:
#'   - A missing value, which retrieves the `DESCRIPTION` file from your
#'     in-development package.
#'   - An existing `cff` object created with [cff()], [cff_create()], or
#'     [as_cff()].
#'   - Path to a `CITATION.cff` file (`"CITATION.cff"`).
#'   - The name of an installed package (`"jsonlite"`).
#'   - Path to a `DESCRIPTION` file (`"DESCRIPTION"`).
#' @param ... Additional arguments passed to or from methods.
#'
#' @param what Fields to extract from a full `cff` object. It can be:
#'   - `preferred`: Create a single entry with the main citation information
#'     of the package (key `preferred-citation`).
#'   - `references`: Extract all entries of the `references` key.
#'   - `all`: Extract both the `preferred-citation` and `references` keys.
#'
#' See `vignette("r-cff", package = "cffr")`.
#'
#' @return
#' `as_bibentry()` returns a `bibentry` object with one or more entries.
#'
#' @details
#' An \R `bibentry` object is the representation of a BibTeX entry. These
#' objects can be converted to BibTeX markup with [toBibtex()], which creates
#' an object of class `Bibtex` that can be printed and exported as a valid
#' BibTeX entry.
#'
#' `as_bibentry()` tries to map the information of the source `x` into a [`cff`]
#' object and performs a mapping of the metadata to BibTeX, according to
#' `vignette("bibtex-cff", package = "cffr")`.
#'
#' @references
#' - Patashnik, Oren. "BIBTEXTING" February 1988.
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' - Haines, R., & The Ruby Citation File Format Developers. (2021).
#'   *Ruby CFF Library (Version 0.9.0)* (Computer software).
#'   \doi{10.5281/zenodo.1184077}.
#'
#' - Hernangomez D (2022). "BibTeX and CFF, a potential crosswalk."
#'   *The cffr package, Vignettes*. \doi{10.21105/joss.03900},
#'   <https://docs.ropensci.org/cffr/articles/bibtex-cff.html>.
#'
#' @seealso
#' [utils::bibentry()] to understand more about the `bibentry` class.
#'
#' - `vignette("r-cff", package = "cffr")` provides details on how the
#'   metadata of a package is mapped to produce a `cff` object.
#'
#' - `vignette("bibtex-cff", package = "cffr")` provides detailed information
#'   about the internal mapping performed between `cff` objects and BibTeX
#'   markup, both `cff` to BibTeX and BibTeX to `cff`.
#'
#' Other related functions:
#' - [utils::toBibtex()].
#'
#' @family bibtex
#' @family s3method
#' @rdname as_bibentry
#' @name as_bibentry
#' @order 1
#' @export
#' @encoding UTF-8
#' @examples
#' \donttest{
#' # From a `cff` object ----
#' cff_object <- cff()
#'
#' cff_object
#'
#' # A bibentry object.
#' bib <- as_bibentry(cff_object)
#'
#' class(bib)
#'
#' bib
#'
#' # Print as BibTeX.
#' toBibtex(bib)
#'
#' # Thanks to the S3 method, you can also do this.
#' toBibtex(cff_object)
#'
#' # Other sources ----
#' # From a CITATION.cff.
#'
#' path <- system.file("examples/CITATION_complete.cff", package = "cffr")
#' cff_file <- as_bibentry(path)
#'
#' cff_file
#'
#' # For an installed package with options.
#' installed_package <- as_bibentry("jsonvalidate", what = "all")
#'
#' installed_package
#'
#' # Use a DESCRIPTION file.
#' path2 <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")
#' desc_file <- as_bibentry(path2)
#'
#' toBibtex(desc_file)
#' }
#'
as_bibentry <- function(x, ...) {
  UseMethod("as_bibentry")
}

#' @rdname as_bibentry
#' @order 2
#' @export
#' @encoding UTF-8
as_bibentry.default <- function(x, ...) {
  dot_list <- list(...)
  as_bibentry(dot_list)
}

#' @rdname as_bibentry
#' @order 3
#' @export
#' @encoding UTF-8
as_bibentry.character <- function(
  x,
  ...,
  what = c("preferred", "references", "all")
) {
  # A named list
  if (missing(x)) {
    dot_list <- list(...)
    return(as_bibentry(dot_list))
  }

  what <- match_cff_arg(
    what,
    c("preferred", "references", "all"),
    "what",
    environment()
  )

  x <- x[1]
  src_detect <- detect_x_source(x)

  if (src_detect == "dontknow") {
    # nolint start
    msg <- paste0('install.packages("', x, '")')
    # nolint end
    cli::cli_abort(paste(
      "Cannot extract a {.cls bibentry} from {.val {x}}.",
      "If it is a package, run {.run {msg}} first."
    ))
  }

  if (src_detect == "package") {
    x <- cff_create(x)
  } else {
    x <- cff_read(x)
  }

  as_bibentry(x, what = what)
}

#' @rdname as_bibentry
#' @order 4
#' @export
#' @encoding UTF-8
as_bibentry.NULL <- function(x, ...) {
  cff_create()
}

#' @rdname as_bibentry
#' @order 5
#' @export
#' @encoding UTF-8
as_bibentry.list <- function(x, ...) {
  ## Convert and catch errors ----
  bib <- try(do.call(bibentry, x), silent = TRUE)

  # Return an empty object if a key is missing.
  if (inherits(bib, "try-error")) {
    message <- attributes(bib)$condition$message
    cli::cli_alert_danger("Cannot convert to {.fn bibentry}.")
    cli::cli_alert_info(message)
    cli::cli_alert_warning("Returning an empty {.cls bibentry}.")
    return(bibentry())
  }

  # Unlist to undo the do.call effect.
  bib <- bib[[1]]

  bib
}

#' @rdname as_bibentry
#' @order 6
#' @export
#' @encoding UTF-8
as_bibentry.cff <- function(
  x,
  ...,
  what = c("preferred", "references", "all")
) {
  what <- match_cff_arg(
    what,
    c("preferred", "references", "all"),
    "what",
    environment()
  )

  obj <- x
  # Generate a preferred citation if it is not present.
  if (!("preferred-citation" %in% names(obj))) {
    prefcit <- obj
    prefcit$type <- "generic"
    prefcit <- prefcit[names(prefcit) %in% cff_schema_definitions_refs()]
    prefcit <- new_cff(prefcit)
    # Add it to the object.
    obj$`preferred-citation` <- prefcit
  }

  # Select the type to extract.
  obj_extract <- switch(what,
    "preferred" = list(obj$`preferred-citation`),
    "references" = obj$references,
    c(list(obj$`preferred-citation`), obj$references)
  )

  if (is.null(obj_extract)) {
    cli::cli_alert_warning(paste0(
      "In {.arg x}, did not find anything with {.arg what} = {.val {what}}. ",
      "Returning an empty {.cls bibentry}."
    ))
    return(bibentry())
  }

  # Prepare for dispatching.
  objend <- as_cff(obj_extract)

  as_bibentry(objend)
}

#' @rdname as_bibentry
#' @order 7
#' @export
#' @encoding UTF-8
as_bibentry.cff_ref_lst <- function(x, ...) {
  ref <- lapply(x, function(y) {
    # Reclass to dispatch the method.
    as_bibentry(as_cff(y))
  })
  ref <- do.call(c, ref)
  ref
}

#' @rdname as_bibentry
#' @order 8
#' @export
#' @encoding UTF-8
as_bibentry.cff_ref <- function(x, ...) {
  # Relist to cff for dispatching methods on persons.
  x <- as_cff(x)

  # Partially based on the Ruby parser.
  # https://github.com/citation-file-format/ruby-cff/blob/main/lib/cff/ >>
  # (cont) formatter/bibtex_formatter.rb

  # Create an initial empty list.

  tobibentry <- list()

  # Direct mapping ----

  ## From BibTeX ----
  ### author----
  tobibentry$author <- as.person(x$authors)
  ### chapter----
  tobibentry$chapter <- x$section

  ### edition----
  tobibentry$edition <- x$edition

  ### editor----
  tobibentry$editor <- as.person(x$editors)

  ### howpublished----
  tobibentry$howpublished <- get_bib_howpublised(x)

  ### journal----
  tobibentry$journal <- x$journal

  ### note ----
  tobibentry$note <- get_bib_note(x)

  ### number----
  tobibentry$number <- clean_str(x[["issue"]])

  ### pages ----
  tobibentry$pages <- clean_str(paste(
    unique(c(x$start, x$end)),
    collapse = "--"
  ))

  ### publisher ----
  tobibentry$publisher <- clean_str(x$publisher$name)

  ### title ----
  tobibentry$title <- x$title

  ### volume----
  tobibentry$volume <- x$volume

  ## From BibLaTeX ----

  tobibentry$abstract <- x$abstract
  tobibentry$date <- x$`date-published`
  tobibentry$doi <- x$doi
  tobibentry$file <- x$filename
  tobibentry$isbn <- x$isbn
  tobibentry$issn <- x$issn
  tobibentry$issuetitle <- x$`issue-title`
  tobibentry$keywords <- clean_str(paste0(unique(x$keywords), collapse = ","))
  tobibentry$pagetotal <- x$pages
  tobibentry$translator <- toBibtex(as.person(x$translators))
  tobibentry$url <- x$url
  tobibentry$urldate <- x$`date-accessed`
  tobibentry$version <- x$version

  # BibTeX entry----

  tobibentry$bibtype <- guess_bibtype(x)

  # address----
  tobibentry$address <- get_bib_address(x)

  # booktitle /series ----
  # Map cff collection-title.
  tobibentry <- c(tobibentry, get_bib_booktitle(x, tobibentry$bibtype))

  # institution/organization/school ----
  # Map cff institution.
  tobibentry <- c(tobibentry, get_bib_inst_org(x, tobibentry$bibtype))

  # month----
  tobibentry$month <- get_bib_month(x)

  # year ----
  tobibentry$year <- get_bib_year(x)

  # Handle anonymous author----
  # If an anonymous author comes from cff and is not needed, do not use it.

  is_anon <- identical(clean_str(x$authors[[1]]$name), "anonymous")

  # If unknown, remove it from BibTeX types that do not strictly require it.

  if (
    all(
      is_anon,
      tobibentry$bibtype %in%
        c("booklet", "manual", "book", "inbook", "misc", "proceedings")
    )
  ) {
    tobibentry$author <- NULL
  }
  # BibTeX key----
  tobibentry$key <- make_bibkey(tobibentry)

  # Final steps ----
  ## Sort ----
  # Based on the default from
  # https://flamingtempura.github.io/bibtex-tidy/
  tosort <- c(
    "title",
    "author",
    "year",
    "month",
    "day",
    "journal",
    "booktitle",
    "publisher",
    "address",
    "editor",
    "series",
    "volume",
    "number",
    "pages",
    "doi",
    "isbn",
    "issn",
    "url",
    "note"
  )

  unique <- unique(c(tosort, names(tobibentry)))
  sorted <- unique[unique %in% names(tobibentry)]
  tobibentry <- tobibentry[sorted]

  ## Convert

  as_bibentry(tobibentry)
}

# Utils in utils-bib.R
