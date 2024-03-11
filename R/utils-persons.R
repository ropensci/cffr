bibtex_pers_von_last_first_jr <- function(x) {
  # Protect commas on brackets to avoid error on splitting
  protected <- gsub(",(?![^\\}]*(\\{|$))", "@comma@",
    x,
    perl = TRUE
  )

  parts_comma <- trimws(unlist(strsplit(protected, ",")))

  # Unprotect
  parts_comma <- gsub("@comma@", ",", parts_comma)

  if (length(parts_comma) == 3) {
    given <- parts_comma[3]
  } else {
    # Case jean de la fontaine, junior,
    given <- NULL
  }

  # Junior part
  jr <- parts_comma[2]


  # Now it is the same than in bibtex_person_von_last_first

  # Now identify the von part

  # Protect spaces between braces before splitting
  protected <- gsub("\\s(?![^\\}]*(\\{|$))", "@blank@",
    parts_comma[1],
    perl = TRUE
  )

  parts <- unlist(strsplit(protected, " "))

  # Unprotect
  parts <- gsub("@blank@", " ", parts)

  # Start building
  # Assess casing

  is_upper <- vapply(parts,
    FUN.VALUE = logical(1),
    function(y) {
      case <- substr(y, 1, 1)
      if (case == toupper(case)) {
        TRUE
      } else {
        FALSE
      }
    }
  )

  # Family should be always provided
  family <- parts[length(parts)]

  upper <- is_upper[setdiff(names(is_upper), family)]

  # Get more family parts
  invert <- rev(upper)
  # Then need to get sequentally the family
  for (i in seq_len(length(invert))) {
    if (invert[i] == FALSE) break
    family <- c(names(invert[i]), family)
  }

  # The remaining is von
  von <- setdiff(names(is_upper), family)

  if (length(von) == 0) von <- NULL

  # Compose final list to be pased to person()

  # Last clean up
  end_list <- list(
    given = given,
    von = von,
    family = family,
    jr = jr
  )

  return(end_list)
}

bibtex_pers_von_last_first <- function(x) {
  # Protect commas on brackets to avoid error on splitting
  protected <- gsub(",(?![^\\}]*(\\{|$))", "@comma@",
    x,
    perl = TRUE
  )

  parts_comma <- trimws(unlist(strsplit(protected, ",")))

  # Unprotect
  parts_comma <- gsub("@comma@", ",", parts_comma)


  if (length(parts_comma) == 2) {
    given <- parts_comma[2]
  } else {
    # Case jean de la fontaine,
    given <- NULL
  }


  # Now identify the von part

  # Protect spaces between braces before splitting
  protected <- gsub("\\s(?![^\\}]*(\\{|$))", "@blank@",
    parts_comma[1],
    perl = TRUE
  )

  parts <- unlist(strsplit(protected, " "))

  # Unprotect
  parts <- gsub("@blank@", " ", parts)

  # Start building
  # Assess casing

  is_upper <- vapply(parts,
    FUN.VALUE = logical(1),
    function(y) {
      case <- substr(y, 1, 1)
      if (case == toupper(case)) {
        TRUE
      } else {
        FALSE
      }
    }
  )

  # Family should be always provided
  family <- parts[length(parts)]

  upper <- is_upper[setdiff(names(is_upper), family)]

  # Get more family parts
  invert <- rev(upper)
  # Then need to get sequentally the family
  for (i in seq_len(length(invert))) {
    if (invert[i] == FALSE) break
    family <- c(names(invert[i]), family)
  }

  # The remaining is von
  von <- setdiff(names(is_upper), family)

  if (length(von) == 0) von <- NULL

  # Compose final list to be pased to person()

  # Last clean up
  end_list <- list(
    given = given,
    von = von,
    family = family
  )

  return(end_list)
}




bibtex_pers_first_von_last <- function(x) {
  # Based on Tame the BeaST
  # http://tug.ctan.org/info/bibtex/tamethebeast/ttb_en.pdf
  # Testing
  # string                  -> "First"        "von"         "Last"
  # jean de la fontaine     -> ""             "jean de la"  "fontaine"
  # Jean de la fontaine     -> "Jean"         "de la"       "fontaine"
  # Jean {de} la fontaine   -> "Jean de"      "la"          "fontaine"
  # jean {de} {la} fontaine -> ""             "jean"        "de la fontaine"
  # Jean {de} {la} fontaine -> "Jean de la"   ""            "fontaine"
  # Jean De La Fontaine     -> "Jean De La"   ""            "Fontaine"
  # jean De la Fontaine     -> ""             "jean De la"  "Fontaine"
  # Jean de La Fontaine     -> "Jean"         "de"          "La Fontaine"

  # Protect spaces between braces before splitting
  x <- gsub("\\s(?![^\\}]*(\\{|$))", "@blank@",
    x,
    perl = TRUE
  )

  # Collapse blanks
  x <- gsub("\\s+", " ", x)

  parts <- trimws(unlist(strsplit(x, " ")))


  # Unprotect
  parts <- gsub("@blank@", " ", parts)



  # Start building
  # Assess casing

  is_upper <- vapply(parts,
    FUN.VALUE = logical(1),
    function(y) {
      case <- substr(y, 1, 1)
      if (case == toupper(case)) {
        TRUE
      } else {
        FALSE
      }
    }
  )

  # Family should be always provided
  family <- parts[length(parts)]


  # Get if there is a mix of casings on the remaining parts
  upper <- is_upper[setdiff(names(is_upper), family)]
  mix <- (length(unique(upper)) == 1)


  if (!all(mix, upper)) {
    invert <- rev(upper)
    # Then need to get sequentally the family
    for (i in seq_len(length(invert))) {
      if (invert[i] == FALSE) break
      family <- c(names(invert[i]), family)
    }
  }

  # Clean again
  upper <- is_upper[setdiff(names(is_upper), family)]


  # von part
  # Detect casing index on remaining parts
  von_assess <- as.integer(which(upper == FALSE))

  # von
  # if no lenght then no von
  if (length(von_assess) == 0) {
    von <- NULL
  } else {
    von <- names(upper[seq(min(von_assess), max(von_assess))])
  }


  # get remaining part, it should be First
  given <- names(upper[setdiff(names(upper), von)])

  # Compose final list to be pased to person()

  # Last clean up
  end_list <- list(
    given = given,
    von = von,
    family = family
  )

  return(end_list)
}

validate_cff_person_fields <- function(person_cff) {
  # Entity of person

  # Guess entity or person
  is_entity <- as.character("name" %in% names(person_cff))

  # Keep only valid tags - Would depend on entity or person
  definition <- switch(is_entity,
    "TRUE" = cff_schema_definitions_entity(),
    cff_schema_definitions_person()
  )

  person_cff <- person_cff[names(person_cff) %in% definition]

  # Duplicates removed
  person_cff <- person_cff[!duplicated(names(person_cff))]

  person_cff
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
  comm_cff <- as.list(person$comment)
  names(comm_cff) <- tolower(names(comm_cff))
  nms_com <- names(comm_cff)
  comment_as_text <- tolower(clean_str(comm_cff))

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
    comm_cff <- list()

    comm_cff$orcid <- clean_str(orcid)
    comm_cff$website <- clean_str(web)
  }

  # Add url to orcid if not present
  # Get leading invalid urls

  if (!is.null(comm_cff$orcid)) {
    orcid <- gsub("^orcid.org/", "", comm_cff$orcid)
    orcid <- gsub("^https://orcid.org/", "", orcid)
    orcid <- gsub("^http://orcid.org/", "", orcid)

    comm_cff$orcid <- paste0("https://orcid.org/", orcid)
  }

  # Add website
  web <- comm_cff$website

  if (!is.null(web)) {
    comm_cff$website <- clean_str(web[is_url(web)])
  }

  # Add also email
  # Check if several mails (MomTrunc 6.0)
  look_emails <- c(unlist(person$email), comm_cff$email)
  valid_emails <- unlist(lapply(look_emails, is_email))
  email <- look_emails[valid_emails][1]

  # Final list
  fin_list <- c(
    list(email = NULL),
    comm_cff["email" != names(comm_cff)]
  )
  fin_list$email <- clean_str(email)

  fin_list
}
