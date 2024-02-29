#' Create a person with the corresponding [`cff`][cff-class] structure
#'
#' @description
#'
#' Create a `person` or `entity` as defined by the
#'
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Citation File Format schema]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' [cff_create_person()] can convert the following objects:
#' - Objects with class `person` as provided by [utils::person()].
#' - A `character` string with the definition of an author or several authors,
#'   using the standard BibTeX notation. See Markey (2007) for a full
#'   explanation.
#'
#' @seealso
#' Examples in `vignette("cffr", "cffr")` and [utils::person()].
#'
#' @export
#' @rdname cff_create_person
#' @name cff_create_person
#' @order 1
#'
#' @family coercing
#'
#' @param person It can be either:
#'   - A `person` or list of `person` object created with [utils::person()].
#'   - A `character` object or vector representing a person or persons.
#'   See **Examples**.
#'
#' @return
#' `cff_create_person()` returns A list of persons or entities with class `cff`
#' converted to the
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Citation File Format schema]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' @details
#'
#' `cff_create_person()` uses a custom algorithm that tries to break a name
#' as explained in Section 11 of "Tame the BeaST" (Markey, 2007):
#'  - `First von Last`
#'  - `von Last, First`
#'  - `von Last, Jr, First`
#'
#'  `First` is mapped to the CFF field `given-names`, `von` to `name-particle`,
#'  `Last` to `family-names` and `Jr` to `name-suffix`.
#'
#'  In the case of entities, the whole `character` would be mapped to `name`.
#'  It is a good practice to "protect" entity's names with `{}`:
#'
#' ```{r child = "man/chunks/cff_create_person.Rmd"}
#' ```
#' `cff_create_person()` would try to add as many information as possible. On
#' `character` string coming from [`format(person())`][utils::person()] the
#' email and the ORCID would be gathered as well.
#'
#' @references
#' - Patashnik, Oren. "BIBTEXTING" February 1988.
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' - Markey, Nicolas. "Tame the BeaST"
#'   *The B to X of BibTeX, Version 1.4* (October 2007).
#'   <https://osl.ugr.es/CTAN/info/bibtex/tamethebeast/ttb_en.pdf>.
#'
#' See **Examples** for more information.
#'
#'
#' @examples
#' # Create a person object
#' a_person <- person(
#'   given = "First", family = "Author",
#'   role = c("aut", "cre"),
#'   email = "first.last@example.com", comment = c(
#'     ORCID = "0000-0001-8457-4658",
#'     affiliation = "An affiliation"
#'   )
#' )
#'
#' a_person
#'
#' cff_person <- cff_create_person(a_person)
#'
#' cff_person
#'
#' # Back to person object with S3 Method
#' as.person(cff_person)
#'
#' # Parse a string
#' a_str <- paste0(
#'   "Julio Iglesias <fake@email.com> ",
#'   "(<https://orcid.org/0000-0001-8457-4658>)"
#' )
#' cff_create_person(a_str)
#'
#' # Several persons
#' persons <- c(person("Clark", "Kent"), person("Lois", "Lane"))
#'
#' cff_create_person(persons)
#'
#' # Or you can use BibTeX style if you prefer
#'
#' x <- "Frank Sinatra and Dean Martin and Davis, Jr., Sammy and Joey Bishop"
#'
#' cff_create_person(x)
#'
#' cff_create_person("Herbert von Karajan")
cff_create_person <- function(person) {
  hint <- guess_hint(person)

  verbopt <- getOption("cffr_message_verbosity", "none")
  if (verbopt == "debug") {
    cli::cli_alert_info(
      "In {.fn cff_create_person} using internal for {.val {hint}}."
    )
  }

  if (hint == "txt") {
    # Need to split the character
    person_split <- split_txt_persons(person)
    the_obj <- lapply(person_split, create_person_from_txt)
  } else {
    the_obj <- lapply(person, create_person_from_r)
  }

  if (!length(the_obj) > 0) {
    return(NULL)
  }
  the_obj <- new_cff(the_obj)
  the_obj
}

guess_hint <- function(person) {
  # On length 0 use "person"
  if (length(person) == 0) {
    return("person")
  }
  if (inherits(person, "person")) {
    return("person")
  }

  # Rest of cases "txt"
  return("txt")
}

create_person_from_r <- function(person) {
  person <- as.person(person)

  if (length(person) == 0) {
    return(NULL)
  }

  # Special case for Bioconductor

  if (is_substring(person$given, "Bioconductor")) {
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

  # Special case for R Core Team
  if (all(
    is_substring(clean_str(person$given), "R Core"),
    is_substring(person$family, "Team")
  )) {
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

  # Create a text version of the person, would be treated as bibtex

  if (is_entity) {
    as_bib_text <- paste(c(person$family, person$given), collapse = " ")
    # And protect it
    as_bib_text <- paste0("{", as_bib_text, "}")
  } else {
    # Use von Family, Junior, Given
    # Protect given
    giv <- paste0(person$given, collapse = " ")
    giv <- paste0("{", giv, "}")
    as_bib_text <- paste0(c(person$family, giv), collapse = ", ")
  }

  parsed_person <- create_person_from_txt(as_bib_text)
  parsed_comments <- extract_person_comments(person)

  # Add comments
  parsed_person <- c(parsed_person, parsed_comments)

  # Validate fields
  parsed_person <- validate_cff_person_fields(parsed_person)
  parsed_person
}

create_person_from_txt <- function(as_bib_text) {
  # Can extract comments as R
  # Locate comment with R format.person default pattern
  # 'first last [role] <e@mail> (comment)
  # but we protect this if inside brackets
  comments_pattern <- "<|>|\\(|\\)|\\[|\\]"

  protected <- gsub(paste0("(", comments_pattern, ")(?![^\\}]*(\\{|$))"),
    "0", as_bib_text,
    perl = TRUE
  )

  start_comment <- min(unlist(regexpr(comments_pattern, protected)))

  if (start_comment > 0) {
    # has comments
    person_only <- trimws(substr(as_bib_text, 1, start_comment - 1))
    comment_only <- trimws(substr(
      as_bib_text, start_comment,
      nchar(as_bib_text)
    ))

    # Fake a person object to extract comments
    fake_person <- paste0("{Fake} ", comment_only)
    parsed_comments <- extract_person_comments(fake_person)
  } else {
    # Does not
    person_only <- as_bib_text
    parsed_comments <- list()
  }



  # Now extract structure for person_only string
  # It may be one of:
  # A. Given von Family
  # B. von Family, Given
  # C. von Family, Junior, Given

  # Protect commas on brackets to avoid error counting
  protected <- gsub(",(?![^\\}]*(\\{|$))", "@comma@",
    person_only,
    perl = TRUE
  )

  commas <- as.character(length(grep(",", unlist(strsplit(protected, "|")))))

  # Assign the corresponding fun
  bibtex_name_str <- switch(commas,
    # Case A
    "0" = bibtex_pers_first_von_last(person_only),
    # Case B
    "1" = bibtex_pers_von_last_first(person_only),
    # Case C
    "2" = bibtex_pers_von_last_first_jr(person_only),
    # Empty
    list(family = paste(person_only, collapse = " "))
  )

  # Clean
  bibtex_name_str <- lapply(bibtex_name_str, function(z) {
    if (is.null(z)) {
      return(NULL)
    }
    if (any((is.na(z) | z == ""))) {
      return(NULL)
    }

    cleaned <- gsub("\\{|\\}", "", z)
    clean_str(cleaned)
  })

  # Final parsed person
  if (is.null(bibtex_name_str$given)) {
    ent <- c(bibtex_name_str$von, bibtex_name_str$family, bibtex_name_str$jr)
    ent <- clean_str(paste(ent, collapse = " "))
    parsed_person <- list(name = ent)
  } else {
    parsed_person <- list(
      "family-names" = bibtex_name_str$family,
      "given-names" = bibtex_name_str$given,
      "name-particle" = bibtex_name_str$von,
      "name-suffix" = bibtex_name_str$jr
    )
  }

  parsed_person <- parsed_person[!lengths(parsed_person) == 0]

  # Add comments
  parsed_person <- c(parsed_person, parsed_comments)

  # Validate fields
  parsed_person <- validate_cff_person_fields(parsed_person)
  parsed_person
}

split_txt_persons <- function(person) {
  person <- trimws(person)
  person <- paste0(person, collapse = " and ")

  # Remove role on [] as it comes from print.person by default
  # We don't use it here
  person <- gsub("\\[[^()]*\\]", "", person)

  # Protect 'and' on brackets {}
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

  # Do the same for 'and' in comments "()" as provided by print.person
  # Lower
  protected <- gsub("(and)(?![^\\)]*(\\(|$))", "@nd@",
    protected,
    perl = TRUE
  )

  # upper
  protected <- gsub("AND(?![^\\)]*(\\(|$))", "@ND@",
    protected,
    perl = TRUE
  )

  # Do the same for 'and' in "<>". These are email, should never happen
  # Lower
  protected <- gsub("(and)(?![^>]*(<|$))", "@nd@",
    protected,
    perl = TRUE
  )

  # upper
  protected <- gsub("AND(?![^>]*(<|$))", "@ND@",
    protected,
    perl = TRUE
  )

  auths <- unlist(strsplit(protected, " and | AND "))

  # Unprotec
  auths_un <- gsub("@nd@", "and", auths)
  auths_un <- gsub("@ND@", "AND", auths_un)

  auths_un
}

extract_person_comments <- function(person) {
  # Ensure person type
  person <- as.person(person)

  # Extract from comments
  parsed_comments <- as.list(person$comment)
  names(parsed_comments) <- tolower(names(parsed_comments))
  nms_com <- names(parsed_comments)
  comment_as_text <- tolower(clean_str(parsed_comments))

  # Special case when coerced from text, only can extract orcid and web
  if (all(
    any(is.na(nms_com), length(nms_com) == 0),
    length(comment_as_text > 0)
  )
  ) {
    split_comments <- unlist(strsplit(comment_as_text, ",| |<|>"))

    # Guess that seems to be a web
    url_comment <- split_comments[is_url(split_comments)]

    # guess orcid
    orcid <- url_comment[grepl("orcid.org/", url_comment)]

    # Get the first non-orcid url
    web <- url_comment[!grepl("orcid.org/", url_comment)][1]

    # Reset comment list
    parsed_comments <- list()

    parsed_comments$orcid <- clean_str(orcid)
    parsed_comments$website <- clean_str(web)
  }

  # Add url to orcid if not present
  # Parse leading invalid urls

  if (!is.null(parsed_comments$orcid)) {
    orcid <- gsub("^orcid.org/", "", parsed_comments$orcid)
    orcid <- gsub("^https://orcid.org/", "", orcid)
    orcid <- gsub("^http://orcid.org/", "", orcid)

    parsed_comments$orcid <- paste0("https://orcid.org/", orcid)
  }

  # Add website
  web <- parsed_comments$website

  if (!is.null(web)) {
    parsed_comments$website <- clean_str(web[is_url(web)])
  }

  # Add also email
  # Check if several mails (MomTrunc 6.0)
  valid_emails <- unlist(lapply(person$email, is_email))
  email <- person$email[valid_emails][1]

  # Final list
  fin_list <- c(list(email = NULL), parsed_comments)
  fin_list$email <- clean_str(email)

  fin_list
}


validate_cff_person_fields <- function(parsed_person) {
  # Entity of person

  # Guess entity or person
  is_entity <- as.character("name" %in% names(parsed_person))

  # Keep only valid tags - Would depend on entity or person
  definition <- switch(is_entity,
    "TRUE" = cff_schema_definitions_entity(),
    cff_schema_definitions_person()
  )

  parsed_person <- parsed_person[names(parsed_person) %in% definition]

  parsed_person
}
