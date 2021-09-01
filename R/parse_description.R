# Functions to parse field on DESCRIPTION file

parse_desc_abstract <- function(pkg) {
  abstract <- pkg$get("Description")

  abstract <- clean_str(abstract)
  abstract <- unname(abstract)

  abstract
}

parse_desc_title <- function(pkg) {
  title <- paste0(
    pkg$get("Package"),
    ": ",
    pkg$get("Title")
  )

  title <- clean_str(title)
  title
}

parse_desc_version <- function(pkg) {
  version <- pkg$get("Version")
  version <- clean_str(version)
}


parse_desc_date_released <- function(pkg){

  date <- as.character(as.Date(pkg$get("Date")))
  date <- clean_str(date)

  # No date here, try with Date/Publication
  # This field is populated in the installed packages from CRAN
  if(is.null(date)){
    date <- as.character(as.Date(pkg$get("Date/Publication")))
    date <- clean_str(date)
  }

  date
}
