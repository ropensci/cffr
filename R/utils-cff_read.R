# Functions to convert fields in the DESCRIPTION file.

#' Mapped to Description
#' @noRd
get_desc_abstract <- function(pkg) {
  abstract <- pkg$get("Description")

  abstract <- clean_str(abstract)
  abstract <- unname(abstract)

  # Convert DOI to URL.
  abstract <- gsub("<doi:", "<https://doi.org/", abstract, fixed = TRUE)

  abstract
}

#' Map to people with the roles "aut" and "cre".
#' Uncertain: this approach may need review.
#' On CRAN, only the first "aut" is used.
#' @noRd
get_desc_authors <- function(pkg, authors_roles = c("aut", "cre")) {
  # Extract all persons.
  persons <- as.person(pkg$get_authors())

  authors <- persons[vapply(
    persons,
    function(x, r = authors_roles) {
      any(x$role %in% r)
    },
    logical(1)
  )]

  get_all_authors <- as_cff_person(authors)
  get_all_authors <- unique(get_all_authors)

  get_all_authors
}

#' Mapped to Maintainer
#' @noRd
get_desc_contacts <- function(pkg) {
  persons <- as.person(pkg$get_authors())

  # Extract creators only.
  contact <- persons[vapply(
    persons,
    function(x) {
      "cre" %in% x$role
    },
    logical(1)
  )]

  get_all_contacts <- as_cff_person(contact)
  get_all_contacts <- unique(get_all_contacts)
  get_all_contacts
}

#' Mapped to Date, Date/Publication or Packaged
#' @noRd
get_desc_date_released <- function(pkg) {
  # See https://cran.r-project.org/doc/manuals/R-exts.html#The-DESCRIPTION-file
  date1 <- pkg$get("Date")
  # This is for CRAN/Bioconductor packages.
  date2 <- pkg$get("Date/Publication")
  # R-universe.
  date3 <- pkg$get("Packaged")
  # Work with vector.
  alldates <- unname(c(date1, date2, date3))
  clean_dates <- lapply(alldates, function(x) {
    if (is.na(x) || is.null(x)) {
      return(NULL)
    }
    if (!is.character(x)) {
      return(NULL)
    }
    substr(x, 1, 10)
  })

  clean_dates <- unlist(clean_dates)[1]

  # Validate with format YYYY-MM-DD.
  date <- tryCatch(
    as.character(as.Date(clean_dates, format = "%Y-%m-%d")),
    error = function(cond) {
      NULL # nocov
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

  # Hack: the validator does not seem to recognize a single keyword.
  # Add the new keyword r-package.

  if (length(kword) == 1) {
    kword <- unique(c(kword, "r-package"))
  }

  # If there is still one keyword, return NULL.
  if (length(kword) == 1) {
    return(NULL)
  }

  kword
}

#' Mapped to License
#' @noRd
get_desc_license <- function(pkg) {
  licenses <- pkg$get_field("License")

  # The schema accepts at most two licenses.

  licenses <- unlist(strsplit(licenses, "\\| "))[1:2]

  # Clean up and split.
  split <- unlist(strsplit(licenses, " \\+ |\\+"))

  # Clean leading and trailing blanks.
  split <- unique(trimws(split))

  licenses_df <- data.frame(LICENSE = split)

  # Read mapping.

  # Merge.
  licenses_df <- merge(licenses_df, cffr::cran_to_spdx)

  # Clean results.
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

  # Repository is a URL.
  if (is_url(repo)) {
    return(repo)
  }

  # Check if Bioconductor.
  # biocViews is required in Bioconductor packages.
  # http://contributions.bioconductor.org/description.html#biocviews
  if (!is.null(clean_str(pkg$get("biocViews")))) {
    return("https://bioconductor.org/")
  }

  # Repository is CRAN.
  # Canonical URL to CRAN.
  if (is_substring(repo, "^CRAN$")) {
    return(paste0("https://CRAN.R-project.org/package=", name))
  }

  # Otherwise, search installed repositories.

  repourl <- search_on_repos(name)

  repourl
}

#' Mapped to Package and Title
#' @noRd
get_desc_title <- function(pkg) {
  title <- paste0(pkg$get("Package"), ": ", pkg$get("Title"))

  title <- clean_str(title)
  title
}

#' Mapped to `URL` and `BugReports`.
#' Additional URLs as identifiers.
#' @noRd
get_desc_urls <- function(pkg) {
  url <- pkg$get_urls()

  # Get issue URL.
  issues <- tryCatch(pkg$get_field("BugReports")[1], error = function(cond) {
    pkg$get_urls()
  })

  # Clean if GitLab.
  issues <- gsub("/-/issues$", "", issues)
  # Clean if GitHub and codeberg.org.
  issues <- gsub("/issues$", "", issues)

  # Join issues and URLs.
  allurls <- unique(c(issues, url))
  allurls <- allurls[is_url(allurls)]

  # If there are no URLs, return as null.
  if (length(allurls) == 0) {
    url_list <- list(url = NULL)
    return(url_list)
  }
  # Try to find a repository URL.
  domains <- paste0(
    c(
      "github.com",
      "www.github.com",
      "gitlab.com",
      "r-forge.r-project.org",
      "bitbucket.org",
      "codeberg.org"
    ),
    collapse = "|"
  )

  # Extract repository URL.
  repo_line <- grep(domains, allurls, ignore.case = TRUE)[1]

  repository_code <- clean_str(allurls[repo_line][1])

  if (!is.na(repo_line)) {
    remaining <- allurls[-repo_line]
  } else {
    remaining <- allurls
  }

  # The second URL is considered for URL arbitrarily.
  if (isTRUE(length(remaining) > 0)) {
    url_end <- remaining[1]
    remaining <- remaining[-1]
  } else {
    url_end <- repository_code
  }
  url_end <- clean_str(url_end)

  # If there are more, move them to identifiers.

  if (isTRUE(length(remaining) > 0)) {
    identifiers <- lapply(remaining, function(x) {
      list(type = "url", value = clean_str(x))
    })
  } else {
    identifiers <- NULL
  }

  url_list <- list(
    repo = clean_str(repository_code),
    url = clean_str(url_end),
    identifiers = identifiers
  )
  url_list
}

#' Mapped to Version
#' @noRd
get_desc_version <- function(pkg) {
  version <- pkg$get("Version")

  version <- clean_str(version)
  version <- unname(version)

  version
}

#' Extract topics as keywords for GitHub-hosted packages
#' @noRd
get_gh_topics <- function(x) {
  # Only for GitHub repositories.
  if (!is_github(x)) {
    return(NULL)
  }

  # Get topics from the repository.
  api_url <- paste0(
    "https://api.github.com/repos",
    "/",
    gsub("^http[a-z]://github.com/", "", x["repository-code"])
  )

  tmpfile <- tempfile(fileext = ".json")

  # Check whether GH_TOKEN is set in Renviron.
  # Tests can quickly reach the GitHub API limit without authentication.
  # Authenticate to increase the limit.
  # Try to get a stored token.
  token <- c(Sys.getenv(c("GITHUB_TOKEN", "GITHUB_PAT")))
  token <- token[!token %in% c(NA, NULL, "")][1]

  ghtoken <- paste("token", token)

  # nocov start

  # Try with GITHUB_TOKEN.
  res <- tryCatch(
    download.file(
      api_url,
      tmpfile,
      quiet = TRUE,
      headers = c(Authorization = ghtoken),
      mode = "wb"
    ),
    warning = function(e) {
      TRUE
    },
    error = function(e) {
      TRUE
    }
  )

  # If it fails, try with a normal call.
  if (isTRUE(res)) {
    # Regular call.
    res <- tryCatch(
      download.file(api_url, tmpfile, quiet = TRUE, mode = "wb"),
      warning = function(e) {
        TRUE
      },
      error = function(e) {
        TRUE
      }
    )
  }

  # nocov end
  if (isTRUE(res)) {
    return(NULL)
  }

  remotetopics <- lapply(jsonlite::read_json(tmpfile)$topics, clean_str)
  remotetopics <- unique(unlist(remotetopics))

  # If there are no topics, return NULL.
  if (is.null(remotetopics)) {
    return(NULL)
  }

  remotetopics
}

get_desc_sha <- function(pkg) {
  sha <- pkg$get("RemoteSha")

  sha <- clean_str(sha)
  sha <- unname(sha)

  sha
}

get_desc_doi <- function(pkg) {
  pkg <- pkg$get("Package")
  if (is.null(search_on_repos(pkg))) {
    return(NULL)
  }

  doi <- paste0("10.32614/CRAN.package.", pkg)
  clean_str(doi)
}
