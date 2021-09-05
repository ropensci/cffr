#' Parse a person to `cffr`
#'
#' Parse a person or string to a valid format for a `CITATION.cff` file.
#'
#' @seealso [cff_create()], [utils::person()]
#'
#' @export
#'
#' @family parsers
#'
#' @param person A `person` object or a character coercible to `person`. See
#'   [utils::person()].
#'
#' @return A `cffr` object ready to be used on [cff_create()].
#'
#' @details
#' This is a helper function designed to help on adding or 
#' replacing the auto-generated authors of the package. See **Examples**.
#'
#' @examples
#' # Parse a person object
#'
#' cff_parse_person(person(
#'   given = "First",
#'   family = "Author",
#'   role = c("aut", "cre"),
#'   email = "first.last@example.com",
#'   comment = c(
#'     ORCID = "0000-0001-8457-4658",
#'     affiliation = "An affiliation"
#'   )
#' ))
#'
#' # Parse a string
#'
#' cff_parse_person("Julio Iglesias <fake@email.com>")
cff_parse_person <- function(person) {
  person <- as.person(person)

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
  parsed_person <- as.cffr(parsed_person)
  parsed_person
}


# Mapped to Maintainer

#' @noRd
parse_desc_contacts <- function(pkg) {
  persons <- as.person(pkg$get_authors())

  # Extract creators only
  contact <- persons[sapply(persons, function(x) {
    "cre" %in% x$role
  })]

  parse_all_contacts <- lapply(contact, cff_parse_person)
  parse_all_contacts <- unique(parse_all_contacts)
  parse_all_contacts
}

# Mapped to persons with roles "aut","cre"

#' @noRd
parse_desc_authors <- function(pkg) {
  # This extracts all the persons
  persons <- as.person(pkg$get_authors())

  # Extract authors and creators only - to be reviewed if this is logic is correct or
  # all persons should be included
  authors <- persons[sapply(persons, function(x) {
    "aut" %in% x$role || "cre" %in% x$role
  })]

  parse_all_authors <- lapply(authors, cff_parse_person)
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
