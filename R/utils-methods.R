# Utils for authors----
make_r_person <- function(x) {
  checknames <- grepl("^name$|given-names|family-names", names(x))
  if (!isTRUE(any(checknames))) {
    return(person())
  }
  # Prepare list
  x <- unclass(x)

  # Family is special key
  # R Core uses for entity 'given', so do I
  # see in citation()
  is_entity <- any(grepl("^name$", names(x)))
  if (is_entity) {
    given <- clean_str(x[["name"]])
    # Extra protect
    family <- NULL
  } else {
    given <- clean_str(x[["given-names"]])
    family <- paste(
      clean_str(x[["name-particle"]]),
      clean_str(x[["family-names"]])
    )
    # Add suffix with comma
    family <- paste0(c(family, clean_str(x[["name-suffix"]])), collapse = ", ")
    family <- clean_str(family)
  }

  role <- clean_str(x$role)

  # Make comments
  x_comments <- x[!names(x) %in% c(
    "family-names", "given-names", "name",
    "name-particle", "name-suffix", "email", "role"
  )]

  x_comments <- lapply(x_comments, clean_str)
  x_comments <- unlist(x_comments, use.names = TRUE)

  # Prepare ORCID
  x_comments <- gsub("^https://orcid.org/", "", x_comments)
  x_comments <- gsub("^http://orcid.org/", "", x_comments)
  nm <- gsub("orcid", "ORCID", names(x_comments), fixed = TRUE)
  names(x_comments) <- nm

  pers_lst <- list(
    given = given,
    family = family,
    role = role,
    email = clean_str(x$email),
    comment = x_comments
  )


  do.call(person, pers_lst)
}
