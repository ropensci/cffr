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
#'
#' @family coercing
#'
#' @param person It can be either:
#'   - A `person` or list of `person` object created with [utils::person()].
#'   - A `character` object representing a person or persons.
#'   See **Examples**.
#' @param hint Either `auto`, `person` or `bibtex`. See **Details**.
#'
#' @return
#' A list of persons or entities with class `cff` converted to the
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
#' `cff_create_person()` would try to guess what type of object has been
#' provided in `person`. Possible options are:
#'
#' 1. If `person` is a [`person`][utils::person()] object it would be parsed
#'    with a specific algorithm.
#' 2. However, if `person` is a `character` there are two options:
#'
#'     1.  The `character` be a printed version of [utils::person()]. In this
#'        case it may include information of email, ORCID, etc. See
#'        [utils::as.person()] and **Details** in that same help page.
#'
#'     2.  It can be just a person with BibTeX notation such as
#'        `"von Doe, John and Smith, Jane"`.
#'
#' In **case 1** (`person = "person"`) `hint = "auto"` wouldn't affect and
#' internally the algorithm used with `hint = "person"` would be always used.
#'
#' `hint` argument would affect **case 2** (i.e. `person = "character"`). If
#' `hint = "auto"` `cff_create_person()` would try to guess the best
#' alternative, however it may be incorrect, so it is possible to specify the
#' conversion algorithm:
#'  - `hint = "person"` would try to convert the `character` to `person` object
#'     with [utils::as.person()] and then proceed with the algorithm for
#'     `person` objects.
#'  - `hint = "bibtex"` would use a special algorithm to create the `cff`
#'     person. This option is better for strings like `"von Last, Jr, First"`
#'     and produces improved mappings to CFF keys as `name-particle` and
#'     `name-suffix`. It is also aware of protected names such as
#'     `{John Doe and Jane Smith inc.}`.
#'

#'
#' @references
#' - Patashnik, Oren. "BIBTEXTING" February 1988.
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' - Markey, Nicolas. "Tame the BeaST."
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
#' cff_create_person(a_person)
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
cff_create_person <- function(person, hint = c("auto", "person", "bibtex")) {
  hint <- match.arg(hint)
  init_hint <- hint
  hint <- guess_hint(person, hint)

  verbopt <- getOption("cffr_message_verbosity", "none")
  if (all(verbopt == "debug", init_hint == "auto")) {
    cli::cli_alert_info(
      "In {.fn cff_create_person} using {.arg hint} = {.val {hint}}"
    )
  }

  cff_obj <- switch(hint,
    "person" = hint_person(person),
    hint_bibtex(person)
  )

  cff_obj
}

guess_hint <- function(person, hint) {
  # On length 0 use "person"
  if (length(person) == 0) {
    return("person")
  }
  if (hint != "auto") {
    return(hint)
  }
  if (inherits(person, "person")) {
    return("person")
  }

  # Rest of cases "bibtex"
  return("bibtex")
}

hint_person <- function(person) {
  person <- as.person(person)

  if (length(person) == 0) {
    return(NULL)
  }

  if (length(person) > 1) {
    person <- lapply(person, cff_parse_person)
    person <- new_cff(person)
    return(person)
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

  # Create my list
  parsed_person <- list()

  if (is_entity) {
    parsed_person$name <- clean_str(c(person$family, person$given))
  } else {
    parsed_person$"family-names" <- clean_str(person$family)
    parsed_person$"given-names" <- clean_str(person$given)
  }

  # Check if several mails (MomTrunc 6.0)
  valid_emails <- unlist(lapply(person$email, is_email))
  email <- person$email[valid_emails][1]
  parsed_person$email <- clean_str(email)

  # Extract from comments
  parsed_comments <- as.list(person$comment)
  names(parsed_comments) <- tolower(names(parsed_comments))
  nms_com <- names(parsed_comments)
  comment_as_text <- tolower(clean_str(parsed_comments))

  # Special case when coerced from text, only can extract orcid
  if (all(
    any(is.na(nms_com), length(nms_com) == 0),
    length(comment_as_text > 0)
  )
  ) {
    # guess orcid
    norc <- min(unlist(regexpr("orcid.org/", comment_as_text)))
    if (orc_text < 0) {
      parsed_comments <- list()
    } else {
      orcid <- substr(comment_as_text, norc, nchar(comment_as_text))
      orcid <- clean_str(gsub("<|>", "", orcid))
      parsed_comments <- list(orcid = orcid)
    }
  }


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

    parsed_comments$orcid <- paste0("https://orcid.org/", orcid)
  }

  # Add website
  web <- parsed_comments$website

  if (!is.null(web)) {
    parsed_comments$website <- clean_str(web[is_url(web)])
  }

  # Add comments
  parsed_person <- c(parsed_person, parsed_comments)

  # Keep only valid tags - Would depend on entity or person
  definition <- if (is_entity) {
    cff_schema_definitions_entity()
  } else {
    cff_schema_definitions_person()
  }
  parsed_person <- parsed_person[names(parsed_person) %in% definition]

  parsed_person <- new_cff(parsed_person)
  # Ensure it is always a list
  if (!is.null(names(parsed_person))) {
    parsed_person <- list(parsed_person)
    class(parsed_person) <- c("cff", "list")
  }
  parsed_person
}

hint_bibtex <- function(person) {
  person <- trimws(person)

  # Remove role on [] as it comes from print.person by default
  person <- gsub("\\[[^()]*\\]", "", person)
  # Protect and on brackets {}
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

  # Do the same for and in comment "()" print.person by default
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

  auths <- unlist(strsplit(protected, " and | AND "))

  # Unprotec
  auths_un <- gsub("@nd@", "and", auths)
  auths_un <- gsub("@ND@", "AND", auths_un)


  bibtex_auths <- lapply(auths_un, as_person_bibtex_comments)
  end <- lapply(bibtex_auths, function(x) {
    if (is.null(x$given)) {
      ent <- c(x$von, x$family, x$jr)
      ent <- clean_str(paste(ent, collapse = " "))
      l <- list(name = ent)

      # Append comments
      coms <- x[setdiff(names(x), c("family", "given", "von", "jr"))]
      l <- c(l, coms)
      l <- new_cff(l)
      l
    } else {
      l <- list(
        "family-names" = x$family,
        "given-names" = x$given,
        "name-particle" = x$von,
        "name-suffix" = x$jr
      )
      coms <- x[setdiff(names(x), c("family", "given", "von", "jr"))]
      l <- c(l, coms)
      l <- new_cff(l)
      l
    }
  })

  # Ensure it is always a list
  if (!is.null(names(end))) {
    end <- list(end)
    class(parsed_person) <- c("cff", "list")
  }

  end <- new_cff(end)
}
