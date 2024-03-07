#' Check if a string is an email
#' @param email The string to be evaluated
#' @noRd
is_email <- function(email) {
  if (is.null(email)) {
    return(FALSE)
  }

  email <- trimws(as.character(email))

  # See CFF  validation schema
  x <- grepl("^[\\S]+@[\\S]+\\.[\\S]{2,}$", email,
    ignore.case = TRUE, perl = TRUE
  )
  x
}

#' Check if a string is an url
#' @param url The url to be evaluated
#' @noRd
is_url <- function(url) {
  if (is.null(url)) {
    return(FALSE)
  }

  x <- grepl("^(https|http|ftp|sftp)://.+", url)
  x
}

#' Check if a string contains a substring
#'
#' @param x string
#' @param sub subtring to be evaluated
#' @noRd
is_substring <- function(x, sub) {
  if (is.null(x)) {
    return(FALSE)
  }

  if (isTRUE(grep(sub, x) == 1)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Check if a object is `cff`
#' @param x object to be evaluated
#' @noRd
is_cff <- function(x) {
  inherits(x, "cff")
}

#' Check if a object is cff file
#' @param x object to be evaluated
#' @noRd
is_cff_file <- function(x) {
  src <- detect_x_source(x)
  return(src == "cff_citation")
}

#' Check if an url is from GitHub
#' @param x object to be evaluated
#' @noRd
is_github <- function(x) {
  res <- isTRUE(grep(
    "^http[a-z]://github.com/",
    x["repository-code"]
  ) == 1)

  return(res)
}

#' Check if `x` has names
#' @param x object to be evaluated
#' @noRd
is_named <- function(x) {
  !is.null(names(x))
}
