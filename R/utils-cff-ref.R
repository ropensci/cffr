# Utilities for as_cff_reference.

#' Extract and map BibTeX entries
#' @noRd
get_bibtex_entry <- function(bib) {
  # Unclass and manage entry type.
  # Extract type from BibTeX.
  init_type <- attr(unclass(bib)[[1]], "bibtype")
  init_type <- clean_str(tolower(init_type))

  cit_list <- drop_null(unclass(bib)[[1]])

  # Add fields.
  cit_list$bibtex_entry <- init_type

  # Manage type from BibTeX and convert to CFF.
  # This overwrites the BibTeX type field. This function does not handle it.
  cit_list$type <- switch(init_type,
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

  # Check whether this is an inbook with booktitle (BibLaTeX style).
  if (all(init_type == "inbook", "booktitle" %in% names(cit_list))) {
    # Convert it to incollection.
    cit_list$bibtex_entry <- "incollection"
    cit_list$type <- "generic"
  }

  cit_list
}

#' Adapt field names from R citations and BibTeX to CFF
#' @noRd
get_bibtex_fields <- function(cit_list) {
  # Convert to lowercase.
  names(cit_list) <- tolower(names(cit_list))
  nm <- names(cit_list)
  # Standard BibTeX fields:
  # address annote author booktitle chapter crossref edition editor
  # howpublished institution journal key month note number organization pages
  # publisher school series title type year

  # No mapping needed (direct mapping).
  # edition journal month publisher title volume year

  # Mapped fields:
  # author booktitle series chapter editor howpublished note number

  nm[nm == "author"] <- "authors"
  # Create collection-title.
  # booktitle takes precedence over series.
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

  # Get some fields from BibLaTeX
  nm[nm == "date"] <- "date-published"
  nm[nm == "file"] <- "filename"
  nm[nm == "issuetitle"] <- "issue-title"
  nm[nm == "translator"] <- "translators"
  nm[nm == "urldate"] <- "date-accessed"
  nm[nm == "pagetotal"] <- "pages"

  # Other BibLaTeX fields do not require mapping.
  # abstract, doi, isbn, issn, url, version

  # Keywords may be duplicated, so unify them.
  if ("keywords" %in% nm) {
    kwords <- unlist(cit_list["keywords" == nm])
    kwords <- clean_str(paste(kwords, collapse = ", "))
    kwords <- trimws(unique(unlist(strsplit(kwords, ",|;"))))
    cit_list$keywords <- unique(kwords)
  }

  # Not mapped:
  # annote crossref key organization series type
  #
  # Fields address, organization, series and type are handled in the main
  # function.
  # key is a special field, handled separately.
  # Ignored fields: annote, crossref.

  names(cit_list) <- nm

  # Drop keywords when fewer than two values are present to avoid validation
  # errors.
  if (length(cit_list$keywords) < 2) {
    cit_list$keywords <- NULL
  }

  # Treat location ----

  loc <- cit_list$location

  if (!is.null(loc)) {
    cit_list$location <- loc
  }

  # Treat additional dates ----
  dpub <- clean_str(cit_list$`date-published`)
  cit_list$`date-published` <- clean_str(as.Date(dpub, optional = TRUE))

  datacc <- clean_str(cit_list$`date-accessed`)
  cit_list$`date-accessed` <- clean_str(as.Date(datacc, optional = TRUE))

  # Treat pages.

  pages <- cit_list$bibtex_pages
  if (!is.null(pages)) {
    spl <- unlist(strsplit(pages, "--"))

    cit_list$start <- spl[1]

    if (length(spl) > 1) cit_list$end <- paste(spl[-1], collapse = "--")
  }

  cit_list
}

#' Modify mapping of some organization fields from BibTeX to CFF
#' @noRd
get_bibtex_inst <- function(field_list) {
  # Initial values.
  bibtex_entry <- field_list$bibtex_entry
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
    return(field_list)
  }

  # In the remaining cases, remove the BibTeX institution and rename.
  nms <- names(field_list)
  field_list <- field_list["institution" != nms]

  # Rename.
  nms2 <- names(field_list)
  nms2[nms2 == to_replace] <- "institution"
  names(field_list) <- nms2

  field_list
}

add_conference <- function(field_list) {
  bibtex_entry <- field_list$bibtex_entry

  if (bibtex_entry %in% c("conference", "inproceedings", "proceedings")) {
    field_list$conference <- field_list$`collection-title`
  }
  field_list
}

#' Adapt CFF keys to BibTeX entries
#' @noRd
add_thesis <- function(cit_list) {
  bibtex_entry <- cit_list$bibtex_entry
  if (!bibtex_entry %in% c("phdthesis", "mastersthesis")) {
    return(cit_list)
  }

  cit_list$`thesis-type` <- switch(bibtex_entry,
    phdthesis = "PhD Thesis",
    "Master's Thesis"
  )

  cit_list
}

add_address <- function(cit_list) {
  loc <- cit_list$location$name
  # Return early when no location is available.
  if (is.null(loc)) {
    return(cit_list)
  }

  # At this point, the value is in location. Check whether it should move.

  # Logic order.
  # 1. To conference
  # 2. To institution
  # 3. To publisher
  # Otherwise, leave it in location.

  nms <- names(cit_list)
  has_conf <- "conference" %in% nms
  has_inst <- "institution" %in% nms
  has_publish <- "publisher" %in% nms

  if (!any(has_conf, has_inst, has_publish)) {
    return(cit_list)
  }

  if (has_conf) {
    cit_list$conference$address <- loc
    cit_list$location <- NULL
  } else if (has_inst) {
    cit_list$institution$address <- loc
    cit_list$location <- NULL
  } else {
    cit_list$publisher$address <- loc
    cit_list$location <- NULL
  }

  cit_list
}

add_bibtex_coltype <- function(field_list) {
  # Add collection-type if applicable and rearrange fields.
  nms <- names(field_list)

  if (!"collection-title" %in% nms) {
    return(field_list)
  }

  # Create collection-type when collection-title is present.
  bibtex_type <- field_list$bibtex_entry

  # Remove the initial `in` from inbook and incollection.
  coltype <- clean_str(gsub("^in", "", bibtex_type))
  field_list$`collection-type` <- coltype

  # Rearrange fields to keep collection keys together.
  nm_first <- nms[seq(1, match("collection-title", nms))]

  nms_end <- unique(c(nm_first, "collection-type", nms))

  field_list <- field_list[nms_end]

  field_list
}

fallback_dates <- function(cit_list) {
  # Fallback for year and month: use date-published.
  if (is.null(cit_list$month) && !is.null(cit_list$`date-published`)) {
    cit_list$month <- format(as.Date(cit_list$`date-published`), "%m")
  }

  if (is.null(cit_list$year) && !is.null(cit_list$`date-published`)) {
    cit_list$year <- format(as.Date(cit_list$`date-published`), "%Y")
  }

  ## month ----
  cit_list$month <- get_bibtex_month(cit_list)

  cit_list
}

#' Build the DOI field list.
#' @noRd
get_bibtex_doi <- function(cit_list) {
  dois <- unlist(cit_list[names(cit_list) == "doi"])

  # Check URLs as well.
  url_for_doi <- unlist(cit_list$url)
  if (all(!is.null(url_for_doi), grepl("doi.org", url_for_doi))) {
    dois <- c(dois, url_for_doi)
  }

  dois <- unlist(lapply(dois, function(x) {
    x <- gsub("^.*doi.org/", "", x)
    x <- clean_str(x)
  }))

  dois <- unique(as.character(dois))

  cff_identifier_fields(dois, key = "doi", type = "doi")
}

#' Build the month field.
#' @noRd
get_bibtex_month <- function(cit_list) {
  mnt <- clean_str(cit_list$month)

  if (is.null(mnt)) {
    return(NULL)
  }

  # If number.
  if (grepl("^\\d+$", mnt)) {
    # Return the value when it is a valid integer.
    mnt_num <- as.numeric(mnt)
    mnt_num <- mnt_num[mnt_num %in% seq(1, 12)]
    return(clean_str(mnt_num))
  }

  # Otherwise, transform.
  # Get month in lowercase.
  month <- clean_str(tolower(mnt))
  month <- substr(month, 1, 3)

  # Index on abbreviation.
  low_month <- tolower(month.abb)
  res <- seq(1, 12)[month == low_month]
  clean_str(res[1])
}

#' Build the URL field list.
#' @noRd
get_bibtex_url <- function(cit_list) {
  ## Get URL: see bug with cff_create("rgeos").
  if (is.character(cit_list$url)) {
    allurls <- as.character(cit_list[names(cit_list) == "url"])
    allurls <- unlist(strsplit(allurls, " |,|\\n"))
  } else {
    allurls <- cit_list$url
  }

  allurls <- allurls[is_url(allurls)]
  cff_identifier_fields(allurls, key = "url", type = "url")
}

cff_identifier_fields <- function(values, key, type) {
  main_value <- unlist(values[1])
  identifiers <- lapply(values[-1], function(x) {
    list(type = type, value = clean_str(x))
  })

  if (length(identifiers) == 0) {
    identifiers <- NULL
  }

  c(
    stats::setNames(list(clean_str(main_value)), key),
    list(identifiers = identifiers)
  )
}

#' Build fields for additional people.
#' @noRd
get_bibtex_other_pers <- function(field_list) {
  others <- drop_null(field_list[other_persons()])

  # Select subsets.
  all_pers <- other_persons()
  toent <- other_persons_entity()
  toent_pers <- entity_person()

  toauto_end <- all_pers[!all_pers %in% c(toent, toent_pers)]
  toent_end <- toent[!toent %in% toent_pers]

  # As persons or entities using BibTeX.
  toentity_pers <- others[names(others) %in% toent_pers]
  toentity_pers <- lapply(toentity_pers, function(x) {
    if (inherits(x, "person")) {
      x <- format(x, include = c("given", "family"))
    }

    bibtex <- paste(x, collapse = " and ")
    end <- as_cff_person(bibtex)

    end
  })

  # Remaining fields.

  rest <- others[!names(others) %in% toent_pers]

  # If any field has multiple persons, paste and collapse them.
  rest <- lapply(others, function(x) {
    if (length(x) > 1) {
      and <- paste(
        format(x, include = c("given", "family")),
        collapse = " and "
      )
      and
    } else if (inherits(x, "person")) {
      as_cff(x)
    } else {
      x
    }
  })

  # Entity.
  toentity <- rest[names(rest) %in% toent_end]
  toentity <- lapply(toentity, function(x) {
    if (inherits(x, "cff")) {
      return(unclass(unlist(x, recursive = FALSE)))
    }
    list(name = clean_str(x))
  })

  toperson <- rest[names(rest) %in% toauto_end]
  toperson <- lapply(toperson, as_cff_person)

  # Bind and reorder.
  other_list <- c(toentity, toperson, toentity_pers)
  other_list <- other_list[names(others)]

  other_list
}
