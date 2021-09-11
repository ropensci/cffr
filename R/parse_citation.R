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
      suppressWarnings(
        utils::readCitationFile(cit_path, meta = meta)
      )
    },
    error = function(x) {
      return(NULL)
    }
  )

  # On null, try to catch this
  if (is.null(parsed)) {
    parsed <- parse_r_citation_errors(cit_path, meta)
  }
  parsed
}


#' Error handling on CITATION R-native files
#' @noRd
parse_r_citation_errors <- function(cit_path, meta) {
  cit <- readLines(cit_path, encoding = meta$Encoding)
  # Known issue citation(auto = meta) cause errors
  # Remove
  cit <- cit[-grep("citation(auto = meta)",
    cit,
    fixed = TRUE
  )]

  # Write to a temp file
  tmp <- tempfile()
  writeLines(cit, tmp)

  parsed <- tryCatch(
    utils::readCitationFile(tmp, meta = meta),
    error = function(x) {
      return(NULL)
    }
  )
  if (length(parsed) == 0) {
    return(NULL)
  }
  parsed
}

#' Parse and clean data from DESCRIPTION to create metadata
#' @noRd
parse_package_meta <- function(desc_path) {
  pkg <- desc::desc(desc_path)
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

  doi_list <- list(
    doi = clean_str(doi),
    identifiers = identifiers
  )
}

#' BB for month
#' @noRd
building_month <- function(parse_cit) {

  # Get month, everything in lowercase
  month <- clean_str(tolower(parse_cit$month))

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
    allurls <- unlist(strsplit(allurls, " "))
    allurls <- unlist(strsplit(allurls, ","))
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

  url_list <- list(
    url = clean_str(url),
    identifiers = identifiers
  )
}
