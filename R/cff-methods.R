#' Print Values
#'
#' @noRd
#' @export
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}

#' Combine Values into a Vector or List
#'
#' @source
#' Based on `?c.person` \CRANpkg{utils}.
#'
#' <https://github.com/wch/r-source/blob/trunk/src/library/utils/R/citation.R>
#'
#' @noRd
#' @export
c.cff <- function(..., recursive = FALSE) {
  args <- list(...)
  args <- lapply(args, unclass)
  rval <- do.call("c", args)
  class(rval) <- "cff"
  rval
}


#' Coerce to a Data Frame
#'
#' @noRd
#' @export
as.data.frame.cff <- function(x, row.names = NULL, optional = FALSE, ...) {
  # If the cff is unnamed is a list of persons/references
  if (is.null(names(x))) {
    the_df <- cff_list_to_df(x)
  } else {
    the_df <- cff_to_df(x)
  }

  the_df <- as.data.frame(the_df,
    row.names = row.names, optional = optional,
    ...
  )

  return(the_df)
}

#' Persons
#'
#' @noRd
#' @export
as.person.cff <- function(x) {
  # If single enclose on a list
  is_single <- any(grepl("^name$|^given-names|^family-names", names(x)))

  if (is_single) x <- list(x)


  pers <- lapply(x, make_r_person)

  # If not all extracted, malformed, return null
  if (!all(lengths(pers) > 0)) {
    return(person())
  }
  do.call(c, pers)
}

#' Head
#'
#' @noRd
#' @export
head.cff <- function(x, n = 6L, ...) {
  as.cff(NextMethod())
}

#' Tail
#'
#' @noRd
#' @export
tail.cff <- function(x, n = 6L, ...) {
  as.cff(NextMethod())
}

make_r_person <- function(x) {
  if (is.null(names(x))) {
    return(person())
  }
  checknames <- grepl("^name$|given-names|family-names", names(x))
  if (!isTRUE(any(checknames))) {
    return(person())
  }
  # Prepare list
  # Family is special key
  fam1 <- clean_str(x$name)
  fam2 <- clean_str(
    paste(
      clean_str(x$`name-particle`), clean_str(x$`family-names`),
      clean_str(x$`name-suffix`)
    )
  )

  given <- clean_str(x$`given-names`)
  family <- clean_str(c(fam1, fam2))

  # Make comments
  x_comments <- x[!names(x) %in% c(
    "family-names", "given-names",
    "name-particle", "name-suffix", "email"
  )]

  x_comments <- lapply(x_comments, clean_str)
  x_comments <- unlist(x_comments, use.names = TRUE)

  # Prepare ORCID
  x_comments <- gsub("^https://orcid.org/", "", x_comments)
  nm <- gsub("orcid", "ORCID", names(x_comments), fixed = TRUE)
  names(x_comments) <- nm

  pers_list <- list(
    given = given,
    family = family,
    email = clean_str(x$email),
    comment = x_comments
  )


  do.call(person, pers_list)
}
