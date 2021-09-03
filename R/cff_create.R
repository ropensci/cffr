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
#'
#' @export
#'
#' @param path path to package root (`"."`), or package name (`"jsonlite"`), or
#'   description file (`"*/DESCRIPTION*"`).
#'
#' @param keys List of additional keys to add to the `ccfr` object. See
#'  **Details**.
#'
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
#'   authors = list(list(
#'     "family-names" = "Doe",
#'     "given-names" = "John"
#'   )),
#'   "date-released" = "1900-01-01"
#' )
#'
#' cff_create(demo_file, keys = newkeys)
#'
#' # Update a field
#' # New author
#'
#' old <- cff_create(demo_file)
#'
#' old_aut <- old$authors
#'
#' # It should be a list
#' new_aut <- append(
#'   old_aut,
#'   list(list(
#'     "family-names" = "new author",
#'     "given-names" = "I am a",
#'     alias = "Hello!"
#'   ))
#' )
#'
#' cff_create(demo_file, keys = list("authors" = new_aut))
cff_create <- function(path = ".", keys = NULL) {

  # Find DESCRIPTION
  # Guess if root, package or DESCRIPTION
  if (isTRUE(grep("DESCRIPTION", path) == 1)) {
    desc_path <- path
  } else if (path == ".") {
    desc_path <- file.path(path, "DESCRIPTION")
  } else {
    desc_path <- file.path(find.package(path), "DESCRIPTION")
  }

  if (!file.exists(desc_path)) {
    stop("No DESCRIPTION file found with ", path, call. = FALSE)
  }

  cffobj <- cff_description(desc_path)

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
  class(cffobj) <- "cffr"

  cffobj
}

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