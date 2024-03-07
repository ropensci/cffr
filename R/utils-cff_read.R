# Functions to convert fields on DESCRIPTION file

#' Mapped to Description
#' @noRd
get_desc_abstract <- function(pkg) {
  abstract <- pkg$get("Description")

  abstract <- clean_str(abstract)
  abstract <- unname(abstract)

  # Convert doi to url
  abstract <- gsub("<doi:", "<https://doi.org/", abstract, fixed = TRUE)

  abstract
}

#' Mapped to persons with roles "aut","cre"
#' Feeback needed: is this approach correct?
#' On CRAN, only first aut is used
#' @noRd
get_desc_authors <- function(pkg, authors_roles = c("aut", "cre")) {
  # This extracts all the persons
  persons <- as.person(pkg$get_authors())

  authors <- persons[vapply(persons, function(x, r = authors_roles) {
    any(x$role %in% r)
  }, logical(1))]

  get_all_authors <- as_cff_person(authors)
  get_all_authors <- unique(get_all_authors)

  get_all_authors
}

#' Mapped to Maintainer
#' @noRd
get_desc_contacts <- function(pkg) {
  persons <- as.person(pkg$get_authors())

  # Extract creators only
  contact <- persons[vapply(persons, function(x) {
    "cre" %in% x$role
  }, logical(1))]

  get_all_contacts <- as_cff_person(contact)
  get_all_contacts <- unique(get_all_contacts)
  get_all_contacts
}

#' Mapped to Date, Date/Publication or Packaged
#' @noRd
get_desc_date_released <- function(pkg) {
  # See https://cran.r-project.org/doc/manuals/R-exts.html#The-DESCRIPTION-file
  date1 <- pkg$get("Date")
  # This is for CRAN/BioConductor packages
  date2 <- pkg$get("Date/Publication")
  # R-universe
  date3 <- pkg$get("Packaged")
  # Work with vector
  alldates <- unname(c(date1, date2, date3))
  clean_dates <- lapply(alldates, function(x) {
    if (is.na(x) || is.null(x)) {
      return(NULL)
    }
    if (!is.character(x)) {
      return(NULL)
    }
    return(substr(x, 1, 10))
  })

  clean_dates <- unlist(clean_dates)[1]

  # Validate with format YYYY-MM-DD
  date <- tryCatch(as.character(as.Date(clean_dates, format = "%Y-%m-%d")),
    error = function(cond) {
      return(NULL)
    }
  )


  date <- clean_str(date)
  date
}

#' Mapped to X-schema.org-keywords, as codemeta/codemetar
#' @noRd
get_desc_keywords <- function(pkg) {
  kword <- pkg$get("X-schema.org-keywords")

  kword <- clean_str(kword)
  kword <- unname(kword)

  if (is.null(kword)) {
    return(kword)
  }

  kword <- unlist(strsplit(kword, ", "))
  kword <- unlist(strsplit(unique(kword), ","))

  # Hack: The validator doesn't seem to recognize when keyword is
  # unique. I add a new keyword r-package

  if (length(kword) == 1) kword <- unique(c(kword, "r-package"))

  # If still is 1 return NULL
  if (length(kword) == 1) {
    return(NULL)
  }


  kword
}

#' Mapped to License
#' @noRd
get_desc_license <- function(pkg) {
  licenses <- pkg$get_field("License")

  # The schema only accepts two LiCENSES max

  licenses <- unlist(strsplit(licenses, "\\| "))[1:2]

  # Clean up and split
  split <- unlist(strsplit(licenses, " \\+ |\\+"))

  # Clean leading and trailing blanks
  split <- unique(trimws(split))

  licenses_df <- data.frame(LICENSE = split)

  # Read mapping

  # Merge
  licenses_df <- merge(licenses_df, cffr::cran_to_spdx)

  # Clean results
  licenses_list <- lapply(licenses_df$SPDX, clean_str)
  licenses_list <- drop_null(licenses_list)

  license_char <- unlist(licenses_list)

  license_char
}

#' Try to get Repository
#' @noRd
get_desc_repository <- function(pkg) {
  name <- pkg$get("Package")
  repo <- clean_str(pkg$get("Repository"))

  # Repo is url
  if (is_url(repo)) {
    return(repo)
  }

  # Check if Bioconductor
  # biocViews is required in Bioconductor packages
  # http://contributions.bioconductor.org/description.html#biocviews
  if (!is.null(clean_str(pkg$get("biocViews")))) {
    return("https://bioconductor.org/")
  }


  # Repo is CRAN
  # Canonic url to CRAN
  if (is_substring(repo, "^CRAN$")) {
    return(
      paste0("https://CRAN.R-project.org/package=", name)
    )
  }

  # If not, search on installed repos

  repourl <- search_on_repos(name)

  return(repourl)
}

#' Mapped to Package & Title
#' @noRd
get_desc_title <- function(pkg) {
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
get_desc_urls <- function(pkg) {
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
  allurls <- allurls[is_url(allurls)]



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
get_desc_version <- function(pkg) {
  version <- pkg$get("Version")

  version <- clean_str(version)
  version <- unname(version)

  version
}

#' Extract topics as keywords for GH hosted packages
#' @noRd
get_gh_topics <- function(x) {
  # Only for GitHub repos
  if (!is_github(x)) {
    return(NULL)
  }

  # Get topics from repo
  api_url <- paste0(
    "https://api.github.com/repos", "/",
    gsub(
      "^http[a-z]://github.com/", "",
      x["repository-code"]
    )
  )

  tmpfile <- tempfile(fileext = ".json")

  # See if GH_TOKEN is set on Renv
  # I have an issue on testing, I reach
  # fast the GH api limit (no auth)
  # Need to auth to increase limit
  # Try to get an stored token
  token <- (Sys.getenv(c("GITHUB_PAT", "GITHUB_TOKEN")))
  token <- token[!token %in% c(NA, NULL, "")][1]

  ghtoken <- paste("token", token)

  # nocov start

  # Try with GHTOKEN
  res <- tryCatch(
    download.file(api_url,
      tmpfile,
      quiet = TRUE,
      headers = c(Authorization = ghtoken)
    ),
    warning = function(e) {
      return(TRUE)
    },
    error = function(e) {
      return(TRUE)
    }
  )

  # If it fails try with normal call
  if (isTRUE(res)) {
    # Regular call
    res <- tryCatch(
      download.file(api_url,
        tmpfile,
        quiet = TRUE
      ),
      warning = function(e) {
        return(TRUE)
      },
      error = function(e) {
        return(TRUE)
      }
    )
  }

  # nocov end
  if (isTRUE(res)) {
    return(NULL)
  }

  remotetopics <- lapply(jsonlite::read_json(tmpfile)$topics, clean_str)
  remotetopics <- unique(unlist(remotetopics))

  # If no topics NULL
  if (is.null(remotetopics)) {
    return(NULL)
  }

  return(remotetopics)
}
