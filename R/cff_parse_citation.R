#' Parse a `bibentry` to `cff`
#'
#' Parse a `bibentry` object to a valid format for a `CITATION.cff` file.
#'
#' @seealso [cff_create()], `vignette("cffr", "cffr")`, [utils::bibentry()]
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
#' \donttest{
#' bib <- citation("base")
#' bib
#'
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
#'
#' # Several citations
#'
#' cff_parse_citation(citation("rmarkdown"))
#' }
cff_parse_citation <- function(bib) {
  if (!inherits(bib, "bibentry")) {
    return(NULL)
  }

  if (length(bib) > 1) {
    bib <- lapply(bib, cff_parse_citation)
    class(bib) <- "cff"
    return(bib)
  }

  parse_cit <- drop_null(unclass(bib)[[1]])


  # to lowercase
  names(parse_cit) <- tolower(names(parse_cit))

  # rename authors
  nm <- names(parse_cit)
  nm[nm == "author"] <- "authors"
  names(parse_cit) <- nm


  # Handle type ----

  # Important! This is a mandatory key in CFF
  # Help needed
  # We map here the types explained in ?bibentry
  # to valid keys.
  # In lower case to avoid mismatches


  type <- clean_str(tolower(attr(unclass(bib)[[1]], "bibtype")))

  type <- switch(type,
    "article" = "article",
    "book" = "book",
    "inbook" = "book",
    # "incollection"=,
    "inproceedings" = "proceedings",
    "manual" = "manual",
    "mastersthesis" = "thesis",
    "misc" = "generic",
    "phdthesis" = "thesis",
    "proceedings" = "proceedings",
    "techreport" = "report",
    "unpublished" = "unpublished",
    "generic"
  )

  parse_cit$type <- type

  # Building blocks----

  valid <- cff_schema_definitions_refs()

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


  ## Parse authors----
  ## On CFF reference max authors seems to be 10
  ## Bug with urltools
  parse_all_authors <- drop_null(
    lapply(parse_cit$authors, cff_parse_person)
  )

  parse_cit$authors <- unique(parse_all_authors)

  ## DOIs----
  bb_doi <- building_doi(parse_cit)
  parse_cit$doi <- bb_doi$doi
  # Create identifiers
  if (!is.null(bb_doi$identifiers)) parse_cit$identifiers <- bb_doi$identifiers


  ## Month

  parse_cit$month <- building_month(parse_cit)
  bb_url <- building_url(parse_cit)

  parse_cit$url <- bb_url$url

  # Append identifiers

  if (!is.null(bb_url$identifiers)) {
    parse_cit$identifiers <- append(
      parse_cit$identifiers,
      bb_url$identifiers
    )
  }



  # Keywords
  if ("keywords" %in% names(parse_cit)) {
    newkeys <- trimws(unique(unlist(strsplit(parse_cit$keywords, ","))))
    parse_cit$keywords <- newkeys
  }

  #  Other persons

  bb_other <- building_other_persons(parse_cit)

  parse_cit_result <- append(
    parse_cit[!names(parse_cit) %in% other_persons()],
    bb_other
  )

  # Reorder
  parse_cit_result <- parse_cit_result[unique(c(ordernames, "identifiers"))]
  parse_cit_result <- as.cff(parse_cit_result)

  parse_cit_result
}
