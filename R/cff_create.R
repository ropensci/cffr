#' Create a `ccfr` object
#'
#' @description
#' Create a `ccfr` object for further manipulation. Similar to
#' [cff_write()], but returns a list object rather than writing directly to a
#' file. See examples.
#'
#' @return A `ccfr` list object.
#'
#' @concept cff_core
#' @concept **cffr** core functions
#'
#' @export
#'
#' @param x It could be
#'  * The path to package root (`"."`),
#'  * The name of an installed package (`"jsonlite"`), or
#'  * Path to a DESCRIPTION file (`"*/DESCRIPTION*"`).
#'
#' @param keys List of additional keys to add to the `ccfr` object. See
#'  **Details**.
#' @param cff_version The Citation File Format schema version that the
#'   CITATION.cff file adheres to for providing the citation metadata.
#'
#' @seealso [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md),
#' [cff_write()]
#'
#' @details
#'
#' It is possible to add additional keys not detected by [cff_create] using the
#' `keys` argument. A list of valid keys can be retrieved with
#' [cff_schema_keys()].
#'
#' Please refer to [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md)
#' for additional details.
#'
#'
#' @examples
#'
#'
#'
#' # Installed package
#' cff_create("jsonlite")
#'
#' # Demo file
#' demo_file <- system.file("examples/DESCRIPTION_demo", package = "cffr")
#' cff_create(demo_file)
#'
#' # Add additional keys
#'
#' newkeys <- list(
#'   message = "This overwrites fields",
#'   abstract = "New abstract",
#'   keywords = c("A", "new", "list", "of", "keywords"),
#'   authors = list(cff_parse_person("New author")),
#'   "date-released" = "1900-01-01"
#' )
#'
#' cff_create(demo_file, keys = newkeys)
#'
#' # Update a field on a list - i,e: authors, contacts, etc.
#' # We are adding a new contact here
#'
#' old <- cff_create(demo_file)
#'
#' new_contact <- append(
#'   old$contact,
#'   list(
#'     cff_parse_person(person(
#'       given = "I am",
#'       family = "New Contact"
#'     ))
#'   )
#' )
#'
#'
#' cff_create(demo_file, keys = list("contact" = new_contact))
cff_create <- function(x = ".", keys = NULL,
                       cff_version = "1.2.0") {

  # Find DESCRIPTION
  # Guess if root, package or DESCRIPTION
  if (isTRUE(grep("DESCRIPTION", x) == 1)) {
    desc_path <- x
  } else if (x == ".") {
    desc_path <- file.path(x, "DESCRIPTION")
  } else {
    desc_path <- file.path(find.package(x), "DESCRIPTION")
  }

  if (!file.exists(desc_path)) {
    stop("No DESCRIPTION file found with ", path, call. = FALSE)
  }

  cffobj <- cff_description(desc_path, cff_version)

  # Additional keys
  if (!is.null(keys)) {
    keys <- keys[names(keys) %in% cff_schema_keys()]
    cffobj <- drop_null(cffobj)

    cffobj <- cffobj[setdiff(names(cffobj), names(keys))]
    cffobj <- c(cffobj, keys)
  }


  # Order
  cffobj <- cffobj[cff_schema_keys()]

  cffobj <- drop_null(cffobj)
  cffobj <- as.cffr(cffobj)
  cffobj
}

# Print method

#' @export
print.cffr <- function(x, ...) {
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
