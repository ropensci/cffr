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
#'   * A missing value. That would retrieve the DESCRIPTION
#'     file on your in-development package.
#'   * An existing [`cff`] object,
#'   * The name of an installed package (`"jsonlite"`), or
#'   * Path to a DESCRIPTION file (`"*/DESCRIPTION*"`).
#'
#' @param keys List of additional keys to add to the [`cff`] object. See
#'   **Details**.
#' @param cff_version The Citation File Format schema version that the
#'   `CITATION.cff` file adheres to for providing the citation metadata.
#'
#' @seealso
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("[Guide to Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#'
#' `vignette("cffr", "cffr")`
#' @details
#'
#' It is possible to add additional keys not detected by [cff_create()] using
#' the `keys` argument. A list of valid keys can be retrieved with
#' [cff_schema_keys()].
#'
#'
#' Please refer to
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("\n", "[Guide to Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#' for additional details.
#'
#' If `x` is a path to a DESCRIPTION file or `inst/CITATION`, is not present on
#' your package, **cffr** would auto-generate a `preferred-citation` key using
#' the information provided on that file. On
#'
#'
#' @examples
#' \donttest{
#' # Installed package
#' cff_create("jsonlite")
#'
#' # Demo file
#' demo_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
#' cff_create(demo_file)
#'
#' # Add additional keys
#'
#' newkeys <- list(
#'   message = "This overwrites fields",
#'   abstract = "New abstract",
#'   keywords = c("A", "new", "list", "of", "keywords"),
#'   authors = list(cff_parse_person("New author"))
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
#' }
cff_create <- function(x, keys = list(),
                       cff_version = "1.2.0") {
  if (missing(x)) x <- getwd()


  if (!is.cff(x) && !is.character(x)) {
    stop("x should be a cff or a character",
      call. = FALSE
    )
  }

  instpack <- as.character(installed.packages()[, "Package"])

  # Set initially citobj to NULL
  citobj <- NULL

  # Paths
  if (is.cff(x)) {

    # It is already an object
    cffobj <- x
    cffobj["cff-version"] <- cff_version
  } else {
    # Need to parse with desc_path

    if (x %in% instpack) {

      # Installed package, have to parse
      desc_path <- file.path(find.package(x), "DESCRIPTION")

      # Parse citation from installation
      citobj <- lapply(citation(x), cff_parse_citation)
      if (length(citobj) == 0) citobj <- NULL
      citobj <- drop_null(citobj)
    } else if (x == getwd()) {

      # In development package
      # nocov start
      desc_path <- file.path(x, "DESCRIPTION")
      cit_path <- file.path(x, "inst/CITATION")
      if (file.exists(cit_path)) {
        citobj <- parse_r_citation(desc_path, cit_path)
        citobj <- lapply(citobj, cff_parse_citation)
        if (length(citobj) == 0) citobj <- NULL
        citobj <- drop_null(citobj)
      }
      # nocov end
    } else if (isTRUE(grep("DESCRIPTION", x) == 1)) {
      desc_path <- x
    } else {
      stop("object x: '", x, "' not valid. If it is a package ",
        "you may need to install it.",
        call. = FALSE
      )
    }

    if (!file.exists(desc_path)) {
      stop("No DESCRIPTION file found with ", x, call. = FALSE)
    }

    cffobj <- cff_description(desc_path, cff_version)
  }

  citobj <- unique(citobj)

  # Merge DESCRIPTION and CITATION

  cffobjend <- merge_desc_cit(cffobj, citobj)


  # Additional keys
  if (!is.null(keys)) {
    keys <- fuzzy_keys(keys)
    cffobjendmod <- cffobjend[setdiff(names(cffobjend), names(keys))]
    cffobjend <- modifyList(cffobjendmod, keys, keep.null = FALSE)
    cffobjend <- as.cff(cffobjend)
  }


  # Order
  cffobjend <- cffobjend[cff_schema_keys()]

  cffobjend <- as.cff(cffobjend)
  cffobjend
}


#' Merge the information of a parsed description with a parsed citation
#' @noRd
merge_desc_cit <- function(cffobj, citobj) {

  # Add doi from citation if missing
  if (is.null(cffobj$doi)) {
    cffobj$doi <- clean_str(citobj[[1]]$doi)
  }
  cffobjend <- c(cffobj,
    "preferred-citation" = citobj[1],
    references = list(citobj[-1])
  )



  # Merge identifiers
  oldids <- cffobjend$identifiers
  cffobjend$identifiers <- c(
    citobj[[1]]$identifiers,
    oldids
  )

  # Add auto preferred if not present
  if (is.null(cffobjend[["preferred-citation"]])) {
    pref_auto <- parse_preferred_auto(cffobjend)
    cffobjend <- c(cffobjend,
      "preferred-citation" = list(pref_auto)
    )
  }

  return(cffobjend)
}
