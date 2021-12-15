#' Parse a person to `cff`
#'
#' Parse a person or string to a valid format for a `CITATION.cff` file.
#'
#' @seealso [cff_create()], `vignette("cffr", "cffr")`, [utils::person()]
#'
#' @export
#'
#' @family parsers
#'
#' @param person See **Details**.
#'
#' @return A [`cff`] object ready to be used on [cff_create()].
#'
#' @details
#' This is a helper function designed to help on adding or
#' replacing the auto-generated authors of the package. See **Examples**.
#'
#' `person` could be:
#'
#' * For `cff_parse_person()`: A `person` object or a character coercible to
#'  `person`. See [person()] for details.
#' * For `cff_parse_person_bibtex()`: A string with the definition of an author
#'  or several authors, using the standard BiBTeX notation. See Markey (2007)
#'  for a full explanation.
#'
#' @references
#' Patashnik O (1988). "BIBTEXTING."
#' <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' Markey N (2007). "Tame the BeaST" *The B to X of BibTEX*, version 1.4.
#' <http://tug.ctan.org/info/bibtex/tamethebeast/ttb_en.pdf>.
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

  # Special case for Bioconductor

  if (is.substring(person$given, "Bioconductor")) {
    person <- person(
      given = paste(
        clean_str(person$given),
        clean_str(person$family)
      ),
      email = person$email,
      role = person$role,
      comment = person$comment
    )
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

#' @rdname cff_parse_person
#'
#' @export
#'
#' @examples
#'
#' # Using bibtex style
#'
#' x <- "Frank Sinatra and Dean Martin and Davis, Jr., Sammy and Joey Bishop"
#'
#' cff_parse_person_bibtex(x)
#'
#' cff_parse_person_bibtex("Herbert von Karajan")
cff_parse_person_bibtex <- function(person) {
  person <- trimws(person)

  # Protect and on brackets
  # Lower
  protected <- gsub("(and)(?![^\\}]*(\\{|$))", "@nd@",
    person,
    perl = TRUE
  )

  # upper
  protected <- gsub("AND(?![^\\}]*(\\{|$))", "@ND@",
    protected,
    perl = TRUE
  )


  auths <- unlist(strsplit(protected, " and | AND "))

  # Unprotec
  auths_un <- gsub("@nd@", "and", auths)
  auths_un <- gsub("@ND@", "AND", auths_un)


  bibtex_auths <- lapply(auths_un, as_person_bibtex)


  end <- lapply(bibtex_auths, function(x) {
    if (is.null(x$given)) {
      ent <- c(x$von, x$family, x$jr)
      ent <- clean_str(paste(ent, collapse = " "))

      l <- list(name = ent)
      l <- as.cff(l)
    } else {
      l <- list(
        "family-names" = x$family,
        "given-names" = x$given,
        "name-particle" = x$von,
        "name-suffix" = x$jr
      )

      l <- as.cff(l)
    }
  })

  # Handle single author
  if (length(end) == 1) {
    end <- end[[1]]
  } else {
    # Need the class
    class(end) <- "cff"
  }

  return(end)
}
