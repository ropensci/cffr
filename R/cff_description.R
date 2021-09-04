cff_description <- function(desc_path = "DESCRIPTION", cff_version = "1.2.0") {
  pkg <- desc::desc(desc_path)
  pkg$coerce_authors_at_r()


  list_fields <- list(
    "cff-version" = cff_version,
    message = "If you use this software, please cite it using these metadata.",
    type = "software",
    title = parse_desc_title(pkg),
    version = parse_desc_version(pkg),
    authors = parse_desc_authors(pkg),
    abstract = parse_desc_abstract(pkg),
    "repository-code" = parse_desc_urls(pkg)$repo,
    url = parse_desc_urls(pkg)$url,
    "date-released" = parse_desc_date_released(pkg),
    contact = parse_desc_contacts(pkg),
    keywords = unlist(parse_desc_keywords(pkg)),
    license = unlist(parse_desc_license(pkg))
  )

  class(list_fields) <- "cffr"
  list_fields
}

# Functions to parse field on DESCRIPTION file

# Mapped to Description
parse_desc_abstract <- function(pkg) {
  abstract <- pkg$get("Description")

  abstract <- clean_str(abstract)
  abstract <- unname(abstract)

  abstract
}

# Mapped to Package & Title
parse_desc_title <- function(pkg) {
  title <- paste0(
    pkg$get("Package"),
    ": ",
    pkg$get("Title")
  )

  title <- clean_str(title)
  title
}

# Mapped to Version
parse_desc_version <- function(pkg) {
  version <- pkg$get("Version")

  version <- clean_str(version)
  version <- unname(version)

  version
}

# Mapped to Date or Date/Publication for installed packages
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

# Mapped to URL and BugReports
parse_desc_urls <- function(pkg) {
  url <- pkg$get_urls()

  # Get issue url
  issues <- tryCatch(pkg$get_field("BugReports")[1],
    error = function(cond) {
      return(pkg$get_urls())
    }
  )

  # Clean if GitLab
  issues <- gsub("/-/issues", "", issues)
  # Clean if GitHub
  issues <- gsub("/issues", "", issues)

  # Join issues and urls
  allurls <- unique(c(issues, url))

  # If no urls then return as null
  if (length(allurls) == 0) {
    url_list <- list(url = NULL)
    return(url_list)
  }
  # Try to find an url of the repo
  domains <- c(
    "github.com", "www.github.com",
    "gitlab.com",
    "r-forge.r-project.org",
    "bitbucket.org"
  )

  # Extract repo url
  repo_line <- which(lapply(domains, grepl, allurls)[[1]])
  repository_code <- allurls[repo_line][1]

  # The second url is considered for url arbitrarily
  if (isTRUE(length(allurls) > 1)) {
    url_end <- allurls[-repo_line][1]
  } else {
    url_end <- repository_code
  }

  url_list <- list(
    repo = clean_str(repository_code),
    url = clean_str(url_end)
  )

  return(url_list)
}


# Mapped to X-schema.org-keywords, as codemeta/codemetar
parse_desc_keywords <- function(pkg) {
  kword <- pkg$get("X-schema.org-keywords")

  kword <- clean_str(kword)
  kword <- unname(kword)

  if (is.null(kword)) {
    return(kword)
  }

  kword <- strsplit(kword, ", ")
  kword
}

# Mapped to License
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
