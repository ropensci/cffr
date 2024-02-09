#' Check if a string is an email
#' @param email The string to be evaluated
#' @noRd
is_email <- function(email) {
  if (is.null(email)) {
    return(FALSE)
  }

  # See https://www.nicebread.de/validating-email-adresses-in-r/
  x <- grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>",
    as.character(email),
    ignore.case = TRUE
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

  x <- grepl("^http://|^https://|^ftp://|sftp://", url)
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

#' Check if a object is cff
#' @param x object to be evaluated
#' @noRd
is_cff <- function(x) {
  if (inherits(x, "cff")) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Check if a object is cff file
#' @param x object to be evaluated
#' @noRd
is_cff_file <- function(x) {
  if (!inherits(x, "character")) {
    return(FALSE)
  }

  if (tools::file_ext(x) != "cff") {
    return(FALSE)
  }

  stopifnotexists(x)
  return(TRUE)
}

#' Check if a object is cff
#' @param x object to be evaluated
#' @noRd
is_github <- function(x) {
  res <- isTRUE(grep(
    "^http[a-z]://github.com/",
    x["repository-code"]
  ) == 1)

  return(res)
}

#' Error if it is not a cff file
#' @param x file to be evaluated
#' @noRd
stopifnotcff <- function(x) {
  if (is_cff(x)) {
    return(invisible())
  }

  # x should be character at least
  if (!inherits(x, "character")) {
    cli::cli_abort(
      "{.var x} is an object of class {.cls {class(x)}}, not {.cls cff}."
    )
  }

  if (tools::file_ext(x) != "cff") {
    cli::cli_abort(
      "{.var x} is not a {.file *.cff} file"
    )
  }
}

#' Error if file doesn't exists
#' @param x file to be evaluated
#' @noRd
stopifnotexists <- function(x) {
  if (!file.exists(x)) {
    cli::cli_abort("{.file {x}} doesn't exist")
  }
  return(invisible(NULL))
}
