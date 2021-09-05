# Used for parsing CITATION R-native files

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
