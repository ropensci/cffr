#' Create a BibTeX entry from a CITATION file or a `cff` object
#'
#' Creates a `bibentry` object ([bibentry()]) from a `cff` object
#'
#' @param x The source that would be used for generating
#'   the [`cff`] object. It could be:
#'   * An existing [`cff`] object,
#'   * A CITATION.cff file.
#'
#' @return A `bibentry` object that can be parsed to BibTeX format with
#'   [toBibtex()]
#'
#' @seealso [cff_parse_citation()], [bibentry()], [toBibtex()]
#'
#' @references
#' - Patashnik, Oren. "BIBTEXTING" February 1988.
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' - Haines, R., & The Ruby Citation File Format Developers. (2021).
#'   *Ruby CFF Library (Version 0.9.0)* (Computer software).
#'   \doi{10.5281/zenodo.1184077}.
#'
#' @family bibtex
#' @export
#' @examples
#' \donttest{
#'
#' # From a cff object
#' package <- cff_create("rmarkdown")
#'
#' obj <- cff_to_bibtex(package)
#'
#' obj
#'
#' toBibtex(obj)
#' }
cff_to_bibtex <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }

  stopifnotcff(x)

  # Read cff of CITATION.cff file
  if (!is.cff(x)) {
    x <- cff(x)
  }


  # Try to generate preferred if not present
  if (!("preferred-citation" %in% names(x))) {
    origtype <- clean_str(x$type)

    if (is.null(origtype)) {
      x$type <- "misc"
    }
  } else {
    x <- x$`preferred-citation`
  }

  # Partially based on ruby parser
  # https://github.com/citation-file-format/ruby-cff/blob/main/lib/cff/formatter/bibtex_formatter.rb

  # Create a initial empty list

  tobibentry <- list()

  # No mapping needed (direct mapping) ----
  # edition institution journal month number pages publisher title volume year

  # Guess type of entry----
  tobibentry$bibtype <- switch(tolower(x$type),
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
  # Try guess thesis
  ttype <- clean_str(gsub("[[:punct:]]", "",
    x$`thesis-type`,
    perl = TRUE
  ))

  if (!is.null(ttype) & x$type == "thesis") {
    if (grepl("Phd", ttype, ignore.case = TRUE)) {
      tobibentry$bibtype <- "phdthesis"
    }
  }

  # Check if it may be an incollection
  # Hint: is misc with collection-title and publisher

  if (tobibentry$bibtype == "misc" & !is.null(x$`collection-title`) &
    !is.null(x$publisher)) {
    tobibentry$bibtype <- "incollection"
  }


  # address----
  # BibTeX 'address' is taken from the publisher (book, others) or the
  # conference (inproceedings).

  if (tobibentry$bibtype %in% c("proceedings", "inproceedings")) {
    addr_search <- x$conference
  } else if (tobibentry$bibtype == "techreport") {
    addr_search <- x$institution
  } else {
    addr_search <- x$publisher
  }


  tobibentry$address <- clean_str(paste(
    c(
      addr_search$address,
      addr_search$city,
      addr_search$region,
      addr_search$country
    ),
    collapse = ", "
  ))

  # As a fallback, use also location
  if (is.null(tobibentry$address) &
    !is.null(x$location)) {
    tobibentry$address <- x$location$name
  }



  # author----
  aut <- x$authors

  author <- lapply(aut, function(y) {
    if ("name" %in% names(y)) {
      # Person protected on family
      person(family = clean_str(y$name))
    } else {
      person(
        given = clean_str(y$`given-names`),
        family = clean_str(paste(
          clean_str(y$`name-particle`),
          clean_str(y$`family-names`),
          clean_str(y$`name-suffix`)
        ))
      )
    }
  })
  tobibentry$author <- do.call(c, author)


  # booktitle ----

  # Only for incollections and inproceedings
  if (tobibentry$bibtype %in% c("incollection", "inproceedings")) {
    tobibentry$booktitle <- x[["collection-title"]]
  }

  # Fallback to conference name

  if (tobibentry$bibtype == "inproceedings" & is.null(tobibentry$booktitle)) {
    tobibentry$booktitle <- x$conference$name
  }

  # chapter----
  tobibentry$chapter <- x$section

  # edition----
  tobibentry$edition <- x$edition

  # editor----
  # Same case than authors
  editors <- x["editors"][[1]]

  if (!is.null(editors)) {
    # Same
    editor <- lapply(editors, function(y) {
      if (!is.null(y$name)) {
        # Person protected on family
        person(family = clean_str(y$name))
      } else {
        person(
          given = clean_str(y$`given-names`),
          family = clean_str(paste(
            clean_str(y$`name-particle`),
            clean_str(y$`family-names`),
            clean_str(y$`name-suffix`)
          ))
        )
      }
    })
    tobibentry$editor <- do.call(c, editor)
  }

  # howpublished----

  howpublished <- x$medium

  if (!is.null(howpublished)) {
    # Capitalize first letter
    letts <- unlist(strsplit(howpublished, "|"))
    howpublished <-
      clean_str(paste0(c(toupper(letts[1]), letts[-1]), collapse = ""))

    tobibentry$howpublished <- howpublished
  }

  # institution/organization ----

  # For inproceedings, proceedings and manual this field
  # is organization

  if (tobibentry$bibtype %in% c(
    "inproceedings", "proceedings",
    "manual"
  )) {
    tobibentry$organization <- x$institution$name
  } else {
    tobibentry$institution <- x$institution$name
  }


  # Fallback for techreport, search on affiliation first author
  if (tobibentry$bibtype == "techreport" & is.null(tobibentry$institution)) {
    tobibentry$institution <- x$authors[[1]]$affiliation
  }

  # journal----
  tobibentry$journal <- x$journal

  # key First two given of author and year----



  aut_sur <- lapply(tobibentry$author$family[1:2], clean_str)
  aut_sur <- tolower(paste0(unlist(aut_sur), collapse = ""))
  aut_sur <- gsub("\\s*", "", aut_sur)

  # Clean not common chars
  aut_sur <- gsub("[^_a-z]", "?", aut_sur)

  y <- x$year

  tobibentry$key <- paste(c(aut_sur, y), collapse = ":")

  # month----
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
    tobibentry$month <- m_letters
  } else {
    tobibentry$month <- clean_str(m)
  }



  # note ----
  tobibentry$note <- x$notes

  # number----


  tobibentry$number <- x[["issue"]]

  # pages ----

  p <- unique(c(x$start, x$end))

  if (!is.null(p)) tobibentry$pages <- paste(p, collapse = "--")

  # publisher ----
  tobibentry$publisher <- x$publisher$name

  # school ----
  # In thesis
  if (x$type == "thesis") {
    tobibentry$school <- tobibentry$institution
    tobibentry$institution <- NULL
  }


  # series----
  if (tobibentry$bibtype %in% c(
    "book", "inbook"
  )) {
    tobibentry$series <- x$`collection-title`
  }

  if (tobibentry$bibtype %in% c(
    "proceedings", "inproceedings"
  )) {
    tobibentry$series <- x$conference$name
  }

  # title ----

  tobibentry$title <- x$title

  # volume----
  tobibentry$volume <- x$volume

  # year ----

  tobibentry$year <- x$year

  # Fallback

  if (is.null(tobibentry$year) && !is.null(x$`date-released`)) {
    # Should be YYYY-MM-DD to be valid on cff, so

    tobibentry$year <- substr(x$`date-released`, 1, 4)
  }

  # Keywords
  if (!is.null(x$keywords)) {
    tobibentry$keywords <- paste(x$keywords, collapse = ", ")
  }

  # Guess inbook ----
  # inbook is a book where chapter or pages are present

  if (tobibentry$bibtype == "book" & !is.null(
    c(tobibentry$chapter, tobibentry$pages)
  )) {
    tobibentry$bibtype <- "inbook"
  }

  # Handle anonymous author----
  # If anonymous and not needed, then not use it


  if (!is.null(x$authors[[1]]$name)) {
    if (x$authors[[1]]$name == "anonymous" &
      tobibentry$bibtype %in% c(
        "booklet", "manual", "book", "inbook",
        "misc", "proceedings"
      )) {
      tobibentry$author <- NULL
    }
  }

  # Add other interesting fields for BibLateX ----

  tobibentry$abstract <- x$abstract
  tobibentry$doi <- x$doi
  tobibentry$date <- x$`date-published`
  tobibentry$file <- x$filename
  tobibentry$issuetitle <- x$`issue-title`
  tobibentry$isbn <- x$isbn
  tobibentry$issn <- x$issn
  tobibentry$pagetotal <- x$pages
  tobibentry$url <- x$url
  tobibentry$urldate <- x$`date-accessed`
  tobibentry$version <- x$version
  # Translators
  trns <- x$translators

  trnsbib <- lapply(trns, function(y) {
    if ("name" %in% names(y)) {
      # Person protected on family
      paste0("{", clean_str(y$name), "}")
    } else {
      fam <- clean_str(paste(
        clean_str(y$`name-particle`),
        clean_str(y$`family-names`)
      ))
      jr <- clean_str(y$`name-suffix`)

      given <- clean_str(y$`given-names`)

      paste(c(fam, jr, given), collapse = ", ")
    }
  })

  tobibentry$translator <- paste(unlist(trnsbib), collapse = " and ")





  # sort ----
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


  bib <- do.call(bibentry, tobibentry)

  return(bib)
}
