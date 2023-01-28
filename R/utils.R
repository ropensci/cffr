# Utils functions used on the package

#' Clean strings
#'
#' @param str The string to be cleaned
#' @noRd
clean_str <- function(str) {
  # Collapse to single char
  str <- paste(str, collapse = " ")
  str <- unlist(str)
  if (is.null(str) || is.na(str)) {
    return(NULL)
  }

  clean <- gsub("[\n\r]", " ", str)
  clean <- gsub("\\s+", " ", clean)
  clean <- gsub("\\{", "", clean)
  clean <- gsub("\\}", "", clean)
  clean <- gsub("^NA$", "", clean)
  clean <- trimws(clean)
  # Collapse to single char
  clean <- paste(clean, collapse = " ")

  if (clean == "") {
    return(NULL)
  }
  # Parse encoding
  enc <- Encoding(clean)

  if (enc != "UTF-8") clean <- iconv(clean, to = "UTF-8")

  clean
}

#' Drop nulls from list
#' @source  https://github.com/cboettig/codemeta/blob/master/R/utils.R
#' @param x The list to be cleaned
#' @noRd
drop_null <- function(x) {
  x[lengths(x) != 0]
}


#' Pretty printing of snapshots
#' @noRd
print_snapshot <- function(title = "----", obj) {
  cat("\n\n##", title, "\n\n")
  print(obj)
  cat("\n---")
}

#' Search a package on available repos
#' @param name name of the package
#' @param avail Data frame with the packages available, See
#' [utils::available.packages()].
#' @param repos vector of repos
#' @noRd
search_on_repos <- function(name,
                            avail = avail_on_init,
                            repos = detect_repos()) {
  get <- avail[name == avail$Package, "Repository"]

  get <- clean_str(get)

  if (is.null(get)) {
    return(NULL)
  }

  # Try to find in CRAN
  cran_repo <- clean_str(repos["CRAN"])


  if (length(grep(cran_repo, get) == 1)) {
    # Canonical url to CRAN

    repos <- paste0("https://CRAN.R-project.org/package=", name)
    return(repos)
  }

  repos <- gsub("src/contrib$", "", get)

  repos
}


#' Detect current repos
#'
#' Detect the current repos of the user. If not set, use Cloud
#' @param repos Current repos setup
#' @noRd
detect_repos <- function(repos = getOption("repos")) {
  # Not use RSPM
  repos <- repos[names(repos) != "RSPM"]
  repos <- repos[!grepl("//rspm", repos)]

  # If not set use 0-Cloud
  if (!is.url(repos["CRAN"])) {
    repos["CRAN"] <- "https://cloud.r-project.org/"
  }

  return(repos)
}

#' Function for fuzzy matching the names of the keys
#'
#' @description
#' Proposed by @sckott
#' @inheritParams cff_create
#' @noRd
fuzzy_keys <- function(keys) {
  valid_keys <- cff_schema_keys()

  names <- names(keys)
  # Check valid keys as is
  is_valid_key <- names %in% valid_keys

  # If not all are valid try to fuzzy match
  if (isFALSE(all(is_valid_key))) {
    names_fuzzy <- names[!(is_valid_key)]

    keys_match <- lapply(names_fuzzy,
      agrep, valid_keys,
      ignore.case = TRUE,
      value = TRUE,
      fixed = FALSE
    )


    # Modify NULL correspondences
    keys_match <- unlist(lapply(
      keys_match,
      function(x) {
        if (length(x) == 0) {
          return("No match")
        }
        return(x[1])
      }
    ))

    # Message
    message(cli::col_magenta(
      "Found mispelled keys. Trying to map:",
      paste("\n", names_fuzzy, " -> ", keys_match, collapse = "")
    ))

    # Modify names

    names[!is_valid_key] <- keys_match
  }

  new_keys <- keys
  names(new_keys) <- names

  new_keys <- new_keys[names %in% valid_keys]

  return(new_keys)
}
