#' Check if a string is an email
#' @param email The string to be evaluated
#' @noRd
is.email <- function(email) {
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
is.url <- function(url) {
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
is.substring <- function(x, sub) {
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
is.cff <- function(x) {
  if (unique("cff" %in% class(x))) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Check if a object is cff
#' @param x object to be evaluated
#' @noRd
is.github <- function(x) {
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
  if (is.cff(x)) {
    return(invisible())
  }

  if (tools::file_ext(x) != "cff") {
    stop(x, " is not a .cff file or a 'cff' object",
      call. = FALSE
    )
  }
}

#' Error if file doesn't exists
#' @param x file to be evaluated
#' @noRd
stopifnotexists <- function(x) {
  if (!file.exists(x)) {
    stop("File ", x, " doesn't exists",
      call. = FALSE
    )
  }
}
