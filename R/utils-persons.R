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

as_person_bibtex <- function(x) {

  # Identify the pattern
  # It may be one of:
  # A. Given von Family
  # B. von Family, Given
  # C. von Family, Junior, Given

  # Protect commas on brackets to avoid error counting
  protected <- gsub(",(?![^\\}]*(\\{|$))", "@comma@",
    x,
    perl = TRUE
  )

  commas <- length(grep(",", unlist(strsplit(protected, "|"))))

  if (commas == 0) {
    # Case A
    end_list <- bibtex_pers_first_von_last(x)
  } else if (commas == 1) {
    # Case B
    end_list <- bibtex_pers_von_last_first(x)
  } else if (commas == 2) {
    # Case C
    end_list <- bibtex_pers_von_last_first_jr(x)
  } else {
    # Not considered by BibTeX. everything to family
    end_list <- list(family = paste(x, collapse = " "))
  }

  # Clean
  end_list <- lapply(end_list, function(z) {
    if (is.null(z)) {
      return(NULL)
    }
    if (any((is.na(z) | z == ""))) {
      return(NULL)
    }

    gsub("\\{|\\}", "", z)
  })

  end_list <- lapply(end_list, clean_str)


  return(end_list)
}
