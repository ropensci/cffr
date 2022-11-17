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
#' @param gh_keywords Logical `TRUE/FALSE`. If the package is hosted on
#'   GitHub, would you like to add the repo topics as keywords?
#' @param dependencies Logical `TRUE/FALSE`. Would you like to add the
#'   of your package to the `reference` key?
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
cff_create <- function(x,
                       keys = list(),
                       cff_version = "1.2.0",
                       gh_keywords = TRUE,
                       dependencies = TRUE) {
  # On missing use package root
  if (missing(x)) x <- getwd()

  if (!is.cff(x) && !is.character(x)) {
    stop("x should be a cff or a character",
      call. = FALSE
    )
  }

  instpack <- as.character(installed.packages()[, "Package"])

  # Set initially citobj to NULL
  citobj <- NULL
  desc_path <- NULL

  # Paths
  if (is.cff(x)) {
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
        cit_path <- gsub(
          "DESCRIPTION$",
          "CITATION", x
        )
      }
      if (file.exists(cit_path)) {
        citobj <- parse_r_citation(desc_path, cit_path)
        citobj <- lapply(citobj, cff_parse_citation)
        if (length(citobj) == 0) citobj <- NULL
        citobj <- drop_null(citobj)
      }
    } else {
      stop("object x: '", x, "' not valid. If it is a package ",
        "you may need to install it.",
        call. = FALSE
      )
    }

    if (!file.exists(desc_path)) {
      stop("No DESCRIPTION file found with ", x, call. = FALSE)
    }

    cffobj <- cff_description(desc_path, cff_version,
      gh_keywords = gh_keywords
    )
  }

  citobj <- unique(citobj)

  # Merge DESCRIPTION and CITATION

  cffobjend <- merge_desc_cit(cffobj, citobj)

  # Add software dependencies
  if (dependencies) {
    deps <- parse_dependencies(desc_path, instpack)

    cffobjend$references <- unique(c(
      cffobjend$references,
      deps
    ))
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


#' Merge the information of a parsed description with a parsed citation
#' @noRd
merge_desc_cit <- function(cffobj, citobj) {
  # If no citobj then return null

  if (is.null(citobj)) {
    return(cffobj)
  }

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

  # Reorder
  cffobjfinal <- c(
    cffobjend[!names(cffobjend) %in% c("identifiers", "references")],
    cffobjend["identifiers"],
    cffobjend["references"]
  )

  cffobjfinal <- drop_null(cffobjfinal)

  return(cffobjfinal)
}

#' Enhance authors info from preferred-citation using metadata from DESCRIPTION
#' @noRd
enhance_pref_authors <- function(cffobjend) {
  # Create index of authors extracted from DESCRIPTION (First cff level)
  auth_desc <- cffobjend$authors
  key_aut_desc <- lapply(auth_desc, function(x) {
    l <- list(x["family-names"], x["given-names"], x["name"])
    l <- unlist(drop_null(l))
    tolower(paste0(l, collapse = ""))
  })
  names(auth_desc) <- unlist(key_aut_desc)

  # Create index of authors from preferred-citation
  auth_pref <- cffobjend$`preferred-citation`$authors
  key_aut_cit <- lapply(auth_pref, function(x) {
    l <- list(x["family-names"], x["given-names"], x["name"])
    l <- unlist(drop_null(l))
    tolower(paste0(l, collapse = ""))
  })
  names(auth_pref) <- unlist(key_aut_cit)

  # Add missing keys to authors
  enhancedauth <- lapply(names(auth_pref), function(x) {
    newdata <- auth_desc[x]
    olddata <- auth_pref[x]

    # New fields only
    oldkeys <- names(olddata[[1]])
    newkeys <- names(newdata[[1]])
    fieldstoadd <- newdata[[1]][!newkeys %in% oldkeys]

    newinfo <- c(olddata[[1]], fieldstoadd)

    newinfo
  })

  enhancedauth
}


parse_dependencies <- function(desc_path,
                               instpack = as.character(
                                 installed.packages()[, "Package"]
                               )) {
  # nocov start
  if (!is.character(desc_path)) {
    return(NULL)
  }
  if (!file.exists(desc_path)) {
    return(NULL)
  }
  # nocov end

  getdeps <- desc::desc(desc_path)

  deps <- getdeps$get_deps()

  # Adapt version

  deps$version_clean <- gsub("*", "", deps$version, fixed = TRUE)

  # Save copy for later
  origdeps <- deps

  # Dedupe rows
  deps <- unique(deps[, c("package", "version_clean")])


  # Get dependency type and add to scope
  scope <- vapply(deps$package,
    FUN.VALUE = character(1),
    function(x) {
      y <- origdeps[origdeps$package == x, "type"]

      y[1]
    }
  )
  deps$scope <- scope

  av_deps <- deps[deps$package %in% c("R", instpack), ]

  # Get references from DESCRIPTION of dependencies
  cff_deps <- lapply(seq_len(nrow(av_deps)), function(y) {
    n <- av_deps[y, ]

    if (n$package == "R") {
      mod <- cff_parse_citation(citation()[1])
      mod$year <- format(Sys.Date(), "%Y")
    } else {
      mod <- try(cff_parse_citation(citation(n$package, auto = TRUE)[1]),
        silent = TRUE
      )

      if (inherits(mod, "try-error")) {
        return(NULL)
      }

      # Simplified version of the cff obj
      # Avoid cluttering the output
      mod$abstract <- mod$title
      mod$title <- n$package
    }

    mod$type <- "software"
    mod$version <- ifelse(is.na(n$version_clean),
      NULL,
      paste(n$version_clean)
    )
    # Get url and repo from package DESCRIPTION
    # urls from citation() vary due to auto = TRUE
    dfile <- system.file("DESCRIPTION", package = n$package)

    if (file.exists(dfile)) {
      pkg <- desc::desc(dfile)
      mod$url <- parse_desc_urls(pkg)$url
      mod$repository <- parse_desc_repository(pkg)
    }

    mod <- drop_null(mod)

    # Get year
    date_rel <- mod[["date-released"]]

    if (is.null(date_rel)) {
      year <- format(Sys.Date(), "%Y")
    } else {
      year <- format(as.Date(date_rel), "%Y")
    }

    mod$year <- year
    mod$notes <- clean_str(n$scope)

    # Re-arrange
    mod <- c(
      mod[c(
        "type",
        "title", "abstract",
        "notes",
        "url", "repository"
      )],
      mod[!names(mod) %in% c(
        "type",
        "title", "abstract",
        "notes",
        "url", "repository"
      )]
    )

    mod <- as.cff(mod)
  })

  cff_deps <- drop_null(cff_deps)

  cff_deps <- unique(cff_deps)

  class(cff_deps) <- "cff"

  return(cff_deps)
}
