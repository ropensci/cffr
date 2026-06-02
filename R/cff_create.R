#' Create a [`cff`] object from several sources
#'
#' @description
#' Create a full and possibly valid [`cff`] object from a given source. This
#' object can be written to a `CITATION.cff` file with [cff_write()]. See
#' **Examples**.
#'
#' Most of the heavy lifting of \CRANpkg{cffr} is done by this function.
#'
#' @param x The source used to generate
#'   the [`cff`] object. It can be:
#'   - A missing value, which retrieves the `DESCRIPTION` file from your
#'     in-development \R package.
#'   - An existing [`cff`] object.
#'   - The name of an installed package (`"jsonlite"`).
#'   - Path to a `DESCRIPTION` file (`"./DESCRIPTION"`).
#'
#' @param keys
#'   List of additional keys to add to the [`cff`] object. See
#'   [cff_modify()].
#' @param cff_version The Citation File Format schema version that the
#'   `CITATION.cff` file adheres to for providing the citation metadata.
#' @param gh_keywords Logical `TRUE/FALSE`. If the package is hosted on
#'   GitHub, should the repository topics be added as keywords?
#' @param dependencies Logical `TRUE/FALSE`. Should the dependencies of your
#'   package be added to the `references` CFF key?
#' @param authors_roles Roles to be considered as authors of the package when
#'   generating the `CITATION.cff` file. See **Details**.
#'
#' @return A [`cff`] object.
#'
#' @details
#' If `x` is a path to a `DESCRIPTION` file, or if `inst/CITATION` is not
#' present in your package, \CRANpkg{cffr} auto-generates a
#' `preferred-citation` key using the information provided in that file.
#'
#' By default, only persons whose role in the `DESCRIPTION` file of the package
#' is author (`"aut"`) or maintainer (`"cre"`) are considered package authors.
#' The default setting can be controlled via the `authors_roles` argument. See
#' **Details** on [person()] for additional information about person roles.
#'
#' @seealso
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("[Guide to Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#' ```
#'
#' - [cff_modify()] as the recommended way to modify a `cff` object.
#' - [cff_write()] for creating a `CITATION.cff` file.
#' - `vignette("cffr", package = "cffr")` shows an introduction to
#'   manipulating [`cff`] objects.
#' - `vignette("r-cff", package = "cffr")` provides details on how the
#'   metadata of a package is mapped to produce a `cff` object.
#'
#' @family core
#' @export
#' @encoding UTF-8
#' @examples
#' \donttest{
#' # Installed package.
#' cff_create("jsonlite")
#'
#' # Demo file.
#' demo_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
#' cff_create(demo_file)
#'
#' # Add additional keys.
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
#' # Update a field on a list, for example authors or contacts.
#' # We are adding a new contact here.
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
#' cff_create(demo_file, keys = list("contact" = new_contact))
#' }
cff_create <- function(
  x,
  keys = list(),
  cff_version = "1.2.0",
  gh_keywords = TRUE,
  dependencies = TRUE,
  authors_roles = c("aut", "cre")
) {
  # Guess source.
  # Use the working directory when `x` is missing.
  if (missing(x)) {
    x <- getwd()
  }
  hint_source <- cff_source_hint(x)

  abort_invalid_cff_source(hint_source)

  # Build the CFF object and return paths if any.
  result_paths <- build_cff_and_paths(
    x,
    cff_version,
    gh_keywords,
    dependencies,
    authors_roles,
    hint_source
  )

  desc_path <- result_paths[["desc_path"]]
  cffobjend <- result_paths[["cffobjend"]]

  # Add software dependencies.
  if (dependencies) {
    instpack <- as.character(installed.packages()[, "Package"])
    deps <- get_dependencies(desc_path, instpack)

    cffobjend$references <- unique(c(cffobjend$references, deps))
  }

  # Add additional keys using internals from `cff_modify()`.
  cffobjend <- modify_cff(cffobjend, keys, "keys")

  # Order keys.
  cffobjend <- cffobjend[cff_schema_keys()]

  # Enhance author information.
  if (!is.null(cffobjend$`preferred-citation`)) {
    cffobjend$`preferred-citation`$authors <- enhance_pref_authors(cffobjend)
  }
  cffobjend <- as_cff(cffobjend)
  cffobjend
}

build_cff_and_paths <- function(
  x,
  cff_version = "1.2.0",
  gh_keywords = TRUE,
  dependencies = TRUE,
  authors_roles = c("aut", "cre"),
  hint_source
) {
  collect_list <- list(desc_path = NULL, cffobjend = NULL)

  # Return `x` when it is already a `cff` object.
  if (is_cff(x)) {
    # Ensure it uses the requested CFF version.
    cffobj <- as_cff(as.list(x))
    cffobj["cff-version"] <- cff_version

    collect_list$cffobjend <- cffobj
    return(collect_list)
  }

  # Get information from DESCRIPTION.
  desc_path <- cff_description_path(x, hint_source)

  if (is.null(file_path_or_null(desc_path))) {
    cli::cli_abort("No {.file DESCRIPTION} file found with {.arg x}.")
  }

  cffobj <- cff_read_description(
    desc_path,
    cff_version,
    gh_keywords = gh_keywords,
    authors_roles = authors_roles
  )

  cit_path <- cff_citation_path(x, hint_source)
  cit_path <- file_path_or_null(cit_path[1])

  if (!is.null(cit_path)) {
    citobj <- cff_safe_read_citation(desc_path, cit_path)
    citobj <- unique(citobj)
    # Merge DESCRIPTION and CITATION
    cffobj <- merge_desc_cit(cffobj, citobj)
  }

  collect_list$desc_path <- desc_path
  collect_list$cffobjend <- cffobj

  collect_list
}

cff_source_hint <- function(x) {
  # The working directory case comes from `cff_write()` and in-development use.
  if (identical(getwd(), x)) {
    return("indev")
  }

  detect_x_source(x)
}

abort_invalid_cff_source <- function(hint_source) {
  valid_sources <- c("indev", "cff_obj", "package", "description")
  if (hint_source %in% valid_sources) {
    return(invisible(NULL))
  }

  msg_hint <- switch(hint_source,
    "dontknow" = paste0(
      "If it is a package ",
      "you may need to install it with ",
      "{.fn install.packages}."
    ),
    "bib" = "Maybe try with {.fn cff_read}."
  )

  cli::cli_abort(paste0("{.arg x} is not valid. ", msg_hint))
}

cff_description_path <- function(x, hint_source) {
  switch(hint_source,
    "indev" = file.path(getwd(), "DESCRIPTION"),
    "description" = x,
    "package" = system.file("DESCRIPTION", package = x)
  )
}

cff_citation_path <- function(x, hint_source) {
  switch(hint_source,
    "indev" = file.path(getwd(), "inst/CITATION"),
    "description" = cff_citation_from_description(x),
    "package" = system.file("CITATION", package = x)
  )
}

cff_citation_from_description <- function(x) {
  cit1 <- file.path(dirname(x), "inst/CITATION")
  cit2 <- file.path(dirname(x), "CITATION")

  c(file_path_or_null(cit1), file_path_or_null(cit2))[1]
}
