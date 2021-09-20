# Functions to parse field on DESCRIPTION file

#' Mapped to Description
#' @noRd
parse_desc_abstract <- function(pkg) {
  abstract <- pkg$get("Description")

  abstract <- clean_str(abstract)
  abstract <- unname(abstract)

  abstract
}

#' Mapped to persons with roles "aut","cre"
#' Feeback needed: is this approach correct?
#' On CRAN, only first aut is used
#' @noRd
parse_desc_authors <- function(pkg) {
  # This extracts all the persons
  persons <- as.person(pkg$get_authors())

  authors <- persons[vapply(persons, function(x) {
    "aut" %in% x$role || "cre" %in% x$role
  }, logical(1))]

  parse_all_authors <- lapply(authors, cff_parse_person)
  parse_all_authors <- unique(parse_all_authors)

  parse_all_authors
}

#' Mapped to Maintainer
#' @noRd
parse_desc_contacts <- function(pkg) {
  persons <- as.person(pkg$get_authors())

  # Extract creators only
  contact <- persons[vapply(persons, function(x) {
    "cre" %in% x$role
  }, logical(1))]

  parse_all_contacts <- lapply(contact, cff_parse_person)
  parse_all_contacts <- unique(parse_all_contacts)
  parse_all_contacts
}

#' Mapped to Date or Date/Publication for installed packages
#' @noRd
parse_desc_date_released <- function(pkg) {
  date <- tryCatch(as.character(as.Date(pkg$get("Date"))),
    error = function(cond) {
      return(NULL)
    }
  )


  date <- clean_str(date)

  # If no date here, try with Date/Publication
  # This field is populated in the installed packages from CRAN
  if (is.null(date)) {
    date <- as.character(as.Date(pkg$get("Date/Publication")))
  }

  date <- clean_str(date)
  date
}

#' Mapped to X-schema.org-keywords, as codemeta/codemetar
#' @noRd
parse_desc_keywords <- function(pkg) {
  kword <- pkg$get("X-schema.org-keywords")

  kword <- clean_str(kword)
  kword <- unname(kword)

  if (is.null(kword)) {
    return(kword)
  }

  kword <- unlist(strsplit(kword, ", "))
  kword <- strsplit(unique(kword), ",")

  kword
}

#' Mapped to License
#' @noRd
parse_desc_license <- function(pkg) {
  licenses <- pkg$get_field("License")

  # The schema only accepts two LiCENSES max

  licenses <- unlist(strsplit(licenses, "\\| "))[1:2]

  # Clean up and split
  split <- unlist(strsplit(licenses, " \\+ |\\+"))

  # Clean leading and trailing blanks
  split <- gsub("^ | $", "", split)
  split <- unique(split)

  licenses_df <- data.frame(LICENSE = split)

  # Read mapping
  cran_to_spdx <-
    read.csv(system.file("extdata/cran-to-spdx.csv", package = "cffr"))

  # Merge
  licenses_df <- merge(licenses_df, cran_to_spdx)

  # Clean results
  licenses_list <- lapply(licenses_df$SPDX, clean_str)
  licenses_list <- drop_null(licenses_list)

  license_char <- unlist(licenses_list)

  license_char
}

#' Try to get from CRAN
#' @noRd
parse_desc_repository <- function(pkg) {
  name <- pkg$get("Package")
  get <- avail[name == avail$Package, c("Repository")]

  get <- clean_str(get)

  if (is.null(get)) {
    return(NULL)
  }

  cran_repo <- as.character(options("repos")$repos["CRAN"])


  if (length(grep(cran_repo, get) == 1)) {
    # Canonic url to CRAN

    repos <- paste0("https://cran.r-project.org/package=", name)
    return(repos)
  }

  repos <- gsub("src/contrib$", "", get)

  repos
}

#' Mapped to Package & Title
#' @noRd
parse_desc_title <- function(pkg) {
  title <- paste0(
    pkg$get("Package"),
    ": ",
    pkg$get("Title")
  )

  title <- clean_str(title)
  title
}

#' Mapped to URL and BugReports
#' Additional urls as identifiers
#' @noRd
parse_desc_urls <- function(pkg) {
  url <- pkg$get_urls()

  # Get issue url
  issues <- tryCatch(pkg$get_field("BugReports")[1],
    error = function(cond) {
      return(pkg$get_urls())
    }
  )

  # Clean if GitLab
  issues <- gsub("/-/issues$", "", issues)
  # Clean if GitHub
  issues <- gsub("/issues$", "", issues)

  # Join issues and urls
  allurls <- unique(c(issues, url))
  allurls <- allurls[is.url(allurls)]



  # If no urls then return as null
  if (length(allurls) == 0) {
    url_list <- list(url = NULL)
    return(url_list)
  }
  # Try to find an url of the repo
  domains <- paste0(c(
    "github.com", "www.github.com",
    "gitlab.com",
    "r-forge.r-project.org",
    "bitbucket.org"
  ), collapse = "|")

  # Extract repo url
  repo_line <- grep(domains, allurls)[1]

  repository_code <- clean_str(allurls[repo_line][1])

  if (!is.na(repo_line)) {
    remaining <- allurls[-repo_line]
  } else {
    remaining <- allurls
  }

  # The second url is considered for url arbitrarily
  if (isTRUE(length(remaining) > 0)) {
    url_end <- remaining[1]
    remaining <- remaining[-1]
  } else {
    url_end <- repository_code
  }
  url_end <- clean_str(url_end)

  # If there are more, move them to identifiers

  if (isTRUE(length(remaining) > 0)) {
    identifiers <- lapply(remaining, function(x) {
      list(
        type = "url",
        value = clean_str(x)
      )
    })
  } else {
    identifiers <- NULL
  }

  url_list <- list(
    repo = clean_str(repository_code),
    url = clean_str(url_end),
    identifiers = identifiers
  )
  return(url_list)
}

#' Mapped to Version
#' @noRd
parse_desc_version <- function(pkg) {
  version <- pkg$get("Version")

  version <- clean_str(version)
  version <- unname(version)

  version
}
