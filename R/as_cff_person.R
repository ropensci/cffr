#' Coerce **R** objects to [`cff_pers_lst`] objects (`cff` persons)
#'
#' @description
#' `as_cff_person()` turns an existing list-like **R** object into a
#' [`cff_pers_lst`] object representing a list of `definitions.person` or
#' `definitions.entity`, as defined by the
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Citation File Format schema]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' `as_cff_person` is an S3 generic, with methods for:
#' - `person`: objects created with [person()].
#' - `character`: String with the definition of an author or several authors,
#'   using the standard BibTeX notation (see Markey, 2007) and others, like
#'   the output of [format()] for person (see [`format.person()`][person()]).
#' -  Default: Other inputs are first coerced with [as.character()].
#'
#' The inverse transformation (`cff_pers_lst` to `person`) can be done with
#' the methods [as.person.cff_pers()] and [as.person.cff_pers_lst()].
#'
#' @seealso
#' Examples in `vignette("cffr", "cffr")` and [utils::person()].
#'
#' Learn more about the classes `cff_pers_lst, cff_pers` classes in [cff_class].
#'
#' @export
#' @rdname as_cff_person
#' @name as_cff_person
#' @order 1
#'
#' @family s3method
#'
#' @param x Any **R** object.
#' @param ... Ignored by this method.
#'
#' @return
#' `as_cff_person()` returns an object of classes
#' [`cff_pers_lst, cff`][cff_pers_lst] according to the `definitions.person`
#' or `definitions.entity` specified in the
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Citation File Format schema]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md). "))
#'
#'
#' ```
#' Each element of the `cff_pers_lst` object would have classes
#' [`cff_pers, cff`][cff_pers].
#'
#'
#' @details
#'
#' `as_cff_person()` would recognize if the input should be converted using the
#' CFF reference for `definition.person` or `definition.entity`.
#'
#' `as_cff_person()` uses a custom algorithm that tries to break a name as
#' explained in Section 11 of "Tame the BeaST" (Markey, 2007) (see also
#' Decoret, 2007):
#'
#'  - `First von Last`.
#'  - `von Last, First`.
#'  - `von Last, Jr, First`.
#'
#'  Mapping is performed as follows:
#'  - `First` is mapped to the CFF field `given-names`.
#'  - `von` is mapped to the CFF field `name-particle`.
#'  - `Last` is mapped to the CFF field `family-names`.
#'  - `Jr` is mapped to the CFF field `name-suffix`.
#'
#'  In the case of entities, the whole `character` would be mapped to `name`.
#'  It is a good practice to "protect" entity's names with `{}`:
#'
#' ```{r child = "man/chunks/person.Rmd"}
#' ```
#' `as_cff_person()` would try to add as many information as possible.
#' On `character` string coming from [`format.person()`][utils::person()] the
#' email and the ORCID would be retrieved as well.
#'
#' @references
#' - Patashnik, Oren. "BIBTEXTING" February 1988.
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' - Markey, Nicolas. "Tame the BeaST"
#'   *The B to X of BibTeX, Version 1.4* (October 2007).
#'   <https://osl.ugr.es/CTAN/info/bibtex/tamethebeast/ttb_en.pdf>.
#'
#' - Decoret X (2007). "A summary of BibTex."
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("<https://maverick.inria.fr/~Xavier.Decoret/resources/xdkbibtex/",
#'            "bibtex_summary.html#names>"))
#'
#' ```
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
#' cff_person <- as_cff_person(a_person)
#'
#' # Class cff_pers_lst / cff
#' class(cff_person)
#'
#' # With each element with class cff_pers / cff
#' class(cff_person[[1]])
#'
#' # Print
#' cff_person
#'
#' # Back to person object with S3 Method
#' as.person(cff_person)
#'
#' # Coerce a string
#' a_str <- paste0(
#'   "Julio Iglesias <fake@email.com> ",
#'   "(<https://orcid.org/0000-0001-8457-4658>)"
#' )
#' as_cff_person(a_str)
#'
#' # Several persons
#' persons <- c(
#'   person("Clark", "Kent", comment = c(affiliation = "Daily Planet")),
#'   person("Lois", "Lane"), person("Oscorp Inc.")
#' )
#'
#' a_cff <- as_cff_person(persons)
#'
#' a_cff
#'
#' # Printed as Bibtex thanks to the method
#' toBibtex(a_cff)
#'
#' # Or as person object
#' as.person(a_cff)
#'
#'
#' # Or you can use BibTeX style as input if you prefer
#'
#' x <- "Frank Sinatra and Dean Martin and Davis, Jr., Sammy and Joey Bishop"
#'
#' as_cff_person(x)
#'
#' as_cff_person("Herbert von Karajan")
#'
#' toBibtex(as_cff_person("Herbert von Karajan"))
as_cff_person <- function(x, ...) {
  UseMethod("as_cff_person")
}


#' @export
#' @rdname as_cff_person
#' @order 2
as_cff_person.default <- function(x, ...) {
  x <- clean_str(x)
  if (is.null(x)) {
    return(NULL)
  }

  x_char <- unname(as.character(x))

  as_cff_person(x_char)
}

#' @export
#' @rdname as_cff_person
#' @order 3
as_cff_person.person <- function(x, ...) {
  the_obj <- lapply(x, create_person_from_r)

  if (!length(the_obj) > 0) {
    return(NULL)
  }
  the_obj <- as_cff(the_obj)
  the_obj
}

#' @export
#' @rdname as_cff_person
#' @order 4
as_cff_person.character <- function(x, ...) {
  test_x <- clean_str(x)
  if (is.null(test_x)) {
    return(NULL)
  }

  # Need to split the character
  person_split <- split_txt_persons(x)
  the_obj <- lapply(person_split, create_person_from_txt)

  the_obj <- as_cff(the_obj)
  the_obj
}



create_person_from_r <- function(person) {
  person <- as.person(person)

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
    as_bib_text <- protect_bib_braces(as_bib_text)
  } else {
    # Use von Family, Junior, Given
    # Protect given
    giv <- paste0(person$given, collapse = " ")
    giv <- protect_bib_braces(giv)
    as_bib_text <- paste0(c(person$family, giv), collapse = ", ")
  }

  pers_cff <- create_person_from_txt(as_bib_text)
  comm_cff <- extract_person_comments(person)

  # Add comments
  pers_cff <- c(pers_cff, comm_cff)

  # Validate fields
  pers_cff <- validate_cff_person_fields(pers_cff)
  pers_cff
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
    comm_cff <- extract_person_comments(fake_person)
  } else {
    # Does not
    person_only <- as_bib_text
    comm_cff <- list()
  }

  # Special case for Bioconductor
  if (is_substring(tolower(person_only), "bioconductor")) {
    person_only <- protect_bib_braces(person_only)
  }
  # Special case for R Core Team
  if (is_substring(tolower(person_only), "r core")) {
    person_only <- protect_bib_braces(person_only)
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

  commas <- as.character(
    lengths(regmatches(protected, gregexpr(",", protected)))
  )

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
    if (is.null(clean_str(z))) {
      return(NULL)
    }

    cleaned <- gsub("\\{|\\}", "", z)
    clean_str(cleaned)
  })

  # Final person
  if (is.null(bibtex_name_str$given)) {
    ent <- c(bibtex_name_str$von, bibtex_name_str$family, bibtex_name_str$jr)
    ent <- clean_str(paste(ent, collapse = " "))
    pers_cff <- list(name = ent)
  } else {
    pers_cff <- list(
      "family-names" = bibtex_name_str$family,
      "given-names" = bibtex_name_str$given,
      "name-particle" = bibtex_name_str$von,
      "name-suffix" = bibtex_name_str$jr
    )
  }

  pers_cff <- pers_cff[!lengths(pers_cff) == 0]

  # Add comments
  pers_cff <- c(pers_cff, comm_cff)

  # Validate fields
  pers_cff <- validate_cff_person_fields(pers_cff)
  pers_cff
}
