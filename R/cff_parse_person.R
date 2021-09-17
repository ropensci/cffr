#' Parse a person to `cff`
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
#' @return A [`cff`] object ready to be used on [cff_create()].
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
#'
#' # Several persons
#' persons <- c(person("Clark", "Kent"), person("Lois", "Lane"))
#'
#' cff_parse_person(persons)
cff_parse_person <- function(person) {
  person <- as.person(person)

  if (length(person) > 1) {
    person <- lapply(person, cff_parse_person)
    class(person) <- "cff"
    return(person)
  }

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

  email <- ifelse(is.email(person$email), person$email, NA)
  parsed_person$email <- clean_str(email)

  # Extract from comments
  parsed_comments <- as.list(person$comment)
  names(parsed_comments) <- tolower(names(parsed_comments))

  # Extract for comments only what is not already there
  parsed_comments <- parsed_comments[setdiff(
    names(parsed_comments),
    names(parsed_person)
  )]


  # Add url to orcid if not present
  # Parse leading invalid urls

  if (!is.null(parsed_comments$orcid)) {
    orcid <- gsub("^orcid.org/", "", parsed_comments$orcid)
    orcid <- gsub("^https://orcid.org/", "", orcid)
    orcid <- gsub("^http://orcid.org/", "", orcid)

    parsed_comments$orcid <- paste0(
      "https://orcid.org/",
      orcid
    )
  }

  # Add website
  web <- parsed_comments$website

  if (!is.null(web)) {
    parsed_comments$website <- clean_str(web[is.url(web)])
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

  parsed_person <- as.cff(parsed_person)
  parsed_person
}
