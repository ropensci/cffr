#' Create `bibentry` objects from several sources
#'
#' @rdname as_bibentry
#' @name as_bibentry
#' @order 1

#' @description
#'
#' This function creates `bibentry` objects (see [utils::bibentry()]) from
#' different metadata sources ([`cff`] objects, `DESCRIPTION` files, etc.).
#' Note that a **R** `bibentry` object is the representation of a BibTeX entry,
#' see **Examples**
#'
#' The function tries to map the information of the source `x` into a [`cff`]
#' object and performs a mapping of the metadata to BibTeX, according to
#' `vignette("bibtex_cff", "cffr")`.
#'
#' The inverse transformation (`bibentry` object to [`cff`] reference) can
#' be done with the corresponding [as_cff()] method.
#'
#' @seealso
#' [utils::bibentry()]
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
#'   the [bibentry()] object via \CRANpkg{cffr}. It could be:
#'   * A missing value. That would retrieve the DESCRIPTION
#'     file on your in-development package.
#'   * An existing `cff` object created with [cff()], [cff_create()] or
#'     [as_cff()].
#'   * Path to a CITATION.cff file (`"CITATION.cff"`),
#'   * The name of an installed package (`"jsonlite"`), or
#'   * Path to a DESCRIPTION file (`"DESCRIPTION"`).
#' @param what Fields to extract. The value could be:
#'   - `preferred`: This would create a single entry with the main citation
#'      info of the package.
#'   - `references`: Extract all the entries on `references`.
#'   - `all`: A combination of the previous two options. This would extract
#'      both the preferred citation info and the references.
#'
#' @family bibtex
#' @family coercing
#'
#' @return
#' `as_bibentry()` returns a `bibentry` object (or a list of `bibentry`
#' objects).
#'
#' @export
#'
#' @examples
#' \donttest{
#' # From a cff object
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
#'
#' toBibtex(bib)
#'
#' # Thanks to the S3 Method we can also do
#'
#' toBibtex(cff_object)
#'
#' # From a CITATION.cff file with options
#'
#' path <- system.file("examples/CITATION_complete.cff", package = "cffr")
#' cff_file <- as_bibentry(path, what = "all")
#'
#' toBibtex(cff_file)
#'
#' # For an installed package
#'
#' installed_package <- as_bibentry("jsonvalidate")
#'
#' toBibtex(installed_package)
#'
#'
#' # Use a DESCRIPTION file
#'
#' path2 <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")
#' desc_file <- as_bibentry(path2)
#'
#' toBibtex(desc_file)
#' }
as_bibentry <- function(x,
                        what = c("preferred", "references", "all")) {
  what <- match.arg(what)
  if (is.null(x)) {
    return(NULL)
  }

  if (is_cff_file(x)) {
    x <- cff_read_cff_citation(x)
  }

  if (is_cff(x)) {
    obj <- x
  } else {
    obj <- cff_create(x)
  }


  # Guess case
  cff_type <- guess_cff_part(obj)

  if (cff_type == "cff_full") {
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
  } else if (cff_type == "cff_ref") {
    obj_extract <- list(obj)
  } else {
    obj_extract <- obj
  }

  # Cleanup
  obj_extract <- as.list(obj_extract)
  obj_extract <- obj_extract[lengths(obj_extract) > 0]
  if (length(obj_extract) == 0) {
    return(NULL)
  }

  ref <- lapply(obj_extract, make_bibentry)
  ref <- do.call(c, ref)

  return(ref)
}


make_bibentry <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }

  # Relist to cff for dispatching methods
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

  ## Convert and catch errors ----
  bib <- try(do.call(bibentry, tobibentry), silent = TRUE)

  # If key missing
  if (inherits(bib, "try-error")) {
    message <- attributes(bib)$condition$message
    cli::cli_alert_danger(paste("Can't convert to {.fn bibentry}: "))
    cli::cli_alert_info(message)
    cli::cli_alert_warning("Returning {.val NULL}")
    return(NULL)
  }

  # Unlist easy to undo the do.call effect
  bib <- bib[[1]]

  return(bib)
}

# Helpers to extract info ----
get_bib_howpublised <- function(x) {
  howpublished <- x$medium

  if (!is.null(howpublished)) {
    f <- toupper(substr(howpublished, 0, 1))
    rest <- substr(howpublished, 2, nchar(howpublished))
    howpublished <- paste0(c(f, rest), collapse = "")
  }

  clean_str(howpublished)
}

get_bib_note <- function(x) {
  note <- x$notes

  # unpublished needs a note
  if (all(is.null(note), tolower(x$type) == "unpublished")) {
    note <- "Extracted with cffr R package"
  }

  clean_str(note)
}

guess_bibtype <- function(x) {
  init_guess <- switch(tolower(x$type),
    "article" = "article",
    "book" = "book",
    "manual" = "manual",
    "unpublished" = "unpublished",
    "conference" = "inproceedings",
    "conference-paper" = "inproceedings",
    "proceedings" = "proceedings",
    "magazine-article" = "article",
    "newspaper-article" = "article",
    "pamphlet" = "booklet",
    "report" = "techreport",
    "thesis" = "mastersthesis",
    # We would need to guess
    "misc"
  )

  # Try guess Inbook ----
  # inbook is a book where chapter or pages are present
  has_chapter <- !is.null(clean_str(x$section))
  has_pages <- !is.null(
    clean_str(paste(unique(c(x$start, x$end)), collapse = "--"))
  )

  if (all(init_guess == "book", any(has_chapter, has_pages))) {
    init_guess <- "inbook"
    return(init_guess)
  }

  # Try guess Phdthesis  ----
  if (init_guess == "mastersthesis") {
    ttype <- clean_str(gsub("[[:punct:]]", "", x$`thesis-type`, perl = TRUE))
    # phd
    if (all(!is.null(ttype), grepl("phd", ttype, ignore.case = TRUE))) {
      return("phdthesis")
    }
  }

  # Try guess InCollection  ----
  # Hint: is misc with collection-title and publisher
  if (init_guess == "misc") {
    if (!is.null(clean_str(x$`collection-title`))) {
      return("incollection")
    }
  }

  init_guess
}

get_bib_address <- function(x) {
  # BibTeX 'address' is taken from the publisher (book, others) or the
  # conference (inproceedings).
  # Set logic: conference > institution > publisher
  if (!is.null(x$conference)) {
    addr_search <- x$conference
  } else if (!is.null(x$institution)) {
    addr_search <- x$institution
  } else {
    addr_search <- x$publisher
  }

  address <- clean_str(
    paste(c(
      addr_search$address, addr_search$city, addr_search$region,
      addr_search$country
    ), collapse = ", ")
  )

  # As a fallback, use also location
  if (is.null(address) && !is.null(x$location)) {
    address <- clean_str(x$location$name)
  }

  address
}

get_bib_booktitle <- function(x, bibtype) {
  # This map collection title.
  # If inproceedings, incollection to booktitle
  # rest of cases to series

  book_series <- list()
  tag_value <- clean_str(x[["collection-title"]])


  if (!bibtype %in% c("incollection", "inproceedings")) {
    book_series$series <- tag_value
  } else {
    # Only for incollections and inproceedings map booktitle
    book_series$booktitle <- tag_value

    # Fallback to conference name for inproceedings
    if (all(bibtype == "inproceedings", is.null(tag_value))) {
      book_series$booktitle <- clean_str(x$conference$name)
    }
  }
  book_series
}

get_bib_inst_org <- function(x, bibtype) {
  # For inproceedings, proceedings and manual this field
  # is organization
  # For thesis it should be school

  inst_org <- list()
  # Just name
  inst_name <- clean_str(x$institution$name)

  if (bibtype %in% c("inproceedings", "proceedings", "manual")) {
    inst_org$organization <- inst_name
  } else if (grepl("thesis", bibtype, ignore.case = TRUE)) {
    inst_org$school <- inst_name
  } else {
    inst_org$institution <- inst_name
  }

  # Fallback for techreport, search on affiliation first author

  if (bibtype == "techreport" && is.null(inst_org$institution)) {
    inst_org$institution <- clean_str(x$authors[[1]]$affiliation)
  }

  inst_org
}

make_bibkey <- function(tobibentry) {
  # Be kind and provided a bibentry key

  y <- tobibentry$year


  # Init etall
  etall <- NULL


  # Also Some entries don't have authors, but editors
  # Others may have none (misc, pamphlet)

  init_aut <- tobibentry$author

  # Try get editor in null
  if (is.null(init_aut)) {
    init_aut <- tobibentry$editor
  }

  # If none then get a key based in title
  if (any(is.null(init_aut), length(init_aut) == 0)) {
    r <- tolower(tobibentry$title)
    # Reduce lenght to 15 max
    r <- substr(r, 0, 15)
  } else {
    # First name/surname and et_all if additional authors
    # Bear in mind institutions has only given

    nauths <- length(init_aut)
    if (nauths > 1) etall <- "_etall"


    # Get info of first author
    unz <- unlist(init_aut[1])
    if ("family" %in% names(unz)) {
      r <- unz["family"]
    } else {
      r <- unz["given"]
    }

    r <- tolower(paste0(r, collapse = ""))
  }

  # Try hard to remove accents
  # First with iconv
  r <- iconv(r, from = "UTF-8", to = "ASCII//TRANSLIT", sub = "?")

  # Next to latex
  r <- encoded_utf_to_latex(r)

  # Finally keep only a-z letters for key
  r <- gsub("[^_a-z]", "", r)

  # Append etall and year
  key <- paste0(c(r, etall), collapse = "")
  key <- paste(c(key, y), collapse = ":")
  key
}


get_bib_month <- function(x) {
  m <- x$month

  # Fallback

  if (is.null(m) && !is.null(x$`date-published`)) {
    # Should be YYYY-MM-DD to be valid on cff, so
    m <- as.integer(format(as.Date(x$`date-published`), "%m"))
  }

  # Try to parse to 3 month string
  m_int <- suppressWarnings(as.integer(m))
  m_letters <- clean_str(tolower(month.abb[m_int]))

  if (!is.null(m_letters)) {
    month <- m_letters
  } else {
    month <- clean_str(m)
  }

  month
}

get_bib_year <- function(x) {
  year <- x$year

  # Fallback

  if (is.null(year) && !is.null(x$`date-released`)) {
    # Should be YYYY-MM-DD to be valid on cff, so
    year <- substr(x$`date-released`, 1, 4)
  }

  clean_str(year)
}
