#' Create a [`cff`][cff-class] object
#'
#' @description
#'
#' Create a [`cff`][cff-class] object from a given source for further
#' manipulation. This object can be written to a `*.cff ` file with
#' [cff_write()], see **Examples**.
#'
#' Most of the heavy lifting of \CRANpkg{cffr} is done via this function.
#'
#' @return A [`cff`][cff-class] object.
#'
#' @family core
#'
#' @export
#'
#' @param x The source that would be used for generating
#'   the [`cff`][cff-class] object. It could be:
#'   * A missing value. That would retrieve the `DESCRIPTION` file on your
#'     in-development **R** package.
#'   * An existing [`cff`][cff-class] object,
#'   * The name of an installed package (`"jsonlite"`), or
#'   * Path to a `DESCRIPTION` file (`"./DESCRIPTION"`).
#'
#' @param keys
#'   List of additional keys to add to the [`cff`][cff-class] object. See
#'   **Details**.
#' @param cff_version The Citation File Format schema version that the
#'   `CITATION.cff` file adheres to for providing the citation metadata.
#' @param gh_keywords Logical `TRUE/FALSE`. If the package is hosted on
#'   GitHub, would you like to add the repo topics as keywords?
#' @param dependencies Logical `TRUE/FALSE`. Would you like to add the
#'   of your package to the `references` CFF key?
#' @param authors_roles Roles to be considered as authors of the package when
#'   generating the `CITATION.cff` file. See **Details**.
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
#'
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
#' If `x` is a path to a `DESCRIPTION` file or `inst/CITATION`, is not present
#' on your package, \CRANpkg{cffr} would auto-generate a `preferred-citation`
#' key using the information provided on that file.
#'
#' By default, only persons whose role in the `DESCRIPTION` file of the package
#' is author (`"aut"`) or maintainer (`"cre"`) are considered to be authors
#' of the package. The default setting can be controlled via the `authors_roles`
#' parameter. See **Details** on [utils::person()] to get additional insights
#' on person roles.
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
#'   authors = as_cff_person("New author")
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
#'   as_cff_person(person(
#'     given = "I am",
#'     family = "New Contact"
#'   ))
#' )
#'
#'
#' cff_create(demo_file, keys = list("contact" = new_contact))
#' }
cff_create <- function(x, keys = list(), cff_version = "1.2.0",
                       gh_keywords = TRUE, dependencies = TRUE,
                       authors_roles = c("aut", "cre")) {
  # On missing use package root
  if (missing(x)) x <- getwd()

  if (!is_cff(x) && !is.character(x)) {
    msg <- "{.arg x} should be a {.cls cff} or {.cls character} object."
    cli::cli_abort(msg)
  }

  # Detect sources and build cff
  result_parsed <- detect_sources(
    x, cff_version, gh_keywords,
    dependencies, authors_roles
  )

  desc_path <- result_parsed[["desc_path"]]
  instpack <- result_parsed[["instpack"]]
  cffobjend <- result_parsed[["cffobjend"]]



  # Add software dependencies
  if (dependencies) {
    deps <- parse_dependencies(desc_path, instpack)

    cffobjend$references <- unique(c(cffobjend$references, deps))
  }

  # Additional keys
  if (!is.null(keys)) {
    keys <- fuzzy_keys(keys)
    cffobjendmod <- cffobjend[setdiff(names(cffobjend), names(keys))]
    cffobjend <- modifyList(cffobjendmod, keys, keep.null = FALSE)
    cffobjend <- as.cff(cffobjend)
  }


  # Order
  cffobjend <- cffobjend[cff_schema_keys()]

  # Enhance authors info
  if (!is.null(cffobjend$`preferred-citation`)) {
    cffobjend$`preferred-citation`$authors <- enhance_pref_authors(cffobjend)
  }
  cffobjend <- as.cff(cffobjend)
  cffobjend
}

detect_sources <- function(x, cff_version = "1.2.0",
                           gh_keywords = TRUE, dependencies = TRUE,
                           authors_roles = c("aut", "cre")) {
  instpack <- as.character(installed.packages()[, "Package"])

  # Set initially citobj to NULL
  citobj <- NULL
  desc_path <- NULL

  # Paths
  if (is_cff(x)) {
    # It is already an object
    cffobj <- x
    cffobj["cff-version"] <- cff_version
  } else {
    # Detect a package
    if (x %in% instpack) x <- file.path(find.package(x), "DESCRIPTION")
    # If is on the root create DESCRIPTION path
    if (x == getwd()) x <- file.path(x, "DESCRIPTION")

    if (isTRUE(grep("DESCRIPTION", x) == 1)) {
      # Call for a DESCRIPTION file
      desc_path <- x
      # Look if a CITATION file on inst/ folder
      # for in-development packages
      cit_path <- gsub("DESCRIPTION$", "inst/CITATION", x)
      # If it doesn't exists look on the root
      # this is for call to installed packages with system.file()
      if (!file.exists(cit_path)) {
        cit_path <- gsub("DESCRIPTION$", "CITATION", x)
      }
      if (file.exists(cit_path)) {
        citobj <- cff_safe_read_citation(desc_path, cit_path)
        if (length(citobj) == 0) citobj <- NULL
        citobj <- drop_null(citobj)
        citobj <- unname(citobj)
      }
    } else {
      msg <- paste0(
        "{.arg x} ({x}) not valid. If it is a package ",
        "you may need to install it with ",
        "{.fn install.packages}"
      )
      cli::cli_abort(msg)
    }

    if (!file.exists(desc_path)) {
      cli::cli_abort("No {.file DESCRIPTION} file found with {.arg x}")
    }

    cffobj <- cff_read_description(desc_path, cff_version,
      gh_keywords = gh_keywords,
      authors_roles = authors_roles
    )
  }

  citobj <- unique(citobj)

  # Merge DESCRIPTION and CITATION

  cffobjend <- merge_desc_cit(cffobj, citobj)

  # Return collected info

  list(
    desc_path = desc_path,
    instpack = instpack,
    cffobjend = cffobjend
  )
}
