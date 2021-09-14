#' Parse a `bibentry` to `cff`
#'
#' Parse a `bibentry` object to a valid format for a `CITATION.cff` file.
#'
#' @seealso [cff_create()]
#'
#' @export
#'
#' @family parsers
#'
#' @param bib A `bibentry` object, either created with [utils::citation()] or
#' with [utils::bibentry()].
#'
#' @return A [`cff`] object ready to be used on [cff_create()].
#'
#' @details
#' This is a helper function designed to help on adding or
#' replacing the auto-generated authors of the package. See **Examples**.
#'
#' @examples
#'
#' bib <- citation("base")
#' bib
#'
#' # To cff
#' bib_to_cff <- cff_parse_citation(bib)
#' bib_to_cff
#'
#' # Create the object
#' new_cff <- cff()
#'
#' full <- cff_create(new_cff, keys = list("preferred-citation" = bib_to_cff))
#'
#' full
#' # Validate
#' cff_validate(full)
cff_parse_citation <- function(bib) {
  if (!inherits(bib, "bibentry")) {
    return(NULL)
  }

  if (is.null(bib)) {
    return(NULL)
  }


  parse_cit <- drop_null(unclass(bib)[[1]])

  # Keys needed
  if (isFALSE("author" %in% names(parse_cit))) {
    return(NULL)
  }

  if (isFALSE("title" %in% names(parse_cit))) {
    return(NULL)
  }

  # rest to lowercase
  names(parse_cit) <- tolower(names(parse_cit))

  # rename authors
  nm <- names(parse_cit)
  nm[nm == "author"] <- "authors"
  names(parse_cit) <- nm


  # Handle type ----

  # Important! This is a mandatory key in CFF
  # Help needed
  # We map here the types explained in ?bibentry
  # to valid keys. see  https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsreferencetype
  # In lower case to avoid mismatches


  type <- clean_str(tolower(attr(unclass(bib)[[1]], "bibtype")))
  # Remove just in case
  parse_cit <- parse_cit[names(parse_cit) != "type"]
  ### Switch type based on bibentry----
  if (is.null(type)) {
    return(NULL)
  }

  type <- switch(type,
    "article" = "article",
    "book" = "book",
    "inbook" = "book",
    # "incollection"=,
    "inproceedings" = "proceedings",
    "manual" = "manual",
    "mastersthesis" = "thesis",
    "phdthesis" = "thesis",
    "proceedings" = "proceedings",
    "techreport" = "report",
    "unpublished" = "unpublished",
    "generic"
  )

  parse_cit <- c(parse_cit, type = type)

  # Building blocks----

  valid <- cff_schema_definitions_reference()

  # Keep only valid keys
  parse_cit <- parse_cit[names(parse_cit) %in%
    valid]

  # We would use it at the end
  ordernames <- unique(c("type", "title", "authors", names(parse_cit)))

  # Clean strings that are not authors or other persons
  cleaned <- lapply(
    parse_cit[!names(parse_cit) %in% c(
      "authors",
      other_persons()
    )],
    clean_str
  )

  # Append
  parse_cit <- append(
    parse_cit[names(parse_cit) %in% c(
      "authors",
      other_persons()
    )],
    cleaned
  )
  parse_cit$authors <- parse_cit$authors


  ## Parse authors----
  ## On CFF reference max authors seems to be 10
  ## See bug with urltools
  parse_cit$authors <- drop_null(
    lapply(parse_cit$authors[1:10], cff_parse_person)
  )

  ## DOIs----
  bb_doi <- building_doi(parse_cit)
  parse_cit$doi <- bb_doi$doi
  # Create identifiers
  parse_cit <- parse_cit[names(parse_cit) != "identifiers"]
  parse_cit <- c(parse_cit, identifiers = list(bb_doi$identifiers))

  ## Month

  parse_cit$month <- building_month(parse_cit)
  bb_url <- building_url(parse_cit)

  parse_cit$url <- bb_url$url

  # Create identifiers if not already there
  if (!"identifiers" %in% names(parse_cit)) {
    parse_cit <- c(parse_cit, identifiers = list(bb_url$identifiers))
  } else {
    parse_cit$identifiers <- c(parse_cit$identifiers, bb_url$identifiers)
  }

  # Keywords
  if ("keywords" %in% names(parse_cit)) {
    newkeys <- unique(unlist(strsplit(parse_cit$keywords, ", ")))
    parse_cit$keywords <- newkeys
  }

  #  Other persons

  bb_other <- building_other_persons(parse_cit)

  newlist <- append(
    parse_cit[!names(parse_cit) %in% other_persons()],
    bb_other
  )

  # Reorder
  newlist <- newlist[unique(c(ordernames, "identifiers"))]
  newlist <- as.cff(newlist)

  newlist
}
