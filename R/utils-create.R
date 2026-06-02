#' Merge the information of a coerced description with a coerced citation
#' @noRd
merge_desc_cit <- function(cffobj, citobj) {
  # Return the existing object if there is no citation object.

  if (is.null(citobj)) {
    return(cffobj)
  }
  # Handle CRAN DOI values.
  cran_doi <- NULL
  has_cran_doi <- FALSE
  if (all(!is.null(cffobj$doi), grepl("CRAN", cffobj$doi, fixed = TRUE))) {
    has_cran_doi <- TRUE
    cran_doi <- cffobj$doi
    # Let the citation object take precedence.
    cffobj$doi <- NULL
  }

  # Add DOI from the citation if it is missing.
  if (is.null(cffobj$doi)) {
    cffobj$doi <- clean_str(citobj[[1]]$doi)
  }

  citobj <- as.list(citobj)
  cffobjend <- c(
    cffobj,
    "preferred-citation" = citobj[1],
    references = list(citobj[-1])
  )

  # Merge identifiers.
  merged_ids <- c(citobj[[1]]$identifiers, cffobjend$identifiers)

  if (has_cran_doi) {
    cranid <- as_cff(list(list(type = "doi", value = clean_str(cran_doi))))
    merged_ids <- c(cranid, merged_ids)
  }
  cffobjend$identifiers <- merged_ids

  # Reorder keys.
  cffobjfinal <- c(
    cffobjend[!names(cffobjend) %in% c("identifiers", "references")],
    cffobjend["identifiers"],
    cffobjend["references"]
  )

  cffobjfinal <- drop_null(cffobjfinal)

  # Reclass the full object.
  cffobjfinal <- as_cff(as.list(cffobjfinal))

  cffobjfinal
}

#' Enhance authors info from preferred-citation using metadata from DESCRIPTION
#' @noRd
enhance_pref_authors <- function(cffobjend) {
  # Create an index of authors extracted from DESCRIPTION.
  auth_desc <- cffobjend$authors
  names(auth_desc) <- cff_author_keys(auth_desc)

  # Create an index of authors from `preferred-citation`.
  auth_pref <- cffobjend$`preferred-citation`$authors
  names(auth_pref) <- cff_author_keys(auth_pref)

  # Add missing keys to authors.
  enhancedauth <- lapply(names(auth_pref), function(x) {
    newdata <- auth_desc[x]
    olddata <- auth_pref[x]

    # Keep new fields only.
    oldkeys <- names(olddata[[1]])
    newkeys <- names(newdata[[1]])
    fieldstoadd <- newdata[[1]][!newkeys %in% oldkeys]

    newinfo <- c(olddata[[1]], fieldstoadd)

    newinfo
  })

  enhancedauth
}

cff_author_keys <- function(authors) {
  unlist(lapply(authors, cff_author_key))
}

cff_author_key <- function(author) {
  key_parts <- list(
    author["family-names"],
    author["given-names"],
    author["name"]
  )
  key_parts <- unlist(drop_null(key_parts))
  tolower(paste0(key_parts, collapse = ""))
}

get_dependencies <- function(
  desc_path,
  instpack = as.character(installed.packages()[, "Package"])
) {
  # nocov start
  if (!is.character(desc_path)) {
    return(NULL)
  }
  if (!file_exist_abort(desc_path)) {
    return(NULL)
  }
  # nocov end

  getdeps <- desc::desc(desc_path)

  deps <- cff_dependency_rows(getdeps$get_deps())

  av_deps <- deps[deps$package %in% c("R", instpack), ]

  # Get references from dependency DESCRIPTION files.
  cff_deps <- lapply(seq_len(nrow(av_deps)), function(y) {
    cff_dependency_reference(av_deps[y, ])
  })

  cff_deps <- drop_null(cff_deps)

  cff_deps <- unique(cff_deps)

  class(cff_deps) <- "cff"

  cff_deps
}

cff_dependency_rows <- function(deps) {
  deps$version_clean <- gsub("*", "", deps$version, fixed = TRUE)

  origdeps <- deps
  deps <- unique(deps[, c("package", "version_clean")])
  deps$scope <- vapply(
    deps$package,
    function(x) origdeps[origdeps$package == x, "type"][1],
    FUN.VALUE = character(1)
  )

  deps
}

cff_dependency_reference <- function(dep) {
  mod <- cff_dependency_citation(dep$package)

  if (is.null(mod)) {
    return(NULL) # nocov
  }

  mod$type <- "software"
  mod$version <- ifelse(
    is.na(dep$version_clean),
    NULL,
    paste(dep$version_clean)
  )
  mod <- cff_dependency_desc_fields(mod, dep$package)
  mod <- drop_null(mod)
  mod$year <- cff_dependency_year(mod)
  mod$notes <- clean_str(dep$scope)

  as_cff(cff_dependency_order(mod))
}

cff_dependency_citation <- function(package) {
  if (package == "R") {
    mod <- as_cff(citation())[[1]]
    mod$year <- format(Sys.Date(), "%Y")
    return(mod)
  }

  mod <- try(
    as_cff(citation(package, auto = TRUE)[1])[[1]],
    silent = TRUE
  )

  if (inherits(mod, "try-error")) {
    return(NULL) # nocov
  }

  # Simplify the `cff` object to avoid cluttering the output.
  mod$abstract <- mod$title
  mod$title <- package

  if (is_cran_dependency(package)) {
    mod$doi <- paste0("10.32614/CRAN.package.", package)
  }

  mod
}

is_cran_dependency <- function(package) {
  avail <- get_avail_on_init()
  base_packages <- rownames(installed.packages(priority = "base"))

  all(package %in% avail$Package, !package %in% base_packages)
}

cff_dependency_desc_fields <- function(mod, package) {
  # Get URL and repository from package DESCRIPTION.
  # URLs from citation() vary due to auto = TRUE.
  dfile <- system.file("DESCRIPTION", package = package)

  if (file_exist_abort(dfile)) {
    pkg <- desc::desc(dfile)
    mod$url <- get_desc_urls(pkg)$url
    mod$repository <- get_desc_repository(pkg)
  }

  mod
}

cff_dependency_year <- function(mod) {
  date_rel <- mod[["date-released"]]

  if (is.null(date_rel)) {
    return(format(Sys.Date(), "%Y"))
  }

  format(as.Date(date_rel), "%Y")
}

cff_dependency_order <- function(mod) {
  first_keys <- c("type", "title", "abstract", "notes", "url", "repository")
  c(mod[first_keys], mod[!names(mod) %in% first_keys])
}
