#' Create [`bibentry`] objects from several sources
#'
#' @rdname as_bibentry
#' @name as_bibentry
#' @order 1
#' @description
#'
#' This function creates [`bibentry`] objects from different metadata sources
#' ([`cff`] objects, `DESCRIPTION` files, etc.). The inverse transformation
#' (`bibentry` object to [`cff_ref_lst`]) can be done with the corresponding
#' [as_cff.bibentry()] method.
#'
#' With [`toBibtex()`][toBibtex.cff()] it is possible to convert `cff` objects
#' to BibTeX markup on the fly, see **Examples**.
#'
#' @seealso
#' [utils::bibentry()] to understand more about the `bibentry` class.
#'
#' - `vignette("crosswalk", package = "cffr")` provides details on how the
#'   metadata of a package is mapped to produce a `cff` object.
#'
#' - `vignette("bibtex_cff", "cffr")` provides detailed information about the
#'   internal mapping performed between `cff` objects and BibTeX markup (
#'   both `cff` to BibTeX and BibTeX to `cff`).
#'
#' Other related functions:
#' - [utils::toBibtex()].
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
#'   <https://docs.ropensci.org/cffr/articles/bibtex_cff.html>.
#'
#' @param x The source that would be used for generating
#'   the `bibentry` object via \CRANpkg{cffr}. It could be:
#'   * A missing value. That would retrieve the `DESCRIPTION`
#'     file on your in-development package.
#'   * An existing `cff` object created with [cff()], [cff_create()] or
#'     [as_cff()].
#'   * Path to a CITATION.cff file (`"CITATION.cff"`),
#'   * The name of an installed package (`"jsonlite"`), or
#'   * Path to a DESCRIPTION file (`"DESCRIPTION"`).
#' @param ... Additional arguments to be passed to or from methods.
#'
#' @param what Fields to extract from a full `cff` object. The value could be:
#'   - `preferred`: This would create a single entry with the main citation
#'      info of the package (key `preferred-citation`).
#'   - `references`: Extract all the entries of `references` key.
#'   - `all`: A combination of the previous two options. This would extract
#'      both the `preferred-citation` and the `references` key.
#'
#'  See `vignette("crosswalk", package = "cffr")`.
#'
#' @family bibtex
#' @family s3method
#'
#'
#' @details
#'
#' A **R** `bibentry` object is the representation of a BibTeX entry. These
#' objects can be converted to BibTeX markup with [toBibtex()], that creates an
#' object of class `Bibtex` and can be printed and exported as a valid BibTeX
#' entry.
#'
#'
#' `as_bibtex()` tries to map the information of the source `x` into a `cff]
#' object and performs a mapping of the metadata to BibTeX, according to
#' `vignette("bibtex_cff", "cffr")`.
#'
#' @return
#' `as_bibentry()` returns a `bibentry` object with one or more entries.
#'
#' @export
#'
#' @examples
#' \donttest{
#' # From a cff object ----
#' cff_object <- cff()
#'
#' cff_object
#'
#' # bibentry object
#' bib <- as_bibentry(cff_object)
#'
#' class(bib)
#'
#' bib
#'
#' # Print as bibtex
#' toBibtex(bib)
#'
#' # Thanks to the S3 Method we can also do
#' toBibtex(cff_object)
#'
#' # Other sources ----
#' # From a CITATION.cff
#'
#' path <- system.file("examples/CITATION_complete.cff", package = "cffr")
#' cff_file <- as_bibentry(path)
#'
#' cff_file
#'
#' # For an installed package with options
#' installed_package <- as_bibentry("jsonvalidate", what = "all")
#'
#' installed_package
#'
#'
#' # Use a DESCRIPTION file
#' path2 <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")
#' desc_file <- as_bibentry(path2)
#'
#' toBibtex(desc_file)
#' }
#'
as_bibentry <- function(x, ...) {
  UseMethod("as_bibentry")
}


#' @export
#' @rdname as_bibentry
#' @order 2
as_bibentry.default <- function(x, ...) {
  dot_list <- list(...)
  as_bibentry(dot_list)
}

#' @export
#' @rdname as_bibentry
#' @order 3
as_bibentry.character <- function(x, ...,
                                  what = c("preferred", "references", "all")) {
  # A named list
  if (missing(x)) {
    dot_list <- list(...)
    return(as_bibentry(dot_list))
  }


  what <- match_cff_arg(
    what, c("preferred", "references", "all"),
    "what", environment()
  )


  x <- x[1]
  src_detect <- detect_x_source(x)

  if (src_detect == "dontknow") {
    # nolint start
    msg <- paste0('install.packages("', x, '")')
    # nolint end
    cli::cli_abort(
      paste(
        "Don't know how to extract a {.cls bibentry} from {.val {x}}.",
        "If it is a package run {.run {msg}} first."
      )
    )
  }

  if (src_detect == "package") {
    x <- cff_create(x)
  } else {
    x <- cff_read(x)
  }

  as_bibentry(x, what = what)
}

#' @export
#' @rdname as_bibentry
#' @order 4
as_bibentry.NULL <- function(x, ...) {
  cff_create()
}


#' @export
#' @rdname as_bibentry
#' @order 5
as_bibentry.list <- function(x, ...) {
  ## Convert and catch errors ----
  bib <- try(do.call(bibentry, x), silent = TRUE)

  # If key missing
  if (inherits(bib, "try-error")) {
    message <- attributes(bib)$condition$message
    cli::cli_alert_danger(paste("Can't convert to {.fn bibentry}: "))
    cli::cli_alert_info(message)
    cli::cli_alert_warning("Returning empty {.cls bibentry}")
    return(bibentry())
  }

  # Unlist easy to undo the do.call effect
  bib <- bib[[1]]

  bib
}


#' @export
#' @rdname as_bibentry
#' @order 6
as_bibentry.cff <- function(x, ...,
                            what = c("preferred", "references", "all")) {
  what <- match_cff_arg(
    what, c("preferred", "references", "all"),
    "what", environment()
  )

  obj <- x
  # Try to generate preferred if not present
  if (!("preferred-citation" %in% names(obj))) {
    prefcit <- obj
    prefcit$type <- "generic"
    prefcit <- prefcit[names(prefcit) %in% cff_schema_definitions_refs()]
    prefcit <- new_cff(prefcit)
    # And add to the object
    obj$`preferred-citation` <- prefcit
  }

  # Select type to extract
  obj_extract <- switch(what,
    "preferred" = list(obj$`preferred-citation`),
    "references" = obj$references,
    c(list(obj$`preferred-citation`), obj$references)
  )

  if (is.null(obj_extract)) {
    cli::cli_alert_warning(
      paste0(
        "In {.arg x} didn't find anything with {.arg what} = {.val {what}}. ",
        "Returning empty {.cls bibentry}."
      )
    )
    return(bibentry())
  }

  # Prepare for dispatching
  objend <- as_cff(obj_extract)

  as_bibentry(objend)
}

#' @export
#' @rdname as_bibentry
#' @order 7
as_bibentry.cff_ref_lst <- function(x, ...) {
  ref <- lapply(x, function(y) {
    # Reclass to dispatch method
    as_bibentry(as_cff(y))
  })
  ref <- do.call(c, ref)
  return(ref)
}



#' @export
#' @rdname as_bibentry
#' @order 8
as_bibentry.cff_ref <- function(x, ...) {
  # Relist to cff for dispatching methods on persons
  x <- as_cff(x)

  # Partially based on ruby parser
  # https://github.com/citation-file-format/ruby-cff/blob/main/lib/cff/ >>
  # (cont) formatter/bibtex_formatter.rb

  # Create a initial empty list

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
  tobibentry$pages <- clean_str(
    paste(unique(c(x$start, x$end)), collapse = "--")
  )

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
  # Map cff collection-title
  tobibentry <- c(tobibentry, get_bib_booktitle(x, tobibentry$bibtype))

  # institution/organization/school ----
  # Map cff institution
  tobibentry <- c(tobibentry, get_bib_inst_org(x, tobibentry$bibtype))

  # month----
  tobibentry$month <- get_bib_month(x)

  # year ----
  tobibentry$year <- get_bib_year(x)


  # Handle anonymous author----
  # If anonymous coming from cff and not needed, then not use it

  is_anon <- identical(clean_str(x$authors[[1]]$name), "anonymous")

  # If unknown remove from bib types that doesn't require it strictly


  if (all(
    is_anon,
    tobibentry$bibtype %in% c(
      "booklet", "manual", "book", "inbook",
      "misc", "proceedings"
    )
  )) {
    tobibentry$author <- NULL
  }
  # BibTeX key----
  tobibentry$key <- make_bibkey(tobibentry)

  # Final steps ----
  ##  Sort ----
  # based on default by
  # https://flamingtempura.github.io/bibtex-tidy/
  tosort <- c(
    "title", "author", "year", "month", "day", "journal", "booktitle",
    "publisher", "address", "editor", "series", "volume", "number", "pages",
    "doi", "isbn", "issn", "url", "note"
  )

  unique <- unique(c(tosort, names(tobibentry)))
  sorted <- unique[unique %in% names(tobibentry)]
  tobibentry <- tobibentry[sorted]

  ## Convert

  as_bibentry(tobibentry)
}

# Utils in utils-bib.R
