#' Merge the information of a coerced description with a coerced citation
#' @noRd
merge_desc_cit <- function(cffobj, citobj) {
  # If no citobj then return null

  if (is.null(citobj)) {
    return(cffobj)
  }
  # Play with cran DOI
  cran_doi <- NULL
  has_cran_doi <- FALSE
  if (all(!is.null(cffobj$doi), grepl("CRAN", cffobj$doi))) {
    has_cran_doi <- TRUE
    cran_doi <- cffobj$doi
    # First the citation object
    cffobj$doi <- NULL
  }

  # Add doi from citation if missing
  if (is.null(cffobj$doi)) {
    cffobj$doi <- clean_str(citobj[[1]]$doi)
  }

  citobj <- as.list(citobj)
  cffobjend <- c(cffobj,
    "preferred-citation" = citobj[1],
    references = list(citobj[-1])
  )



  # Merge identifiers
  merged_ids <- c(citobj[[1]]$identifiers, cffobjend$identifiers)


  if (has_cran_doi) {
    cranid <- as_cff(list(
      list(type = "doi", value = clean_str(cran_doi))
    ))
    merged_ids <- c(cranid, merged_ids)
  }
  cffobjend$identifiers <- merged_ids

  # Reorder
  cffobjfinal <- c(
    cffobjend[!names(cffobjend) %in% c("identifiers", "references")],
    cffobjend["identifiers"],
    cffobjend["references"]
  )

  cffobjfinal <- drop_null(cffobjfinal)

  # Reclass everything
  cffobjfinal <- as_cff(as.list(cffobjfinal))
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


get_dependencies <- function(desc_path,
                             instpack = as.character(
                               installed.packages()[, "Package"]
                             )) {
  # nocov start
  if (!is.character(desc_path)) {
    return(NULL)
  }
  if (!file_exist_abort(desc_path)) {
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
  scope <- vapply(deps$package, function(x) {
    y <- origdeps[origdeps$package == x, "type"]

    y[1]
  }, FUN.VALUE = character(1))
  deps$scope <- scope

  av_deps <- deps[deps$package %in% c("R", instpack), ]

  # Get references from DESCRIPTION of dependencies
  cff_deps <- lapply(seq_len(nrow(av_deps)), function(y) {
    n <- av_deps[y, ]

    if (n$package == "R") {
      mod <- as_cff(citation())[[1]]
      mod$year <- format(Sys.Date(), "%Y")
    } else {
      mod <- try(as_cff(citation(n$package, auto = TRUE)[1])[[1]],
        silent = TRUE
      )

      if (inherits(mod, "try-error")) {
        return(NULL)
      }

      # Simplified version of the cff obj
      # Avoid cluttering the output
      mod$abstract <- mod$title
      mod$title <- n$package
      # If on CRAN add CRAN DOI
      if (!is.null(n$package)) {
        mod$doi <- paste0("10.32614/CRAN.package.", n$package)
      }
    }

    mod$type <- "software"
    mod$version <- ifelse(is.na(n$version_clean),
      NULL,
      paste(n$version_clean)
    )
    # Get url and repo from package DESCRIPTION
    # urls from citation() vary due to auto = TRUE
    dfile <- system.file("DESCRIPTION", package = n$package)

    if (file_exist_abort(dfile)) {
      pkg <- desc::desc(dfile)
      mod$url <- get_desc_urls(pkg)$url
      mod$repository <- get_desc_repository(pkg)
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
      mod[c("type", "title", "abstract", "notes", "url", "repository")],
      mod[!names(mod) %in% c(
        "type", "title", "abstract", "notes",
        "url", "repository"
      )]
    )

    mod <- as_cff(mod)
  })

  cff_deps <- drop_null(cff_deps)

  cff_deps <- unique(cff_deps)

  class(cff_deps) <- "cff"

  return(cff_deps)
}
