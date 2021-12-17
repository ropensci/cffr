#' Create a BibTeX entry from a CITATION file or a `cff` object
#'
#' Creates a `bibentry` object ([bibeentry()]) from a `cff` object
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
#' - Patashnik, O. (1988, February). *BIBTEXTING*. BibTeX - Process
#'   Bibliographies for LATEX, Etc. Retrieved December 1, 2021, from
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>
#'
#' - Haines, R., & The Ruby Citation File Format Developers. (2021).
#'   *Ruby CFF Library (Version 0.9.0)* (Computer software).
#'   \doi{10.5281/zenodo.1184077}.
#'
#' @family bibtex
#' @export
#' @examples
#'
#' # From a cff object
#' package <- cff_create("rmarkdown")
#'
#' obj <- cff_to_bibtex(package)
#'
#' obj
#'
#' toBibtex(obj)
#'
#' # References
#' l <- lapply(package$references, cff_to_bibtex)
#'
#' # Flatten
#' l <- do.call(c, l)
#'
#' l
#'
#' toBibtex(l)
cff_to_bibtex <- function(x) {
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
    "conference" = "proceedings",
    "proceedings" = "proceedings",
    "conference-paper" = "inproceedings",
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

  # address----
  # BibTeX 'address' is taken from the publisher (book, others) or the
  # conference (inproceedings).

  if (tobibentry$bibtype %in% c("proceedings", "inproceedings")) {
    addr_search <- x$conference
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


  # author----
  aut <- x$authors
  author <- lapply(aut, function(y) {
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
  tobibentry$author <- do.call(c, author)


  # booktitle ----

  # Only for incollections and inproceedings
  if (tobibentry$bibtype == "incollection") {
    tobibentry$booktitle <- x$`collection-title`
  } else if (tobibentry$bibtype == "inproceedings") {
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

  # journal----
  tobibentry$journal <- x$journal

  # key: First two given of author and year----

  aut_sur <- lapply(tobibentry$author$family[1:2], clean_str)
  aut_sur <- tolower(paste0(unlist(aut_sur), collapse = ""))
  aut_sur <- gsub("\\s*", "", aut_sur)

  # Clean not common chars
  aut_sur <- gsub("[^_a-z]", "?", aut_sur)

  y <- x$year

  tobibentry$key <- paste(c(aut_sur, y), collapse = ":")

  # month----
  m <- x$month

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
  tobibentry$number <- x$number

  # pages ----

  tobibentry$pages <- x$pages


  # publisher ----
  tobibentry$publisher <- x$publisher$name

  # school ----
  tobibentry$school <- x$department

  # series----
  if (tobibentry$bibtype %in% c(
    "book", "inbook",
    "proceedings"
  )) {
    tobibentry$series <- x$`collection-title`
  }

  # title ----

  tobibentry$title <- x$title

  # volume----
  tobibentry$volume <- x$volume

  # year

  tobibentry$year <- x$year

  # Keywords
  if (!is.null(x$keywords)) {
    tobibentry$keywords <- paste(x$keywords, collapse = ", ")
  }


  # Add other interesting fields

  tobibentry$doi <- x$doi
  tobibentry$date <- x$`date-published`
  tobibentry$isbn <- x$isbn
  tobibentry$issn <- x$issn
  tobibentry$license <- x$license
  tobibentry$url <- x$url

  bib <- do.call(bibentry, tobibentry)

  return(bib)
}
