#' Convert `DESCRIPTION` to cff format
#'
#' @description
#' Extract information from a `DESCRIPTION` file and creates an object
#' to be converted into a `CITATION.cff` file.
#'
#' @return A character value ready for writing into `yaml` format.
#'
#' @seealso [yaml::as.yaml()]
#'
#' @keywords internal
#'
#' @param desc_path Path to a `DESCRIPTION` file
#'
#' @param message A message to the human reader of the `CITATION.cff` file to
#'   let them know what to do with the citation metadata.
#'
#' @seealso [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md)
cff_description <- function(desc_path = "DESCRIPTION",
                            message = "If you use this software, please cite it using these metadata.") {
  pkg <- desc::desc(desc_path)
  pkg$coerce_authors_at_r()


  list_fields <- list(
    "cff-version" = "1.2.0",
    message = message,
    type = "software",
    title = parse_desc_title(pkg),
    version = parse_desc_version(pkg),
    authors = parse_authors(pkg),
    abstract = parse_desc_abstract(pkg),
    "repository-code" = parse_desc_urls(pkg)$repo,
    url = parse_desc_urls(pkg)$url,
    "date-released" = parse_desc_date_released(pkg),
    contact = list(parse_desc_contacts(pkg)),
    keywords = unlist(parse_desc_keywords(pkg))
  )

  list_fields <- drop_null(list_fields)

  parsed <- yaml::as.yaml(list_fields)

  parsed
}


# Valid keys on CFF v1.2.0:
# [OK] abstract
# [REVIEW] authors (array of objects)
# [OK] cff-version
# [WONT DO]commit
# [REVIEW] contact (object)
# [OK] date-released
# doi
# [WONT DO - Prefer DOI]identifiers (array of objects)
# [OK] keywords
# license
# [WONT DO] license-url
# [OK] message
# preferred-citation (object)
# [WONT DO] references (array of objects)
# [WONT DO] repository
# [WONT DO] repository-artifact
# [OK] repository-code
# [OK] title
# [OK] type
# [OK] url
# [OK] version
