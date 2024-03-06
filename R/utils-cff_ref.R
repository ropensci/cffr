# Utils for as_cff_reference

#' Extract and map BibTeX entry
#' @noRd
get_bibtex_entry <- function(bib) {
  # Unclass and manage entry type
  # Extract type from BibTeX
  init_type <- attr(unclass(bib)[[1]], "bibtype")
  init_type <- clean_str(tolower(init_type))


  cit_list <- drop_null(unclass(bib)[[1]])

  # Add fields
  cit_list$bibtex_entry <- init_type

  # Manage type from BibTeX and convert to CFF
  # This overwrite the BibTeX type field. Not treated by this function
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


  # Check if it an inbook with booktitle (BibLaTeX style)
  if (all(init_type == "inbook", "booktitle" %in% names(cit_list))) {
    # Make it incollection
    cit_list$bibtex_entry <- "incollection"
    cit_list$type <- "generic"
  }


  return(cit_list)
}

#' Adapt names from R citation()/BibTeX to cff format
#' @noRd
get_bibtex_fields <- function(cit_list) {
  # to lowercase
  names(cit_list) <- tolower(names(cit_list))
  nm <- names(cit_list)
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

  # Get some fields from BibLaTeX
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
    kwords <- unlist(cit_list["keywords" == nm])
    kwords <- clean_str(paste(kwords, collapse = ", "))
    kwords <- trimws(unique(unlist(strsplit(kwords, ",|;"))))
    cit_list$keywords <- unique(kwords)
  }

  # Not mapped:
  # annote crossref key organization series type
  #
  # Fields address, organization, series and type are treated on
  # main function
  # key is a special field, treated apart
  # Fields ignored: annote, crossref

  names(cit_list) <- nm

  # Additionally, need to delete keywords if length is less than 2,
  # errors on validation
  if (length(cit_list$keywords) < 2) {
    cit_list$keywords <- NULL
  }

  # Treat location ----

  loc <- cit_list$location

  if (!is.null(loc)) cit_list$location <- loc



  # Treat additional dates ----
  dpub <- clean_str(cit_list$`date-published`)
  cit_list$`date-published` <- clean_str(as.Date(dpub, optional = TRUE))

  datacc <- clean_str(cit_list$`date-accessed`)
  cit_list$`date-accessed` <- clean_str(as.Date(datacc, optional = TRUE))

  # Treat pages

  pages <- cit_list$bibtex_pages
  if (!is.null(pages)) {
    spl <- unlist(strsplit(pages, "--"))

    cit_list$start <- spl[1]

    if (length(spl) > 1) cit_list$end <- paste(spl[-1], collapse = "--")
  }

  return(cit_list)
}

#' Modify mapping of some org. fields on BibTeX to CFF
#' @noRd
get_bibtex_inst <- function(field_list) {
  # Initial values
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

  # Rest of cases remove bibtex institution and rename
  nms <- names(field_list)

  field_list <- field_list["institution" != nms]

  # Rename
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
  return(field_list)
}




#' Adapt cff keys to bibtex entries
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
  # If available
  if (is.null(loc)) {
    return(cit_list)
  }

  # At this point is in location, see to move

  # Logic order.
  # 1. To conference
  # 2. To institution
  # 3. To publisher
  # Otherwise leave on location

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

  return(cit_list)
}

add_bibtex_coltype <- function(field_list) {
  # Add collection-type if applicable and rearrange fields
  nms <- names(field_list)

  if (!"collection-title" %in% nms) {
    return(field_list)
  }

  # Made collection-type if we create collection-title
  bibtex_type <- field_list$bibtex_entry

  # Remove `in` at init: inbook, incollection affected
  coltype <- clean_str(gsub("^in", "", bibtex_type))
  field_list$`collection-type` <- coltype

  # Rearrange to make both collection keys together
  nm_first <- nms[seq(1, match("collection-title", nms))]

  nms_end <- unique(c(nm_first, "collection-type", nms))

  field_list <- field_list[nms_end]

  return(field_list)
}

fallback_dates <- function(cit_list) {
  # Fallback for year and month: use date-published
  if (is.null(cit_list$month) && !is.null(cit_list$`date-published`)) {
    cit_list$month <- format(as.Date(cit_list$`date-published`), "%m")
  }

  if (is.null(cit_list$year) && !is.null(cit_list$`date-published`)) {
    cit_list$year <- format(as.Date(cit_list$`date-published`), "%Y")
  }

  ## month ----
  cit_list$month <- get_bibtex_month(cit_list)

  return(cit_list)
}

#' BB for doi
#' @noRd
get_bibtex_doi <- function(cit_list) {
  dois <- unlist(cit_list[names(cit_list) == "doi"])

  dois <- unlist(lapply(dois, function(x) {
    x <- gsub("^https://doi.org/", "", x)
    x <- clean_str(x)
  }))


  dois <- unique(as.character(dois))


  # The first doi goes to doi key
  doi <- unlist(dois[1])

  # The rest goes to identifies
  identifiers <- lapply(dois[-1], function(x) {
    list(
      type = "doi",
      value = clean_str(x)
    )
  })
  if (length(identifiers) == 0) identifiers <- NULL
  doi_list <- list(
    doi = clean_str(doi),
    identifiers = identifiers
  )
  return(doi_list)
}

#' BB for month
#' @noRd
get_bibtex_month <- function(cit_list) {
  mnt <- clean_str(cit_list$month)

  if (is.null(mnt)) {
    return(NULL)
  }

  # If number
  if (grepl("^\\d+$", mnt)) {
    # Guess if a valid integer is provided and output
    mnt_num <- as.numeric(mnt)
    mnt_num <- mnt_num[mnt_num %in% seq(1, 12)]
    return(clean_str(mnt_num))
  }

  # else transform
  # Get month, everything in lowercase
  month <- clean_str(tolower(mnt))
  month <- substr(month, 1, 3)

  # Index on abbreviation
  low_month <- tolower(month.abb)
  res <- seq(1, 12)[month == low_month]
  clean_str(res[1])
}

#' BB for URL
#' @noRd
get_bibtex_url <- function(cit_list) {
  ## Get url: see bug with cff_create("rgeos")
  if (is.character(cit_list$url)) {
    allurls <- as.character(cit_list[names(cit_list) == "url"])
    allurls <- unlist(strsplit(allurls, " |,|\\n"))
  } else {
    allurls <- cit_list$url
  }

  allurls <- allurls[is_url(allurls)]
  # The first url goes to url key

  url <- unlist(allurls[1])

  # The rest goes to identifies
  identifiers <- lapply(allurls[-1], function(x) {
    list(
      type = "url",
      value = clean_str(x)
    )
  })

  if (length(identifiers) == 0) identifiers <- NULL

  url_list <- list(
    url = clean_str(url),
    identifiers = identifiers
  )

  return(url_list)
}

#' BB for other persons
#' @noRd
get_bibtex_other_pers <- function(field_list) {
  others <- drop_null(field_list[other_persons()])

  # If any is person type (example, editors) then paste and collapse

  others <- lapply(others, function(x) {
    if (inherits(x, "person")) {
      x <- paste(x, collapse = " and ")
    } else {
      return(x)
    }
  })



  # Select subsets
  all_pers <- other_persons()
  toent <- other_persons_entity()
  toent_pers <- entity_person()

  toauto_end <- all_pers[!all_pers %in% c(toent, toent_pers)]
  toent_end <- toent[!toent %in% toent_pers]

  # Entity
  toentity <- others[names(others) %in% toent_end]
  toentity <- lapply(toentity, function(x) {
    list(name = clean_str(x))
  })

  # As persons or entities using bibtex
  toentity_pers <- others[names(others) %in% toent_pers]
  toentity_pers <- lapply(toentity_pers, function(x) {
    bibtex <- paste(x, collapse = " and ")
    end <- as_cff_person(bibtex)

    return(end)
  })


  toperson <- others[names(others) %in% toauto_end]
  toperson <- lapply(toperson, as_cff_person)


  # Bind and reorder
  other_list <- c(toentity, toperson, toentity_pers)
  other_list <- other_list[names(others)]

  return(other_list)
}
