#' THIS DESC NEEDS TO BE FIXED
#'
#' @description
#' Extract information from a `DESCRIPTION` file and creates an object
#' to be converted into a `CITATION.cff` file.
#'
#' @return A character value ready for writing into `yaml` format.
#'
#' @seealso [yaml::as.yaml()]
#'
#' @export
#'
#' @param path Path to a `DESCRIPTION` file
#'
#'
#' @seealso [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md)
create_cff <- function(path = "." ){

  # DESCRIPTION path
  desc_path <- file.path(path,"DESCRIPTION")

  cffobj <- cff_description(desc_path)
  cffobj <- cffobj[cff_schema_keys()]

  cffobj <- drop_null(cffobj)
  class(cffobj) <- "citationcff"

  cffobj
}

#' @export
print.citationcff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}

# Valid keys on CFF v1.2.0:
# [OK] abstract
# [OK] authors (array of objects)
# [OK] cff-version
# [WONT DO]commit
# [OK] contact (object)
# [OK] date-released
# [WONT DO - Prefer DOI]identifiers (array of objects)
# [OK] keywords
# [OK] license
# [WONT DO] license-url
# [OK] message
# preferred-citation (object)
# doi
# [WONT DO] references (array of objects)
# [WONT DO] repository
# [WONT DO] repository-artifact
# [OK] repository-code
# [OK] title
# [OK] type
# [OK] url
# [OK] version
