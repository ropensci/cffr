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

  parse_cit <- as.cff(bib[[1]])[[1]]




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


  type <- clean_str(tolower(attr(parse_cit, "bibtype")))
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
    "masterthesis" = "thesis",
    "phdtesis" = "thesis",
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

  # Clean strings that are not authors
  cleaned <- lapply(parse_cit[names(parse_cit) != "authors"], clean_str)

  # Append and reorder
  cleaned <- c(cleaned, list(authors = parse_cit$authors))
  parse_cit <- cleaned[names(parse_cit)]

  ## Parse authors----
  ## On CFF reference max authors seems to be 10
  ## See bug with urltools
  parse_cit$authors <- drop_null(
    lapply(parse_cit$authors[1:10], cff_parse_person)
  )

  ## DOIs----
  bb_doi <- building_doi(parse_cit)
  parse_cit <- parse_cit[!names(parse_cit) %in% c("doi", "identifiers")]
  parse_cit <- c(parse_cit, bb_doi)


  ## Month

  parse_cit$month <- building_month(parse_cit)

  ## Parse url: see bug with cff_create("rgeos")
  if (is.character(parse_cit$url)) {
    url <- as.character(parse_cit$url)
    url <- unlist(strsplit(url, " "))
    url <- unlist(strsplit(url, ","))
    # Select first element
    url <- url[1]
    parse_cit$url <- url
  }


  # Parse this as entities
  # This is not completely right, however don't know
  # how to make it. Some fields accept person o entity,
  # it is safer to assume entity in all the cases.

  toent <- c(
    "contact",
    "conference",
    "database-provider",
    "editors",
    "editors-series",
    "institution",
    "location",
    "publisher",
    "recipients",
    "senders",
    "translators"
  )

  entities <- parse_cit[names(parse_cit) %in% toent]


  for (i in seq_len(length(entities))) {
    p <- person(given = entities[i])
    p <- cff_parse_person(p)
    entities[i] <- (list(p))
  }

  newlist <- c(
    parse_cit[!names(parse_cit) %in% toent],
    entities
  )

  # Reorder
  newlist <- newlist[names(parse_cit)]
  newlist <- as.cff(newlist)

  newlist
}
