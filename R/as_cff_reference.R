#' Internal functions for `as_cff.bibentry` method
#'
#' @noRd
as_cff_reference <- function(x) {
  # Need always to be unnamed bibentry
  bib <- unname(x)
  if (any(duplicated(bib))) {
    cli::cli_alert_info("Removing duplicate {.cls bibentry} objects.")
    bib <- unique(bib)
  }

  # Return always a list
  the_list <- lapply(bib, make_cff_reference)
  the_list
}

make_cff_reference <- function(bib) {
  # Get BibTeX entry ----
  cit_list <- get_bibtex_entry(bib)

  ## If no title (case of some Misc) then return null
  if (!("title" %in% names(cit_list))) {
    entry <- capture.output(print(bib, bibtex = FALSE))
    entry <- as.character(entry)

    cli::cli_alert_warning("Entry {.val {entry}} without title. Skipping")

    return(NULL)
  }

  # Get BibTeX fields ----
  field_list <- get_bibtex_fields(cit_list)
  # VGAM: title is a vector
  field_list$title <- clean_str(field_list$title)

  ## Handle collection types ----
  field_list <- add_bibtex_coltype(field_list)

  ## Add conference
  field_list <- add_conference(field_list)

  # Create BibTeX to CFF institution logic ----
  field_list <- get_bibtex_inst(field_list)

  # Coerce persons ----
  # Special case: authors
  # Some keys does not strictly require authors, so we create one for cff
  # https://github.com/citation-file-format/citation-file-format/blob/main/
  # (cont) schema-guide.md#how-to-deal-with-unknown-individual-authors

  if (is.null(field_list$authors)) {
    field_list$authors <- person(family = "anonymous")
  }

  ## authors ----
  get_all_authors <- as_cff_person(field_list$authors)
  field_list$authors <- unique(get_all_authors)

  ## other persons----
  get_other_persons <- get_bibtex_other_pers(field_list)

  # Keep order here, we would use it later
  init_ord <- names(field_list)

  cit_list <- c(
    field_list[!names(field_list) %in% names(get_other_persons)],
    get_other_persons
  )

  # Building blocks----

  # Fallback for year and month: use date-published ----
  cit_list <- fallback_dates(cit_list)

  ## doi----
  bb_doi <- get_bibtex_doi(cit_list)
  cit_list$doi <- bb_doi$doi

  ### identifiers ----
  if (!is.null(bb_doi$identifiers)) cit_list$identifiers <- bb_doi$identifiers


  ## url----
  bb_url <- get_bibtex_url(cit_list)
  cit_list$url <- bb_url$url

  ### final identifiers----
  # Identifies (additional dois and urls)
  if (!is.null(bb_url$identifiers)) {
    cit_list$identifiers <- append(
      cit_list$identifiers,
      bb_url$identifiers
    )
  }

  ## Add thesis type ----
  cit_list <- add_thesis(cit_list)

  ## Handle location ----
  cit_list <- add_address(cit_list)


  # Last step----

  # Initial order but starting with type, title, authors
  final_order <- unique(
    c("type", "title", "authors", init_ord, names(cit_list))
  )

  cit_list <- cit_list[final_order]

  # Remove non-valid names
  validnames <- cff_schema_definitions_refs()
  cit_list <- cit_list[names(cit_list) %in% validnames]

  cit_list <- drop_null(cit_list)

  return(cit_list)
}
