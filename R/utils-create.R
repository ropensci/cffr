#' @noRd
cff_description <- function(desc_path = "DESCRIPTION",
                            cff_version = "1.2.0",
                            gh_keywords = TRUE,
                            authors_roles = c("aut", "cre")) {
  pkg <- desc::desc(desc_path)
  pkg$coerce_authors_at_r()

  msg <- paste0(
    'To cite package "',
    pkg$get("Package"),
    '" in publications use:'
  )


  list_fields <- list(
    "cff-version" = cff_version,
    message = msg,
    type = "software",
    title = parse_desc_title(pkg),
    version = parse_desc_version(pkg),
    authors = parse_desc_authors(pkg, authors_roles = authors_roles),
    abstract = parse_desc_abstract(pkg),
    repository = parse_desc_repository(pkg),
    "repository-code" = parse_desc_urls(pkg)$repo,
    url = parse_desc_urls(pkg)$url,
    identifiers = parse_desc_urls(pkg)$identifiers,
    "date-released" = parse_desc_date_released(pkg),
    contact = parse_desc_contacts(pkg),
    keywords = parse_desc_keywords(pkg),
    license = unlist(parse_desc_license(pkg))
  )

  if (gh_keywords) {
    ghtopics <- parse_ghtopics(list_fields)
    list_fields$keywords <- unique(
      c(
        list_fields$keywords,
        ghtopics
      )
    )
  }

  list_fields <- as.cff(list_fields)
  list_fields
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
  cffobjend$identifiers <- c(citobj[[1]]$identifiers, oldids)

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
      mod[c("type", "title", "abstract", "notes", "url", "repository")],
      mod[!names(mod) %in% c(
        "type", "title", "abstract", "notes",
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
