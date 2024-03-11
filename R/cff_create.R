#' Create a [`cff`] object from several sources
#'
#' @description
#'
#' Create a full and possibly valid [`cff`] object from a given source. This
#' object can be written to a `*.cff ` file with [cff_write()],
#' see **Examples**.
#'
#' Most of the heavy lifting of \CRANpkg{cffr} is done via this function.
#'
#' @return A [`cff`] object.
#'
#' @family core
#'
#' @export
#'
#' @param x The source that would be used for generating
#'   the [`cff`] object. It could be:
#'   * A missing value. That would retrieve the `DESCRIPTION` file on your
#'     in-development **R** package.
#'   * An existing [`cff`] object.
#'   * The name of an installed package (`"jsonlite"`).
#'   * Path to a `DESCRIPTION` file (`"./DESCRIPTION"`).
#'
#' @param keys
#'   List of additional keys to add to the [`cff`] object. See
#'   [cff_modify()].
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
#' - [cff_modify()] as the recommended way to modify a `cff` object.
#' - [cff_write()] for creating a CFF file.
#' - `vignette("cffr", "cffr")` shows an introduction on how manipulate
#'   `cff` objects.
#' - `vignette("crosswalk", package = "cffr")` provides details on how the
#'  metadata of a package is mapped to produce a `cff` object.
#'
#' @details
#'
#' If `x` is a path to a `DESCRIPTION` file or `inst/CITATION`, is not present
#' on your package, \CRANpkg{cffr} would auto-generate a `preferred-citation`
#' key using the information provided on that file.
#'
#' By default, only persons whose role in the `DESCRIPTION` file of the package
#' is author (`"aut"`) or maintainer (`"cre"`) are considered to be authors
#' of the package. The default setting can be controlled via the `authors_roles`
#' parameter. See **Details** on [person()] to get additional insights
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
  # Guess source
  # On missing add getwd()
  if (missing(x)) {
    hint_source <- "indev"
    x <- getwd()
  } else if (identical(getwd(), x)) {
    # This case is coming from cff_write
    hint_source <- "indev"
  } else {
    hint_source <- detect_x_source(x)
  }

  # Abort in non-valid sources
  valid_sources <- c("indev", "cff_obj", "package", "description")
  if (!hint_source %in% valid_sources) {
    # Abort, prepare message
    msg_hint <- switch(hint_source,
      "dontknow" = paste0(
        "If it is a package ",
        "you may need to install it with ",
        "{.fn install.packages}."
      ),
      "bib" = "Maybe try with {.fn cff_read}."
    )

    cli::cli_abort(
      paste0("{.arg x} not valid. ", msg_hint)
    )
  }

  # Build cff and return paths if any
  result_paths <- build_cff_and_paths(
    x, cff_version, gh_keywords,
    dependencies, authors_roles, hint_source
  )

  desc_path <- result_paths[["desc_path"]]
  cffobjend <- result_paths[["cffobjend"]]



  # Add software dependencies
  if (dependencies) {
    instpack <- as.character(installed.packages()[, "Package"])
    deps <- get_dependencies(desc_path, instpack)

    cffobjend$references <- unique(c(cffobjend$references, deps))
  }

  # Additional keys, using internals of cff_modify
  cffobjend <- modify_cff(cffobjend, keys, "keys")

  # Order
  cffobjend <- cffobjend[cff_schema_keys()]

  # Enhance authors info
  if (!is.null(cffobjend$`preferred-citation`)) {
    cffobjend$`preferred-citation`$authors <- enhance_pref_authors(cffobjend)
  }
  cffobjend <- as_cff(cffobjend)
  cffobjend
}

build_cff_and_paths <- function(x, cff_version = "1.2.0",
                                gh_keywords = TRUE, dependencies = TRUE,
                                authors_roles = c("aut", "cre"), hint_source) {
  collect_list <- list(
    desc_path = NULL,
    cffobjend = NULL
  )

  # "indev", "cff_obj", "package", "description"

  # Already cff, return it
  if (is_cff(x)) {
    # It is already an object
    cffobj <- as_cff(as.list(x))
    cffobj["cff-version"] <- cff_version

    collect_list$cffobjend <- cffobj
    return(collect_list)
  }

  # Get info from DESCRIPTION
  desc_path <- switch(hint_source,
    "indev" = file.path(getwd(), "DESCRIPTION"),
    "description" = x,
    "package" = system.file("DESCRIPTION", package = x)
  )

  if (is.null(file_path_or_null(desc_path))) {
    cli::cli_abort("No {.file DESCRIPTION} file found with {.arg x}.")
  }

  cffobj <- cff_read_description(desc_path, cff_version,
    gh_keywords = gh_keywords,
    authors_roles = authors_roles
  )


  # Just for description case
  try_get_citation <- function(x) {
    cit1 <- file.path(dirname(x), "inst/CITATION")
    cit2 <- file.path(dirname(x), "CITATION")

    c(file_path_or_null(cit1), file_path_or_null(cit2))[1]
  }

  cit_path <- switch(hint_source,
    "indev" = file.path(getwd(), "inst/CITATION"),
    "description" = try_get_citation(x),
    "package" = system.file("CITATION", package = x)
  )

  cit_path <- file_path_or_null(cit_path[1])

  if (!is.null(cit_path)) {
    citobj <- cff_safe_read_citation(desc_path, cit_path)
    citobj <- unique(citobj)
    # Merge DESCRIPTION and CITATION
    cffobj <- merge_desc_cit(cffobj, citobj)
  }

  collect_list$desc_path <- desc_path
  collect_list$cffobjend <- cffobj

  return(collect_list)
}
