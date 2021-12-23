#' Parse a `bibentry` to `cff`
#'
#' Parse a `bibentry` object to a valid format for a `CITATION.cff` file.
#'
#' @seealso [cff_create()], `vignette("cffr", "cffr")`, [bibentry()]
#'
#' @export
#'
#' @family parsers
#'
#' @param bib A `bibentry` object, either created with [bibentry()]
#'   (preferred) or [citEntry()].
#'
#' @return A [`cff`] object ready to be used on [cff_create()].
#'
#' @details
#' This is a helper function designed to help on adding or
#' replacing the auto-generated authors of the package. See **Examples**.
#'
#' This function tries to adapt a `bibentry` object (generated with [bibentry()]
#' or [citEntry()]) to the CFF standard.
#'
#' ## Entry types considered
#'
#' - **Article**, **Book**, **Booklet**, **InBook**, **InCollection**,
#'   **InProceedings**, **Manual**, **MastersThesis**, **Misc**, **PhDThesis**,
#'   **Proceedings**, **TechReport**, **Unpublished**. See [bibentry()]
#'   for more information.
#'
#'  Note that **Conference** is not implemented in
#'  [bibentry()], however is equivalent to **InProceedings** (Patashnik (1988)).
#'
#' ## Fields considered
#'
#' - **address**, **author**, **booktitle**, **chapter**, **edition**,
#'   **editor**, **howpublished**, **institution**,  **journal**, **key**,
#'   **month**, **note**, **number**, **organization**, **pages**,
#'   **publisher**, **school**, **series**, **title**, **type**, **year**.
#'
#'  **annote** and **crossref** fields are ignored.
#'
#'
#' @references
#' - Patashnik, O. (1988, February). *BIBTEXTING*. BibTeX - Process
#'   Bibliographies for LATEX, Etc. Retrieved December 1, 2021, from
#'   <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>
#'
#' - Haines, R., & The Ruby Citation File Format Developers. (2021).
#'   *Ruby CFF Library (Version 0.9.0)* (Computer software).
#'   \doi{10.5281/zenodo.1184077}.
#'
#' @examples
#' \donttest{
#' bib <- citation("base")
#' bib
#'
#'
#' # To cff
#' bib_to_cff <- cff_parse_citation(bib)
#' bib_to_cff
#'
#' # Create the object
#' new_cff <- cff()
#'
#' full <- cff_create(new_cff, keys = list("preferred-citation" = bib_to_cff))
#'
#' full
#' # Validate
#' cff_validate(full)
#'
#' # Several citations
#'
#' cff_parse_citation(citation("rmarkdown"))
#' }
cff_parse_citation <- function(bib) {
  if (!inherits(bib, "bibentry")) {
    return(NULL)
  }

  ## Unname
  bib <- unname(bib)

  if (length(bib) > 1) {
    bib <- lapply(bib, cff_parse_citation)
    class(bib) <- "cff"
    return(bib)
  }

  # Parsing ----

  ## Extract type and additional transforms ----
  parsed_cff <- parse_bibtex_for_cff(bib)

  # Start building fields
  bib_unlist <- drop_null(unclass(bib)[[1]])

  # Keywords may be duplicated, unify
  if ("keywords" %in% names(bib_unlist)) {
    kword <- unlist(bib_unlist[names(bib_unlist) == "keywords"])
    kword2 <- clean_str(paste(kword, collapse = ", "))
    newkeys <- trimws(unique(unlist(strsplit(kword2, ","))))
    bib_unlist$keywords <- paste(newkeys, collapse = ",")
  }

  ## Adapt core BibTeX names ----
  parsed_fields <- parse_core_bibtex_fields(bib_unlist)

  ## If no title (case of some Misc) then return null

  if (!("title" %in% names(parsed_fields))) {
    entry <- capture.output(print(bib, bibtex = FALSE))

    message(
      "Skipping entry without title:\n\t",
      entry
    )

    return(NULL)
  }

  ## Merge all----
  ### keep initial order----
  # Append info keeping the initial order but adding cff type at the beginning
  # We would use it at the end
  order_name <- c(
    "type", names(parsed_fields),
    names(parsed_cff)
  )

  # Appending, priority is given on parsed_cff
  merged <- c(
    parsed_cff,
    parsed_fields[!names(parsed_fields) %in% names(parsed_cff)]
  )

  # Special case: authors
  # Some keys does not strictly require authors, so we create one for cff
  key <- clean_str(attr(unclass(bib)[[1]], "key"))
  merged <- tweak_author(merged, key)


  # Parse author and entities----
  ## On CFF reference max authors seems to be 10
  ## Bug with urltools

  ## authors ----
  parse_all_authors <- drop_null(
    lapply(merged$authors, cff_parse_person)
  )
  merged$authors <- unique(parse_all_authors)

  ## other person or entities ----
  parse_other_persons <- building_other_persons(merged)

  keep <- !names(merged) %in% names(parse_other_persons)

  merged_person_ok <- c(
    merged[keep],
    parse_other_persons
  )
  merged_person_ok <- drop_null(merged_person_ok)

  ## Treat address----
  # Usually the address of the publisher as per BibTeX
  if (!is.null(merged_person_ok$publisher) &
    !(merged_person_ok$type %in% c(
      "conference", "conference-paper",
      "proceedings"
    ))) {
    merged_person_ok$publisher$address <- merged_person_ok$address
  }

  # If this is a conference-paper then add to conference
  if (!is.null(merged_person_ok$conference)) {
    merged_person_ok$conference$address <- merged_person_ok$address
  }

  # If is a report or a thesis, add to institution
  if (merged_person_ok$type %in% c("report", "thesis") & !is.null(merged_person_ok$institution)) {
    merged_person_ok$institution$address <- merged_person_ok$address
  }


  # Remove non-valid names so far
  validnames <- cff_schema_definitions_refs()
  parse_cit <- merged_person_ok[names(merged_person_ok) %in%
    c(validnames)]


  # Building blocks----
  ## month ----
  parse_cit$month <- building_month(parse_cit)

  ## doi----
  bb_doi <- building_doi(parse_cit)
  parse_cit$doi <- bb_doi$doi

  ### identifiers ----
  if (!is.null(bb_doi$identifiers)) parse_cit$identifiers <- bb_doi$identifiers


  ## url----
  bb_url <- building_url(parse_cit)
  parse_cit$url <- bb_url$url

  ### final identifiers----
  # Identifies (additional dois and urls)
  if (!is.null(bb_url$identifiers)) {
    parse_cit$identifiers <- append(
      parse_cit$identifiers,
      bb_url$identifiers
    )
  }

  ## keywords----
  if ("keywords" %in% names(parse_cit)) {
    newkeys <- trimws(unique(unlist(strsplit(parse_cit$keywords, ","))))
    length(newkeys)
    # A single keyword creates error
    if (length(newkeys) > 1) {
      parse_cit$keywords <- newkeys
    } else {
      parse_cit$keywords <- NULL
    }
  }


  # Prepare output ----

  # Reorder final object
  ord <- unique(c(order_name, names(parse_cit)))
  ord <- ord[ord %in% validnames]
  parse_cit_result <- as.cff(parse_cit[ord])

  parse_cit_result
}

#' Adapt information from BibTeX entry to cff standard
#'
#' @description
#' Heavily based on <https://github.com/citation-file-format/ruby-cff>, see
#' also the latest BibTeX standard available:
#' <https://osl.ugr.es/CTAN/biblio/bibtex/contrib/doc/btxdoc.pdf>.
#'  Also perform some adaptations.
#'
#' @noRd
parse_bibtex_for_cff <- function(bib) {

  # Based on:
  # https://github.com/citation-file-format/ruby-cff/blob/main/lib/cff/formatter/bibtex_formatter.rb

  init_cff_obj <- list(type = NULL)

  # Extract type from BibTeX
  init_type <- attr(unclass(bib)[[1]], "bibtype")
  init_type <- clean_str(tolower(init_type))

  # Manage type from BibTeX
  init_cff_obj$type <- switch(init_type,
    "article" = "article",
    "book" = "book",
    "booklet" = "pamphlet",
    "conference" = "conference-paper",
    "inbook" = "book",
    # "incollection" = ,
    "inproceedings" = "conference-paper",
    "manual" = "manual",
    "mastersthesis" = "thesis",
    "misc" = "generic",
    "phdthesis" = "thesis",
    "proceedings" = "proceedings",
    "techreport" = "report",
    "unpublished" = "unpublished",
    "generic"
  )

  # Manage BibTeX (bx) type field, to avoid collusion with cff type
  # As per BibTeX 0.99b, this field is optional on:
  # inbook, incollection, masterthesis, phdthesis and techreport

  # If is a thesis add  bx_type to thesis type
  if (init_type %in% c("phdthesis", "mastersthesis")) {
    init_cff_obj$`thesis-type` <- switch(init_type,
      phdthesis = "PhD Thesis",
      "Master's Thesis"
    )
  }

  # Else add this to cff section, along with chapter
  if (init_type %in% c("inbook", "incollection", "techreport")) {
    init_cff_obj$section <- clean_str(bib$chapter)
  }

  # Tweak organizations: In manual and conferences use the cff
  # institution. BibTeX doesn't prescribe use of orgs. and institutions
  # altogether

  if (init_cff_obj$type %in% c("manual")) {
    init_cff_obj$institution <- clean_str(bib$organization)
  }

  # Tweak book: Use bx_series as collection-title
  if (init_cff_obj$type == "book") {
    init_cff_obj$`collection-title` <- clean_str(bib$series)
  }

  # Tweak conference-paper and proceedings (bx inproceedings)
  if (init_cff_obj$type %in% c("conference-paper", "proceedings")) {
    init_cff_obj$`collection-title` <- clean_str(bib$booktitle)


    loc <- person(bib$address)
    org <- person(bib$organization)
    conf <- person(bib$series)

    init_cff_obj$conference <- cff_parse_person(conf)
    init_cff_obj$institution <- cff_parse_person(org)
    init_cff_obj$location <- cff_parse_person(loc)
  }


  # Tweak thesis bx *thesis
  if (init_cff_obj$type %in% c("thesis")) {
    school <- person(bib$school)
    init_cff_obj$institution <- cff_parse_person(school)
  }


  # Tweak bx booklet, bx_manual,
  if (init_cff_obj$type %in% c("pamphlet", "manual")) {
    loc <- person(bib$address)
    init_cff_obj$location <- cff_parse_person(loc)
  }




  # Clean final list
  init_cff_obj <- drop_null(init_cff_obj)
  return(init_cff_obj)
}

#' Adapt names from R citation()/BibTeX to cff format
#' @noRd
parse_core_bibtex_fields <- function(parse_cit) {
  # to lowercase
  names(parse_cit) <- tolower(names(parse_cit))

  nm <- names(parse_cit)
  # Standard BibTeX fields:
  # address annote author booktitle chapter crossref edition editor
  # howpublished institution journal key month note number organization pages
  # publisher school series title type year

  # No mapping needed (direct mapping)
  # edition institution journal month publisher title volume year

  # Mapped:
  # author booktitle chapter editor howpublished note number school
  nm[nm == "author"] <- "authors"
  nm[nm == "booktitle"] <- "collection-title"
  nm[nm == "chapter"] <- "section"
  nm[nm == "editor"] <- "editors"
  nm[nm == "howpublished"] <- "medium"
  nm[nm == "note"] <- "notes"
  nm[nm == "number"] <- "issue"




  # Not mapped:
  # address annote crossref key organization series type
  #
  # Fields address, organization, series and type already treated on
  # parse_bibtex_for_cff()/main function
  # key is a special field, treated apart
  # Fields ignored: annote, crossref

  names(parse_cit) <- nm



  # Treat pages

  pages <- parse_cit$pages
  if (!is.null(pages)) {
    spl <- unlist(strsplit(pages, "--"))

    parse_cit$start <- spl[1]

    if (length(spl) > 1) parse_cit$end <- paste(spl[-1], collapse = "--")
  }

  # We need to remove the type from BibTeX, already parsed on
  parse_cit <- parse_cit[!nm %in% c("type", "pages")]



  return(parse_cit)
}


#' Special case for authors
#'
#' Some BibTeX entry types does not require authors, while this
#' is required for cff. Try to get info
#'
#' @noRd
tweak_author <- function(merged, key) {
  if (!is.null(merged$authors)) {
    return(merged)
  }

  # If no author add editor as authors with an alias
  if (!is.null(merged$editors)) {
    edits <- merged$editors


    edits_parsed <- lapply(edits, function(x) {
      un <- unclass(x)
      un[[1]]$comment <- list(alias = "editor")

      class(un) <- "person"
      return(un)
    })

    edits_parsed <- do.call(c, edits_parsed)

    merged$authors <- edits_parsed
    return(merged)
  }

  # If no editors, the recommended approach is to include a key field
  if (!is.null(key)) {
    # Add alias for easy identification
    bibkey <- person(family = key, comment = c(alias = "BibTeX key"))

    merged$authors <- bibkey

    return(merged)
  }

  # If nothing then use missing and return

  merged$authors <- person(family = "missing")

  return(merged)
}
