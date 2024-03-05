#' Internal functions for `as_cff.bibentry` method
#'
#' @noRd
as_cff_reference <- function(x) {
  # Need always to be unnamed bibentry
  bib <- unname(x)


  # Return always a list
  the_list <- lapply(bib, make_cff_reference)
  the_list
}

make_cff_reference <- function(bib) {
  # Parse BibTeX entry ----
  parse_cit <- parse_bibtex_entry(bib)

  ## If no title (case of some Misc) then return null
  if (!("title" %in% names(parse_cit))) {
    entry <- capture.output(print(bib, bibtex = FALSE))
    entry <- as.character(entry)

    cli::cli_alert_warning("Entry {.val {entry}} without title. Skipping")

    return(NULL)
  }

  # Parse BibTeX fields ----
  parsed_fields <- parse_bibtex_fields(parse_cit)
  # VGAM: title is a vector
  parsed_fields$title <- clean_str(parsed_fields$title)

  ## Handle collection types ----
  parsed_fields <- add_bibtex_coltype(parsed_fields)

  ## Add conference
  parsed_fields <- add_conference(parsed_fields)

  # Create BibTeX to CFF institution logic ----
  parsed_fields <- parse_bibtex_to_inst(parsed_fields)

  # Parse persons ----
  # Special case: authors
  # Some keys does not strictly require authors, so we create one for cff
  # https://github.com/citation-file-format/citation-file-format/blob/main/
  # (cont) schema-guide.md#how-to-deal-with-unknown-individual-authors

  if (is.null(parsed_fields$authors)) {
    parsed_fields$authors <- person(family = "anonymous")
  }

  ## authors ----
  parse_all_authors <- as_cff_person(parsed_fields$authors)
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

  # Fallback for year and month: use date-published ----
  parse_cit <- fallback_dates(parse_cit)

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

  ## Add thesis type ----
  parse_cit <- add_thesis(parse_cit)

  ## Handle location ----
  parse_cit <- add_address(parse_cit)


  # Last step----

  # Initial order but starting with type, title, authors
  final_order <- unique(
    c("type", "title", "authors", init_ord, names(parse_cit))
  )

  parse_cit <- parse_cit[final_order]

  # Remove non-valid names
  validnames <- cff_schema_definitions_refs()
  parse_cit <- parse_cit[names(parse_cit) %in% validnames]

  parse_cit <- drop_null(parse_cit)

  return(parse_cit)
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


  # Check if it an inbook with booktitle (BibLaTeX style)
  if (all(init_type == "inbook", "booktitle" %in% names(parse_cit))) {
    # Make it incollection
    parse_cit$bibtex_entry <- "incollection"
    parse_cit$type <- "generic"
  }


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
  # author booktitle series chapter editor howpublished note number

  nm[nm == "author"] <- "authors"
  # Make collection title
  # booktitle takes precedence over series
  nm[nm == "booktitle"] <- "collection-title"
  if (!"collection-title" %in% nm) {
    nm[nm == "series"] <- "collection-title"
  }
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
  # Fields address, organization, series and type are treated on
  # main function
  # key is a special field, treated apart
  # Fields ignored: annote, crossref

  names(parse_cit) <- nm

  # Additionally, need to delete keywords if length is less than 2,
  # errors on validation
  if (length(parse_cit$keywords) < 2) {
    parse_cit$keywords <- NULL
  }

  # Treat location ----

  loc <- parse_cit$location

  if (!is.null(loc)) parse_cit$location <- loc



  # Treat additional dates ----
  dpub <- clean_str(parse_cit$`date-published`)
  parse_cit$`date-published` <- clean_str(as.Date(dpub, optional = TRUE))

  datacc <- clean_str(parse_cit$`date-accessed`)
  parse_cit$`date-accessed` <- clean_str(as.Date(datacc, optional = TRUE))

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
parse_bibtex_to_inst <- function(parsed_fields) {
  # Initial values
  bibtex_entry <- parsed_fields$bibtex_entry
  to_replace <- switch(bibtex_entry,
    "mastersthesis" = "school",
    "phdthesis" = "school",
    "conference" = "organization",
    "inproceedings" = "organization",
    "manual" = "organization",
    "proceedings" = "organization",
    "institution"
  )

  if (to_replace == "institution") {
    return(parsed_fields)
  }

  # Rest of cases remove bibtex institution and rename
  nms <- names(parsed_fields)

  parsed_fields <- parsed_fields["institution" != nms]

  # Rename
  nms2 <- names(parsed_fields)
  nms2[nms2 == to_replace] <- "institution"
  names(parsed_fields) <- nms2

  parsed_fields
}

add_conference <- function(parsed_fields) {
  bibtex_entry <- parsed_fields$bibtex_entry

  if (bibtex_entry %in% c("conference", "inproceedings", "proceedings")) {
    parsed_fields$conference <- parsed_fields$`collection-title`
  }
  return(parsed_fields)
}




#' Adapt cff keys to bibtex entries
#' @noRd
add_thesis <- function(parse_cit) {
  bibtex_entry <- parse_cit$bibtex_entry
  if (!bibtex_entry %in% c("phdthesis", "mastersthesis")) {
    return(parse_cit)
  }

  parse_cit$`thesis-type` <- switch(bibtex_entry,
    phdthesis = "PhD Thesis",
    "Master's Thesis"
  )

  parse_cit
}

add_address <- function(parse_cit) {
  loc <- parse_cit$location$name
  # If available
  if (is.null(loc)) {
    return(parse_cit)
  }

  # At this point is in location, see to move

  # Logic order.
  # 1. To conference
  # 2. To institution
  # 3. To publisher
  # Otherwise leave on location

  nms <- names(parse_cit)
  has_conf <- "conference" %in% nms
  has_inst <- "institution" %in% nms
  has_publish <- "publisher" %in% nms

  if (!any(has_conf, has_inst, has_publish)) {
    return(parse_cit)
  }

  if (has_conf) {
    parse_cit$conference$address <- loc
    parse_cit$location <- NULL
  } else if (has_inst) {
    parse_cit$institution$address <- loc
    parse_cit$location <- NULL
  } else {
    parse_cit$publisher$address <- loc
    parse_cit$location <- NULL
  }

  return(parse_cit)
}

add_bibtex_coltype <- function(parsed_fields) {
  # Add collection-type if applicable and rearrange fields
  nms <- names(parsed_fields)

  if (!"collection-title" %in% nms) {
    return(parsed_fields)
  }

  # Made collection-type if we create collection-title
  bibtex_type <- parsed_fields$bibtex_entry

  # Remove `in` at init: inbook, incollection affected
  coltype <- clean_str(gsub("^in", "", bibtex_type))
  parsed_fields$`collection-type` <- coltype

  # Rearrange to make both collection keys together
  nm_first <- nms[seq(1, match("collection-title", nms))]

  nms_end <- unique(c(nm_first, "collection-type", nms))

  parsed_fields <- parsed_fields[nms_end]

  return(parsed_fields)
}

fallback_dates <- function(parse_cit) {
  # Fallback for year and month: use date-published
  if (is.null(parse_cit$month) && !is.null(parse_cit$`date-published`)) {
    parse_cit$month <- format(as.Date(parse_cit$`date-published`), "%m")
  }

  if (is.null(parse_cit$year) && !is.null(parse_cit$`date-published`)) {
    parse_cit$year <- format(as.Date(parse_cit$`date-published`), "%Y")
  }

  ## month ----
  parse_cit$month <- building_month(parse_cit)

  return(parse_cit)
}
