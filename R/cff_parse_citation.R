#' Parse a `bibentry` to `cff`
#'
#' Parse a `bibentry` object to a valid format for a `CITATION.cff` file.
#'
#' @seealso [cff_create()], `vignette("bibtex_cff", "cffr")`, [bibentry()]
#'
#' @export
#'
#' @family parsers
#'
#' @param bib A `bibentry` object, either created with [bibentry()]
#'   (preferred) or [citEntry()].
#'
#' @return A [`cff`] object ready to be used on [cff_create()].
#'
#' @details
#' This is a helper function designed to help on adding or
#' replacing the auto-generated authors of the package. See **Examples**.
#'
#' This function tries to adapt a `bibentry` object (generated with [bibentry()]
#' or [citEntry()]) to the CFF standard.
#'
#' ## Entry types considered
#'
#' - **Article**, **Book**, **Booklet**, **InBook**, **InCollection**,
#'   **InProceedings**, **Manual**, **MastersThesis**, **Misc**, **PhDThesis**,
#'   **Proceedings**, **TechReport**, **Unpublished**. See [bibentry()]
#'   for more information.
#'
#'  Note that **Conference** is not implemented in
#'  [bibentry()], however is equivalent to **InProceedings** (Patashnik (1988)).
#'
#' ## Fields considered
#'
#' - **address**, **author**, **booktitle**, **chapter**, **edition**,
#'   **editor**, **howpublished**, **institution**,  **journal**, **key**,
#'   **month**, **note**, **number**, **organization**, **pages**,
#'   **publisher**, **school**, **series**, **title**, **type**, **year**.
#'
#'  **annote** and **crossref** fields are ignored.
#'
#'
#' @references
#' - Patashnik, Oren. "BIBTEXTING" February 1988.
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' - Haines, R., & The Ruby Citation File Format Developers. (2021).
#'   *Ruby CFF Library (Version 0.9.0)* (Computer software).
#'   \doi{10.5281/zenodo.1184077}.
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

  ## Unname
  bib <- unname(bib)

  if (length(bib) > 1) {
    bib <- lapply(bib, cff_parse_citation)
    class(bib) <- "cff"
    return(bib)
  }

  # Parse BibTeX entry ----

  parse_cit <- parse_bibtex_entry(bib)

  ## If no title (case of some Misc) then return null

  if (!("title" %in% names(parse_cit))) {
    entry <- capture.output(print(bib, bibtex = FALSE))

    message(
      "Skipping entry without title:\n\t",
      entry
    )

    return(NULL)
  }


  # Parse BibTeX fields ----
  parsed_fields <- parse_bibtex_fields(parse_cit)


  # Create BibTeX person models ----
  parsed_fields <- parse_bibtex_person_models(parsed_fields)
  # Parse persons ----
  # Special case: authors
  # Some keys does not strictly require authors, so we create one for cff
  # https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#how-to-deal-with-unknown-individual-authors
  if (is.null(parsed_fields$authors)) {
    parsed_fields$authors <- person(family = "anonymous")
  }


  ## authors ----
  parse_all_authors <- drop_null(
    lapply(parsed_fields$authors, cff_parse_person)
  )
  parsed_fields$authors <- unique(parse_all_authors)


  ## other persons----
  parse_other_persons <- building_other_persons(parsed_fields)

  # Keep order here, we would use it later
  init_ord <- names(parsed_fields)

  parse_cit <- c(
    parsed_fields[!names(parsed_fields) %in% names(parse_other_persons)],
    parse_other_persons
  )

  # Building blocks----

  # Fallback for year and month: use date-published

  if (is.null(parse_cit$month) && !is.null(parse_cit$`date-published`)) {
    parse_cit$month <- format(as.Date(parse_cit$`date-published`), "%m")
  }


  if (is.null(parse_cit$year) && !is.null(parse_cit$`date-published`)) {
    parse_cit$year <- format(as.Date(parse_cit$`date-published`), "%Y")
  }

  ## month ----
  parse_cit$month <- building_month(parse_cit)

  ## doi----
  bb_doi <- building_doi(parse_cit)
  parse_cit$doi <- bb_doi$doi

  ### identifiers ----
  if (!is.null(bb_doi$identifiers)) parse_cit$identifiers <- bb_doi$identifiers


  ## url----
  bb_url <- building_url(parse_cit)
  parse_cit$url <- bb_url$url

  ### final identifiers----
  # Identifies (additional dois and urls)
  if (!is.null(bb_url$identifiers)) {
    parse_cit$identifiers <- append(
      parse_cit$identifiers,
      bb_url$identifiers
    )
  }


  # Last step: Field models----

  # Initial order but starting with type, title, authors
  final_order <- unique(c(
    "type", "title", "authors",
    init_ord,
    names(parse_cit)
  ))

  parse_cit <- parse_cit[final_order]

  parse_cit <- parse_bibtex_fields_models(parse_cit)


  # Remove non-valid names
  validnames <- cff_schema_definitions_refs()
  parse_cit <- parse_cit[names(parse_cit) %in%
    c(validnames)]

  parse_cit <- drop_null(parse_cit)
  parse_cit_result <- as.cff(parse_cit)

  return(parse_cit_result)
}

#' Extract and map BibTeX entry
#' @noRd
parse_bibtex_entry <- function(bib) {
  # Unclass and manage entry type
  # Extract type from BibTeX
  init_type <- attr(unclass(bib)[[1]], "bibtype")
  init_type <- clean_str(tolower(init_type))


  parse_cit <- drop_null(unclass(bib)[[1]])

  # Add fields
  parse_cit$bibtex_entry <- init_type

  # Manage type from BibTeX and convert to CFF
  # This overwrite the BibTeX type field. Not parsed by this function
  parse_cit$type <- switch(init_type,
    "article" = "article",
    "book" = "book",
    "booklet" = "pamphlet",
    "conference" = "conference-paper",
    "inbook" = "book",
    # "incollection" = ,
    "inproceedings" = "conference-paper",
    "manual" = "manual",
    "mastersthesis" = "thesis",
    "misc" = "generic",
    "phdthesis" = "thesis",
    "proceedings" = "proceedings",
    "techreport" = "report",
    "unpublished" = "unpublished",
    "generic"
  )


  return(parse_cit)
}

#' Adapt names from R citation()/BibTeX to cff format
#' @noRd
parse_bibtex_fields <- function(parse_cit) {
  # to lowercase
  names(parse_cit) <- tolower(names(parse_cit))

  nm <- names(parse_cit)
  # Standard BibTeX fields:
  # address annote author booktitle chapter crossref edition editor
  # howpublished institution journal key month note number organization pages
  # publisher school series title type year

  # No mapping needed (direct mapping)
  # edition journal month publisher title volume year

  # Mapped:
  # author booktitle chapter editor howpublished note number

  nm[nm == "author"] <- "authors"
  nm[nm == "booktitle"] <- "collection-title"
  nm[nm == "chapter"] <- "section"
  nm[nm == "editor"] <- "editors"
  nm[nm == "howpublished"] <- "medium"
  nm[nm == "note"] <- "notes"
  nm[nm == "number"] <- "issue"
  nm[nm == "address"] <- "location"
  nm[nm == "pages"] <- "bibtex_pages" # This would be removed later

  # Parse some fields from BibLaTeX
  nm[nm == "date"] <- "date-published"
  nm[nm == "file"] <- "filename"
  nm[nm == "issuetitle"] <- "issue-title"
  nm[nm == "translator"] <- "translators"
  nm[nm == "urldate"] <- "date-accessed"
  nm[nm == "pagetotal"] <- "pages"

  # Other BibLaTeX fields that does not require any mapping
  # abstract, doi, isbn, issn, url, version


  cff_schema_definitions_refs()

  # Keywords may be duplicated, unify
  if ("keywords" %in% nm) {
    kwords <- unlist(parse_cit["keywords" == nm])
    kwords <- clean_str(paste(kwords, collapse = ", "))
    kwords <- trimws(unique(unlist(strsplit(kwords, ",|;"))))
    parse_cit$keywords <- unique(kwords)
  }


  # Not mapped:
  # annote crossref key organization series type
  #
  # Fields address, organization, series and type already treated on
  # parse_bibtex_for_cff()/main function
  # key is a special field, treated apart
  # Fields ignored: annote, crossref

  names(parse_cit) <- nm

  # Remove all instances of keywords except the first one
  index <- which(nm == "keywords")
  if (length(index) > 1) parse_cit <- parse_cit[-index[-1]]

  # Additionally, need to delete keywords if length is less than 2,
  # errors on validation
  if (length(parse_cit$keywords) < 2) {
    parse_cit$keywords <- NULL
  }

  # Treat location ----

  loc <- parse_cit$location

  if (!is.null(loc)) parse_cit$location <- person(family = loc)



  # Treat dates----
  datpub <- parse_cit$`date-published`


  if (!is.null(datpub)) {
    datepub <- as.Date(as.character(datpub), optional = TRUE)
    if (is.na(datepub)) {
      parse_cit$`date-published` <- NULL
    } else {
      parse_cit$`date-published` <- as.character(datepub)
    }
  }

  datacc <- parse_cit$`date-accessed`


  if (!is.null(datacc)) {
    datacc <- as.Date(as.character(datacc), optional = TRUE)
    if (is.na(datacc)) {
      parse_cit$`date-accessed` <- NULL
    } else {
      parse_cit$`date-accessed` <- as.character(datacc)
    }
  }

  # Treat pages

  pages <- parse_cit$bibtex_pages
  if (!is.null(pages)) {
    spl <- unlist(strsplit(pages, "--"))

    parse_cit$start <- spl[1]

    if (length(spl) > 1) parse_cit$end <- paste(spl[-1], collapse = "--")
  }

  return(parse_cit)
}

#' Modify mapping of some org. fields on BibTeX to CFF
#' @noRd
parse_bibtex_person_models <- function(parsed_fields) {

  # Manual
  if (parsed_fields$bibtex_entry == "manual") {
    parsed_fields$institution <- parsed_fields$organization
  } else if (parsed_fields$bibtex_entry %in% c(
    "conference", "inproceedings",
    "proceedings"
  )) {
    # Conference, InProceedings, Proceedings
    if (!is.null(parsed_fields$series)) {
      parsed_fields$conference <- person(family = parsed_fields$series)
    }
    if (!is.null(parsed_fields$organization)) {
      parsed_fields$institution <- person(family = parsed_fields$organization)
    }
  } else if (parsed_fields$bibtex_entry %in% c("mastersthesis", "phdthesis")) {
    # Mastersthesis, PhdThesis
    parsed_fields$institution <- person(family = parsed_fields$school)
  }

  return(parsed_fields)
}


#' Adapt cff keys to bibtex entries
#' @noRd
parse_bibtex_fields_models <- function(parse_cit) {


  # thesis type ----
  if (parse_cit$bibtex_entry %in% c("phdthesis", "mastersthesis")) {
    parse_cit$`thesis-type` <- switch(parse_cit$bibtex_entry,
      phdthesis = "PhD Thesis",
      "Master's Thesis"
    )
  }

  # address----

  if (!is.null(parse_cit$location)) {

    # Usually the address of the publisher as per BibTeX
    if (!is.null(parse_cit$publisher) &&
      !(parse_cit$bibtex_entry %in% c(
        "conference", "inproceedings",
        "proceedings"
      ))) {
      parse_cit$publisher$address <- parse_cit$location$name
      parse_cit$location <- NULL
    }

    parse_cit$conference

    # If this is a conference then add to conference
    if (!is.null(parse_cit$conference)) {
      parse_cit$conference$address <- parse_cit$location$name
    }

    # If is a report or a thesis, add to institution
    if (parse_cit$bibtex_entry %in% c(
      "techreport",
      "phdthesis", "mastersthesis"
    ) &&
      !is.null(parse_cit$institution)) {
      parse_cit$institution$address <- parse_cit$location$name
      parse_cit$location <- NULL
    }
  }
  # Book, InBook: collection-title. Use series field

  if (parse_cit$bibtex_entry %in% c("book", "inbook")) {
    parse_cit$`collection-title` <- clean_str(parse_cit$series)
  }

  return(parse_cit)
}
