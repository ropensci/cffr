#' Create `cff` object
#'
#' @description
#' Create a [`cff`] object from a given source for further manipulation.
#' Similar to [cff_write()], but returns a object rather than writing
#' directly to a file. See **Examples**.
#'
#' @return A [`cff`] list object.
#'
#' @family core functions
#'
#' @export
#'
#' @param x The source that would be used for generating
#'   the [`cff`] object. It could be:
#'   * An existing [`cff`] object,
#'   * The path to package root (`"."`),
#'   * The name of an installed package (`"jsonlite"`), or
#'   * Path to a DESCRIPTION file (`"*/DESCRIPTION*"`).
#'
#' @param keys List of additional keys to add to the [`cff`] object. See
#'   **Details**.
#' @param cff_version The Citation File Format schema version that the
#'   `CITATION.cff` file adheres to for providing the citation metadata.
#'
#' @seealso [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).
#'
#' @details
#'
#' It is possible to add additional keys not detected by [cff_create()] using
#' the `keys` argument. A list of valid keys can be retrieved with
#' [cff_schema_keys()].
#'
#' Please refer to [Guide to Citation File Format schema version 1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md)
#' for additional details.
#'
#'
#' @examples
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

  # Set initially citobj to NULL
  citobj <- NULL
  if (is.cff(x)) {
    # It is already an object
    cffobj <- x
    cffobj["cff-version"] <- cff_version
  } else {
    # Need to parse
    # Find DESCRIPTION
    # Guess if root, package or DESCRIPTION
    if (isTRUE(grep("DESCRIPTION", x) == 1)) {
      desc_path <- x
    } else if (x == ".") {
      # nocov start
      desc_path <- file.path(x, "DESCRIPTION")
      cit_path <- file.path(x, "inst/CITATION")
      if (file.exists(cit_path)) {
        citobj <- parse_r_citation(desc_path, cit_path)
        citobj <- lapply(citobj, cff_parse_citation)
      }
      # nocov end
    } else {
      desc_path <- file.path(find.package(x), "DESCRIPTION")
      # Parse citation from installation
      citobj <- citation(x)
      citobj <- lapply(citobj, cff_parse_citation)
    }

    if (!file.exists(desc_path)) {
      stop("No DESCRIPTION file found with ", x, call. = FALSE)
    }

    cffobj <- cff_description(desc_path, cff_version)
  }

  # Add cffobj

  cffobj$doi <- clean_str(citobj[[1]]$doi)
  cffobjend <- c(cffobj,
    "preferred-citation" = citobj[1],
    references = list(citobj[-1])
  )



  # Add DOI to identifiers
  if (!is.null(cffobjend$doi)) {
    oldids <- cffobjend$identifiers
    cffobjend$identifiers <- c(
      list(list(type = "doi", value = cffobjend$doi)),
      oldids
    )
  }



  # Additional keys
  if (!is.null(keys)) {
    keys <- keys[names(keys) %in% cff_schema_keys()]
    cffobjend <- drop_null(cffobjend)

    cffobjend <- cffobjend[setdiff(names(cffobjend), names(keys))]
    cffobjend <- c(cffobjend, keys)
  }


  # Order
  cffobjend <- cffobjend[cff_schema_keys()]

  cffobjend <- as.cff(cffobjend)
  cffobjend
}
