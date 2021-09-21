# Utils functions used on the package

#' Clean strings
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
#' @noRd
search_on_repos <- function(name) {
  repos <- detect_repos()


  get <- avail[name == avail$Package, c("Repository")]

  get <- clean_str(get)

  if (is.null(get)) {
    return(NULL)
  }

  # Try to find in CRAN
  cran_repo <- clean_str(repos["CRAN"])


  if (length(grep(cran_repo, get) == 1)) {
    # Canonic url to CRAN

    repos <- paste0("https://cran.r-project.org/package=", name)
    return(repos)
  }

  repos <- gsub("src/contrib$", "", get)

  repos
}


#' Detect current repos
#' @noRd
detect_repos <- function() {
  repos <- getOption("repos")

  # If not set use 0-Cloud
  if (!is.substring(repos["CRAN"], "^http")) {
    repos["CRAN"] <- "https://cloud.r-project.org/"
  }
  return(repos)
}


# Load this one per session
avail <- as.data.frame(available.packages(
  repos = detect_repos(),
))[, c("Package", "Repository")]
