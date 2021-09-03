#' Schema utils
#'
#' @name cff_schema
#' @description
#' Helper functions with the valid values of different fields, according to the
#' [Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md)
#'
#' - [cff_schema_keys()] provides the valid high-level keys of the Citation
#'   File Format.
#' - [cff_schema_definitions_person()] and [cff_schema_definitions_entity()]
#'   returns the valid fields to be included when defining a
#'   person or entity.
#'
#' @source
#' [Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md)
#'
#'
#' @concept cff_schema
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