bibtex_pers_von_last_first_jr <- function(x) {
  parts_comma <- bibtex_split_protected(x, ",", "@comma@")

  if (length(parts_comma) == 3) {
    given <- parts_comma[3]
  } else {
    # Case: jean de la fontaine, junior,
    given <- NULL
  }

  # Junior part.
  jr <- parts_comma[2]

  # From here, it is the same as in bibtex_person_von_last_first().

  # Identify the von part.
  family_von <- bibtex_family_von(parts_comma[1])

  # Compose the final list to pass to person().

  # Final cleanup.
  end_list <- c(list(given = given), family_von, list(jr = jr))

  end_list
}

bibtex_pers_von_last_first <- function(x) {
  parts_comma <- bibtex_split_protected(x, ",", "@comma@")

  if (length(parts_comma) == 2) {
    given <- parts_comma[2]
  } else {
    # Case: jean de la fontaine,
    given <- NULL
  }

  # Identify the von part.
  family_von <- bibtex_family_von(parts_comma[1])

  # Compose the final list to pass to person().

  # Final cleanup.
  end_list <- c(list(given = given), family_von)

  end_list
}

bibtex_pers_first_von_last <- function(x) {
  # Based on *Tame the BeaST*.
  # http://tug.ctan.org/info/bibtex/tamethebeast/ttb_en.pdf
  # Tests.
  # string                  -> "First"        "von"         "Last"
  # jean de la fontaine     -> ""             "jean de la"  "fontaine"
  # Jean de la fontaine     -> "Jean"         "de la"       "fontaine"
  # Jean {de} la fontaine   -> "Jean de"      "la"          "fontaine"
  # jean {de} {la} fontaine -> ""             "jean"        "de la fontaine"
  # Jean {de} {la} fontaine -> "Jean de la"   ""            "fontaine"
  # Jean De La Fontaine     -> "Jean De La"   ""            "Fontaine"
  # jean De la Fontaine     -> ""             "jean De la"  "Fontaine"
  # Jean de La Fontaine     -> "Jean"         "de"          "La Fontaine"

  parts <- bibtex_split_name_words(x)

  # Collapse blanks.
  parts <- trimws(parts)

  # Start building.
  # Assess casing.

  is_upper <- bibtex_is_upper(parts)

  # Family should always be provided.
  family <- parts[length(parts)]

  # Check whether the remaining parts mix casing styles.
  upper <- is_upper[setdiff(names(is_upper), family)]
  mix <- (length(unique(upper)) == 1)

  if (!all(mix, upper)) {
    invert <- rev(upper)
    # Then get the family sequentially.
    for (i in seq_along(invert)) {
      if (!invert[i]) {
        break
      }
      family <- c(names(invert[i]), family)
    }
  }

  # Clean again.
  upper <- is_upper[setdiff(names(is_upper), family)]

  # von part.
  # Detect casing index in the remaining parts.
  von_assess <- as.integer(which(!upper))

  # von.
  # If there is no length, there is no von.
  if (length(von_assess) == 0) {
    von <- NULL
  } else {
    von <- names(upper[seq(min(von_assess), max(von_assess))])
  }

  # Get the remaining part, which should be First.
  given <- names(upper[setdiff(names(upper), von)])

  # Compose the final list to pass to person().

  # Final cleanup.
  end_list <- list(given = given, von = von, family = family)

  end_list
}

bibtex_family_von <- function(x) {
  parts <- bibtex_split_name_words(x)
  is_upper <- bibtex_is_upper(parts)

  # Family should always be provided.
  family <- parts[length(parts)]

  upper <- is_upper[setdiff(names(is_upper), family)]

  # Get more family parts.
  family <- bibtex_extend_family(family, upper)

  # The remaining part is von.
  von <- setdiff(names(is_upper), family)

  if (length(von) == 0) {
    von <- NULL
  }

  list(von = von, family = family)
}

bibtex_split_protected <- function(x, pattern, placeholder) {
  protected <- gsub(
    paste0(pattern, "(?![^\\}]*(\\{|$))"),
    placeholder,
    x,
    perl = TRUE
  )
  parts <- trimws(unlist(strsplit(protected, pattern)))
  gsub(placeholder, pattern, parts, fixed = TRUE)
}

bibtex_split_name_words <- function(x) {
  # Protect spaces inside braces before splitting.
  protected <- gsub("\\s(?![^\\}]*(\\{|$))", "@blank@", x, perl = TRUE)

  # Collapse blanks.
  protected <- gsub("\\s+", " ", protected)

  parts <- unlist(strsplit(protected, " "))

  # Unprotect.
  gsub("@blank@", " ", parts, fixed = TRUE)
}

bibtex_is_upper <- function(parts) {
  vapply(parts, FUN.VALUE = logical(1), function(y) {
    case <- substr(y, 1, 1)
    if (case == toupper(case)) {
      TRUE
    } else {
      FALSE
    }
  })
}

bibtex_extend_family <- function(family, upper) {
  invert <- rev(upper)
  # Then get the family sequentially.
  for (i in seq_along(invert)) {
    if (!invert[i]) {
      break
    }
    family <- c(names(invert[i]), family)
  }

  family
}

validate_cff_person_fields <- function(person_cff) {
  # Entity or person.

  # Guess entity or person.
  is_entity <- as.character("name" %in% names(person_cff))

  # Keep only valid tags depending on entity or person.
  definition <- switch(is_entity,
    "TRUE" = cff_schema_definitions_entity(),
    cff_schema_definitions_person()
  )

  person_cff <- person_cff[names(person_cff) %in% definition]

  # Remove duplicates.
  person_cff <- person_cff[!duplicated(names(person_cff))]

  person_cff
}

split_txt_persons <- function(person) {
  person <- trimws(person)
  person <- paste0(person, collapse = " and ")

  # Remove the role in `[]` added by `print.person()` by default.
  # We do not use it here.
  person <- gsub("\\[[^()]*\\]", "", person)

  # Protect "and" inside braces.
  # Lowercase.
  protected <- gsub("(and)(?![^\\}]*(\\{|$))", "@nd@", person, perl = TRUE)

  # Uppercase.
  protected <- gsub("AND(?![^\\}]*(\\{|$))", "@ND@", protected, perl = TRUE)

  # Protect "and" inside comments in `()`, as produced by `print.person()`.
  # Lowercase.
  protected <- gsub("(and)(?![^\\)]*(\\(|$))", "@nd@", protected, perl = TRUE)

  # Uppercase.
  protected <- gsub("AND(?![^\\)]*(\\(|$))", "@ND@", protected, perl = TRUE)

  # Protect "and" inside `<>`. These values are emails, so this is unlikely.
  # Lowercase.
  protected <- gsub("(and)(?![^>]*(<|$))", "@nd@", protected, perl = TRUE)

  # Uppercase.
  protected <- gsub("AND(?![^>]*(<|$))", "@ND@", protected, perl = TRUE)

  auths <- unlist(strsplit(protected, " and | AND "))

  # Unprotect.
  auths_un <- gsub("@nd@", "and", auths, fixed = TRUE)
  auths_un <- gsub("@ND@", "AND", auths_un, fixed = TRUE)

  auths_un
}

extract_person_comments <- function(person) {
  # nocov start
  # Not used in R >= 4.5.0.
  # Ensure person type.
  person <- as.person(person)

  # Extract from comments.
  comm_cff <- as.list(person$comment)
  names(comm_cff) <- tolower(names(comm_cff))
  nms_com <- names(comm_cff)
  comment_as_text <- tolower(clean_str(comm_cff))

  # Special case when coerced from text: only ORCID and web can be extracted.
  if (
    all(any(length(nms_com) == 0, is.na(nms_com)), length(comment_as_text) > 0)
  ) {
    split_comments <- unlist(strsplit(comment_as_text, ",| |<|>"))

    # Guess what looks like a web URL.
    url_comment <- split_comments[is_url(split_comments)]

    # Guess ORCID.
    orcid <- url_comment[grepl("orcid.org/", url_comment)]

    # Case for R > 4.4.1.
    if ("orcid" %in% names(comm_cff)) {
      orcid <- clean_str(comm_cff$orcid)
    }

    # Get the first non-ORCID URL.
    web <- url_comment[!grepl("orcid.org/", url_comment)][1]

    # Reset comment list.
    comm_cff <- list()

    comm_cff$orcid <- clean_str(orcid)
    comm_cff$website <- clean_str(web)
  }

  finalize_person_comments(person, comm_cff)
  # nocov end
}

extract_person_comments45 <- function(person) {
  # Detect comments.
  # Check whether the final character is `)`.

  if (inherits(person, "person")) {
    person <- format(person)
  }
  last <- substr(person, nchar(person), nchar(person))
  # Check for another `)`.
  start_comment <- min(regexpr("(", person, fixed = TRUE))

  has_comment <- all(last == ")", start_comment > 5)

  # If it does not have a comment, convert to person.
  if (!has_comment) {
    p <- as.person(person)
    comm_cff <- list(fake = 123)
  } else {
    # Split and convert.
    the_person <- substr(person, 1, start_comment - 1)
    p <- as.person(the_person)

    # Comments.
    # Cannot get commas in the comment.
    comm <- strsplit(substr(person, start_comment + 1, nchar(person) - 1), ",")
    comm <- unlist(comm)
    comm_list <- lapply(comm, function(x) {
      detect_split <- min(regexpr(":", x, fixed = TRUE))
      nm <- substr(x, 1, detect_split - 1)
      val <- substr(x, detect_split + 1, nchar(x))
      val <- clean_str(val)
      val <- gsub("<|>", "", val)

      nm <- clean_str(nm)
      names(val) <- nm
      val
    })

    comm_cff <- as.list(unlist(comm_list))
  }

  names(comm_cff) <- tolower(names(comm_cff))
  # Delete unnamed comments.
  nms_com <- names(comm_cff)
  comm_cff <- comm_cff[nchar(nms_com) > 1]

  finalize_person_comments(p, comm_cff, fallback_ror = TRUE)
}

finalize_person_comments <- function(person, comm_cff, fallback_ror = FALSE) {
  if (!is.null(comm_cff$orcid)) {
    comm_cff$orcid <- normalize_orcid(comm_cff$orcid)
  }

  web <- comm_cff$website
  if (!is.null(web)) {
    comm_cff$website <- clean_str(web[is_url(web)])
  }

  ror <- comm_cff$ror
  if (all(fallback_ror, !is.null(ror), is.null(comm_cff$website))) {
    comm_cff$website <- clean_str(ror[is_url(ror)])
  }

  # Check whether there are multiple emails (MomTrunc 6.0).
  look_emails <- c(unlist(person$email), comm_cff$email)
  valid_emails <- unlist(lapply(look_emails, is_email))
  email <- look_emails[valid_emails][1]

  fin_list <- c(list(email = NULL), comm_cff["email" != names(comm_cff)])
  fin_list$email <- clean_str(email)
  fin_list
}

normalize_orcid <- function(orcid) {
  orcid <- gsub("^orcid.org/", "", orcid)
  orcid <- gsub("^https://orcid.org/", "", orcid)
  orcid <- gsub("^http://orcid.org/", "", orcid)
  paste0("https://orcid.org/", orcid)
}
