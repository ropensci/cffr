parse_person <- function(person) {

  # Guess if entity of person.
  is_entity <- is.null(person$family) || is.null(person$given)

  # Create my list
  parsed_person <- list()

  if (is_entity) {
    parsed_person$name <- clean_str(c(person$family, person$given))
  } else {
    parsed_person$"family-names" <- clean_str(person$family)
    parsed_person$"given-names" <- clean_str(person$given)
  }

  parsed_person$email <- clean_str(clean_email(person$email))

  # Extract from comments
  parsed_comments <- as.list(person$comment)
  names(parsed_comments) <- tolower(names(parsed_comments))

  # Extract for comments only what is not already there
  parsed_comments <- parsed_comments[setdiff(
    names(parsed_comments),
    names(parsed_person)
  )]


  # Add url to orcid if not present
  if (length(grep("https://orcid.org/", parsed_comments$orcid)) == 0 &&
    !is.null(parsed_comments$orcid)
  ) {
    parsed_comments$orcid <- paste0(
      "https://orcid.org/",
      parsed_comments$orcid
    )
  }

  # Add comments
  parsed_person <- c(parsed_person, parsed_comments)

  # Keep only valid tags - Would depend on entity or person
  definition <- if (is_entity) {
    cff_schema_definitions_entity()
  } else {
    cff_schema_definitions_person()
  }
  parsed_person <- parsed_person[names(parsed_person) %in%
    definition]

  parsed_person <- drop_null(parsed_person)
  parsed_person
}


# Mapped to Maintainer
parse_desc_contacts <- function(pkg) {
  persons <- as.person(pkg$get_authors())

  # Extract creators only
  # all persons should be included
  contact <- persons[sapply(persons, function(x) {
    "cre" %in% x$role
  })]

  parse_all_contacts <- lapply(contact, parse_person)
  parse_all_contacts <- unique(parse_all_contacts)
  parse_all_contacts
}

# Mapped to persons with roles "aut","cre"
parse_desc_authors <- function(pkg) {
  # This extracts all the persons
  persons <- as.person(pkg$get_authors())

  # Extract authors and creators only - to be reviewed if this is logic is correct or
  # all persons should be included
  authors <- persons[sapply(persons, function(x) {
    "aut" %in% x$role || "cre" %in% x$role
  })]

  parse_all_authors <- lapply(authors, parse_person)
  parse_all_authors <- unique(parse_all_authors)

  parse_all_authors
}

clean_email <- function(email) {
  if (isTRUE(grep("@", email) == 1)) {
    return(email)
  } else {
    return(NULL)
  }
}
