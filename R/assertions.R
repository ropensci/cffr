#' Check if a string is an email
#' @noRd
is.email <- function(email) {
  if (is.null(email)) {
    return(FALSE)
  }

  x <- grepl("@", email)
  x
  
}

#' Check if a string is an url
#' @noRd
is.url <- function(url) {
  if (is.null(url)) {
    return(FALSE)
  }

  x <- grepl("^http", url)
  x
  
}

#' Check if a string contains a substring
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
#' @noRd
is.cff <- function(x) {
  if (unique("cff" %in% class(x))) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Error if it is not a cff file
#' @noRd
stopifnotcff <- function(x) {
  if (tools::file_ext(x) != "cff") {
    stop(x, " is not a .cff file or a 'cff' object",
      call. = FALSE
    )
  }
}

#' Error if file doesn't exists
#' @noRd
stopifnotexists <- function(x) {
  if (!file.exists(x)) {
    stop("File ", x, " doesn't exists",
      call. = FALSE
    )
  }
}
