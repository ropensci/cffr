#' Check whether a string is an email
#' @param email A string to be evaluated.
#' @noRd
is_email <- function(email) {
  if (is.null(email)) {
    return(FALSE)
  }

  email <- trimws(as.character(email))

  # See the CFF validation schema.
  x <- grepl(
    "^[\\S]+@[\\S]+\\.[\\S]{2,}$",
    email,
    ignore.case = TRUE,
    perl = TRUE
  )
  x
}

#' Check whether a string is a URL
#' @param url A URL to be evaluated.
#' @noRd
is_url <- function(url) {
  if (is.null(url)) {
    return(FALSE)
  }

  x <- grepl("^(https|http|ftp|sftp)://.+", url)
  x
}

#' Check whether a string contains a substring
#'
#' @param x A string.
#' @param sub A substring to be evaluated.
#' @noRd
is_substring <- function(x, sub) {
  if (is.null(x)) {
    return(FALSE)
  }

  if (isTRUE(grep(sub, x) == 1)) {
    TRUE
  } else {
    FALSE
  }
}

#' Check whether an object is a `cff` object
#' @param x An object to be evaluated.
#' @noRd
is_cff <- function(x) {
  inherits(x, "cff")
}

#' Check whether an object is a `CITATION.cff` file
#' @param x An object to be evaluated.
#' @noRd
is_cff_file <- function(x) {
  src <- detect_x_source(x)
  val <- src == "cff_citation"
  val
}

#' Check whether a URL is from GitHub
#' @param x An object to be evaluated.
#' @noRd
is_github <- function(x) {
  res <- isTRUE(grep("^http[a-z]://github.com/", x["repository-code"]) == 1)

  res
}

#' Check whether an object has names
#' @param x An object to be evaluated.
#' @noRd
is_named <- function(x) {
  !is.null(names(x))
}
