## Parsers ----

#' Used for parsing CITATION R-native files
#' @noRd
parse_r_citation <- function(desc_path, cit_path) {
  if (!file.exists(cit_path) || !file.exists(desc_path)) {
    return(NULL)
  }
  # Create meta
  meta <- parse_package_meta(desc_path)

  # First try - Would normally be enough
  parsed <- tryCatch(
    utils::readCitationFile(cit_path, meta = meta),
    warning = function(cit_path, meta) {
      # Avoid warnings
      # nocov start
      suppressWarnings(
        utils::readCitationFile(cit_path, meta = meta)
      )
    },
    error = function(x) {
      return(NULL)
    }
    # nocov end
  )

  parsed
}

#' Parse and clean data from DESCRIPTION to create metadata
#' @noRd
parse_package_meta <- function(desc_path) {
  pkg <- desc::desc(desc_path)
  pkg$coerce_authors_at_r()
  # Extract package data
  meta <- pkg$get(desc::cran_valid_fields)

  # Clean missing and drop empty fields
  meta <- drop_null(lapply(meta, clean_str))

  # Check encoding
  if (!is.null(meta$Encoding)) {
    meta <- lapply(meta, iconv, from = meta$Encoding, to = "UTF-8")
  } else {
    meta$Encoding <- "UTF-8"
  }

  meta
}

# DEPRECATED
# Used for creating an auto preferred-citation from an
# cff object if not present
# It mocks citation(auto = meta) of base R
# parse_preferred_auto <- function(cffobjend) {
#   valid <- cff_schema_definitions_refs()
#
#   pref <- cffobjend[names(cffobjend) %in%
#     valid]
#
#   pref$type <- "manual"
#
#   # Handle year
#
#   date_rel <- pref[["date-released"]]
#
#   if (is.null(date_rel)) {
#     year <- format(Sys.Date(), "%Y")
#   } else {
#     year <- format(as.Date(pref[["date-released"]]), "%Y")
#   }
#
#   pref$year <- year
#   pref$notes <- NULL
#   if (!is.null(pref$version)) {
#     pref$notes <- paste("R package version", pref$version)
#   }
#   # If it has a repository (CRAN) use that as url
#   if (!is.null(pref$repository)) pref$url <- pref$repository
#
#   # Order and output
#   ordernames <- c(
#     "type", "title", "authors", "year",
#     "notes", "url"
#   )
#   pref <- pref[ordernames]
#   pref <- as.cff(pref)
#
#   pref
# }
## Building blocks ----

#' BB for doi
#' @noRd
building_doi <- function(parse_cit) {
  dois <- unlist(parse_cit[names(parse_cit) == "doi"])

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
building_month <- function(parse_cit) {
  mnt <- parse_cit$month

  if (is.null(mnt) || is.na(mnt)) {
    return(NULL)
  }

  # Guess if a valid integer is provided and output
  mnt_num <- tryCatch(as.numeric(mnt),
    warning = function(e) {
      return(FALSE)
    }
  )

  if (is.numeric(mnt_num) && mnt_num > 0 && mnt_num <= 12) {
    res <- clean_str(mnt_num)
    return(res)
  }

  # else transform
  # Get month, everything in lowercase
  month <- clean_str(tolower(mnt))

  # Index on abbreviation
  res <- clean_str(which(tolower(month.abb) == month))
  if (!is.null(res)) {
    return(res)
  }
  # Index on full

  res <- clean_str(which(tolower(month.name) == month))
  res
}

#' BB for URL
#' @noRd
building_url <- function(parse_cit) {
  ## Parse url: see bug with cff_create("rgeos")
  if (is.character(parse_cit$url)) {
    allurls <- as.character(parse_cit[names(parse_cit) == "url"])
    allurls <- unlist(strsplit(allurls, " |,|\\n"))
  } else {
    allurls <- parse_cit$url
  }

  allurls <- allurls[is.url(allurls)]
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
building_other_persons <- function(parsed_fields) {
  others <- drop_null(parsed_fields[other_persons()])

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

  # Parse as entity
  toentity <- others[names(others) %in% toent_end]
  toentity <- lapply(toentity, function(x) {
    list(name = clean_str(x))
  })

  # As persons or entities using bibtex
  toentity_pers <- others[names(others) %in% toent_pers]
  toentity_pers <- lapply(toentity_pers, function(x) {
    bibtex <- paste(x, collapse = " and ")

    end <- cff_parse_person_bibtex(bibtex)

    # If has names then it should be moved to a lower level on a list
    if (!is.null(names(end))) end <- list(end)

    return(end)
  })


  toperson <- others[names(others) %in% toauto_end]
  toperson <- lapply(toperson, cff_parse_person_bibtex)
  # This should be vectors, so include on lists
  toperson <- lapply(toperson, function(x) {
    if (!is.null(names(x))) {
      x <- list(x)
    } else {
      x
    }
  })



  # Bind and reorder
  parsedothers <- c(toentity, toperson, toentity_pers)
  parsedothers <- parsedothers[names(others)]

  return(parsedothers)
}


#' Vector other persons
#' @noRd
other_persons <- function() {
  pers_ent <- c(
    "contact",
    "editors",
    "editors-series",
    "recipients",
    "senders",
    "translators"
  )

  pers_ent <- sort(unique(c(
    pers_ent,
    other_persons_entity(),
    entity_person()
  )))

  return(pers_ent)
}

#' Vector other persons to be parsed as entities
#' @noRd
other_persons_entity <- function() {
  entities <- c(
    "conference",
    "database-provider",
    "institution",
    "location",
    "publisher"
  )

  entities
}

#' This may be entities or persons
#' @noRd
entity_person <- function() {
  forced <- c(
    "editors",
    "editors-series"
  )
  forced
}
