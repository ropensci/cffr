#' Schema utils
#'
#' @name cff_schema
#' @description
#' Helper functions with the valid values of different fields, according to the
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("\n", "[Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' - [cff_schema_keys()] provides the valid high-level keys of the Citation
#'   File Format.
#' - [cff_schema_keys_license()] provides the valid
#'   [SPDX license identifier(s)](https://spdx.dev/ids/) to be used on the
#'   `CITATION.cff` file.
#' - [cff_schema_definitions_person()] and [cff_schema_definitions_entity()]
#'   returns the valid fields to be included when defining a
#'   person or entity.
#' - [cff_schema_definitions_refs()] provides the valid
#'   keys to be used on the `preferred-citation` and `references` keys.
#'
#' @source
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("[Guide to Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' @family schemas
#'
#' @export
#'
#' @return
#' A vector of characters with the names of the valid keys to be used on a
#'  Citation File Format version 1.2.0
#'
#' @param sorted Logical `TRUE/FALSE`. Should the keys be arranged
#'  alphabetically?
#'
#' @examples
#'
#' cff_schema_keys(sorted = TRUE)
cff_schema_keys <- function(sorted = FALSE) {
  if (sorted) {
    # Alphabetically
    schema_keys <- c(
      "abstract",
      "authors",
      "cff-version",
      "commit",
      "contact",
      "date-released",
      "doi",
      "identifiers",
      "keywords",
      "license",
      "license-url",
      "message",
      "preferred-citation",
      "references",
      "repository",
      "repository-artifact",
      "repository-code",
      "title",
      "type",
      "url",
      "version"
    )
  } else {
    # Arranged arbitrarily
    schema_keys <- c(
      "cff-version",
      "message",
      "type",
      "license",
      "title",
      "version",
      "doi",
      "abstract",
      "authors",
      "preferred-citation",
      "repository",
      "repository-artifact",
      "repository-code",
      "url",
      "date-released",
      "contact",
      "keywords",
      "references",
      "commit",
      "identifiers",
      "license-url"
    )
  }

  schema_keys
}

#' @rdname cff_schema
#' @export
#' @examples
#'
#' # Valid Licenses keys
#' head(cff_schema_keys_license(), 20)
cff_schema_keys_license <- function() {
  license <- read.csv(system.file("extdata/SPDX_License_List.csv",
    package = "cffr"
  ))

  license <- license$Identifier
  license
}

#' @rdname cff_schema
#' @export
#' @examples
#'
#' cff_schema_definitions_person()
cff_schema_definitions_person <- function() {
  definitions_person <- c(
    "address",
    "affiliation",
    "alias",
    "city",
    "country",
    "email",
    "family-names",
    "fax",
    "given-names",
    "name-particle",
    "name-suffix",
    "orcid",
    "post-code",
    "region",
    "tel",
    "website"
  )

  definitions_person
}

#' @rdname cff_schema
#' @export
#' @examples
#'
#' cff_schema_definitions_entity()
cff_schema_definitions_entity <- function() {
  definitions_entity <- c(
    "address",
    "alias",
    "city",
    "country",
    "date-end",
    "date-start",
    "email",
    "fax",
    "location",
    "name",
    "orcid",
    "post-code",
    "region",
    "tel",
    "website"
  )
  definitions_entity
}


#' @rdname cff_schema
#' @export
#' @examples
#'
#' cff_schema_definitions_refs()
cff_schema_definitions_refs <- function() {
  definitions_reference <- c(
    "abbreviation",
    "abstract",
    "authors",
    "collection-doi",
    "collection-title",
    "collection-type",
    "commit",
    "conference",
    "contact",
    "copyright",
    "data-type",
    "database-provider",
    "database",
    "date-accessed",
    "date-downloaded",
    "date-published",
    "date-released",
    "department",
    "doi",
    "edition",
    "editors",
    "editors-series",
    "end",
    "entry",
    "filename",
    "format",
    "identifiers",
    "institution",
    "isbn",
    "issn",
    "issue",
    "issue-date",
    "issue-title",
    "journal",
    "keywords",
    "languages",
    "license",
    "license-url",
    "loc-end",
    "loc-start",
    "location",
    "medium",
    "month",
    "nihmsid",
    "notes",
    "number",
    "number-volumes",
    "pages",
    "patent-states",
    "pmcid",
    "publisher",
    "recipients",
    "repository",
    "repository-artifact",
    "repository-code",
    "scope",
    "section",
    "senders",
    "start",
    "status",
    "term",
    "thesis-type",
    "title",
    "translators",
    "type",
    "url",
    "version",
    "volume",
    "volume-title",
    "year",
    "year-original"
  )
  definitions_reference
}


# Helper lists and vectors ----

#' Vector other persons
#' @noRd
other_persons <- function() {
  pers_ent <- c(
    "contact",
    "editors",
    "editors-series",
    "recipients",
    "senders",
    "translators"
  )

  pers_ent <- sort(unique(c(
    pers_ent,
    other_persons_entity(),
    entity_person()
  )))

  return(pers_ent)
}

#' Vector other persons to be coerced as entities
#' @noRd
other_persons_entity <- function() {
  entities <- c(
    "conference",
    "database-provider",
    "institution",
    "location",
    "publisher"
  )

  entities
}

#' This may be entities or persons
#' @noRd
entity_person <- function() {
  forced <- c(
    "editors",
    "editors-series"
  )
  forced
}
