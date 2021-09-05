# Used for parsing CITATION R-native files

#' @noRd
parse_r_citation <- function(desc_path, cit_path) {
  if (!file.exists(cit_path) || !file.exists(desc_path)) {
    return(NULL)
  }
  # Create meta
  meta <- parse_package_meta(desc_path)

  # First try - Would normally be enough
  parsed <- try(
    utils::readCitationFile(cit_path, meta = meta),
    silent = TRUE
  )

  # On null, try to catch this
  if (inherits(parsed, "try-error")) {
    # Known issue citation(auto = meta) cause errors

    cit <- readLines(cit_path, encoding = meta$Encoding)
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
  }
  parsed
}



# Parse and clean data from DESCRIPTION to create metadata

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
