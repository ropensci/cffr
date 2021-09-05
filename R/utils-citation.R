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
