# Utils functions used on the package

#' Clean strings
#'
#' @param str The string to be cleaned
#' @noRd
clean_str <- function(str) {
  # Collapse to single char
  str <- paste(str, collapse = " ")
  str <- unlist(str)
  if (is.null(str) || is.na(str)) {
    return(NULL)
  }

  clean <- gsub("[\n\r]", " ", str)
  clean <- gsub("\\s+", " ", clean)
  clean <- gsub("\\{", "", clean)
  clean <- gsub("\\}", "", clean)
  clean <- gsub("^NA$", "", clean)
  clean <- trimws(clean)
  # Collapse to single char
  clean <- paste(clean, collapse = " ")

  if (clean == "") {
    return(NULL)
  }
  # Encoding
  enc <- Encoding(clean)

  if (enc != "UTF-8") clean <- iconv(clean, to = "UTF-8")

  clean
}

#' Drop nulls from list
#' @source  https://github.com/cboettig/codemeta/blob/master/R/utils.R
#' @param x The list to be cleaned
#' @noRd
drop_null <- function(x) {
  # Already been here
  if (inherits(x, "cff")) {
    return(x)
  }
  x[lengths(x) != 0]
}


#' Pretty printing of snapshots
#' @noRd
print_snapshot <- function(title = "----", obj) {
  cat("\n\n##", title, "\n\n")
  print(obj)
  cat("\n---")
}

#' Search a package on available repos
#' @param name name of the package
#' @param avail Data frame with the packages available, See
#' [utils::available.packages()].
#' @param repos vector of repos
#' @noRd
search_on_repos <- function(name,
                            avail = avail_on_init,
                            repos = detect_repos()) {
  get <- avail[name == avail$Package, "Repository"]

  get <- clean_str(get)

  if (is.null(get)) {
    return(NULL)
  }

  # Try to find in CRAN
  cran_repo <- clean_str(repos["CRAN"])


  if (length(grep(cran_repo, get) == 1)) {
    # Canonical url to CRAN

    repos <- paste0("https://CRAN.R-project.org/package=", name)
    return(repos)
  }

  repos <- gsub("src/contrib$", "", get)

  repos
}


#' Detect current repos
#'
#' Detect the current repos of the user. If not set, use Cloud
#' @param repos Current repos setup
#' @noRd
detect_repos <- function(repos = getOption("repos")) {
  # Not use RSPM
  repos <- repos[names(repos) != "RSPM"]
  repos <- repos[!grepl("rspm", repos)]
  repos <- repos[!grepl("posit", repos)]
  repos <- repos[!grepl("rstudio", repos)]

  # If not set use 0-Cloud
  if (!is_url(repos["CRAN"])) {
    repos["CRAN"] <- "https://cloud.r-project.org/"
  }

  return(repos)
}

#' Function for fuzzy matching the names of the keys
#'
#' @description
#' Proposed by @sckott
#' @inheritParams cff_create
#' @noRd
fuzzy_keys <- function(keys) {
  nm <- names(keys)
  names(keys) <- gsub("_", "-", nm, fixed = TRUE)
  valid_keys <- unique(c(
    cff_schema_keys(), cff_schema_definitions_entity(),
    cff_schema_definitions_person(),
    cff_schema_definitions_refs()
  ))
  names <- names(keys)
  # Check valid keys as is
  is_valid_key <- names %in% valid_keys

  # If not all are valid try to fuzzy match
  if (isFALSE(all(is_valid_key))) {
    names_fuzzy <- names[!(is_valid_key)]

    keys_match <- lapply(names_fuzzy,
      agrep, valid_keys,
      ignore.case = TRUE,
      value = TRUE,
      fixed = FALSE
    )


    # Modify NULL correspondences
    keys_match <- unlist(lapply(
      keys_match,
      function(x) {
        if (length(x) == 0) {
          return("No match, removing.")
        }
        return(x[1])
      }
    ))

    # Message
    ll <- paste0("{.dt ", names_fuzzy, "}{.dl ", keys_match, "}")

    bullets <- rep("v", length(ll))
    bullets[keys_match == "No match, removing."] <- "x"
    names(ll) <- bullets
    cli::cli_alert_info(
      paste0("Found misspelled keys. Trying to map:")
    )

    cli::cli_bullets(ll)
    # Modify names
    names[!is_valid_key] <- keys_match
  }

  new_keys <- keys
  names(new_keys) <- names

  new_keys <- new_keys[names %in% valid_keys]

  return(new_keys)
}

guess_cff_named_part <- function(x) {
  nms <- names(x)
  # Search for names
  is_person <- any(grepl("^name$|family|given|particle", nms))
  if (is_person) {
    return("cff_pers")
  }

  # VALID full cff file
  is_full <- any(grepl("cff-version|message", nms))
  if (is_full) {
    return("cff_full")
  }

  # Reference
  is_ref <- any(grepl("title|type", nms))
  if (is_ref) {
    return("cff_ref")
  }

  # Else
  return("unclear")
}


guess_cff_part <- function(x) {
  named <- is_named(x)
  if (named) {
    return(guess_cff_named_part(x))
  }

  # Look to first element
  guess <- guess_cff_named_part(x[[1]])

  fin <- switch(guess,
    "cff_pers" = "cff_pers_lst",
    "cff_ref" = "cff_ref_lst",
    "unclear"
  )

  fin
}


detect_x_source <- function(x) {
  if (any(missing(x), is.null(x))) {
    return("indev")
  }

  if (is_cff(x)) {
    return("cff_obj")
  }

  x <- as.character(x)[1]
  instpack <- as.character(installed.packages()[, "Package"])

  if (x %in% instpack) {
    return("package")
  }


  if (grepl("\\.cff$", x, ignore.case = TRUE)) {
    return("cff_citation")
  }
  if (grepl("\\.bib$", x, ignore.case = TRUE)) {
    return("bib")
  }
  if (grepl("citat", x, ignore.case = TRUE)) {
    return("citation")
  }
  if (grepl("desc", x, ignore.case = TRUE)) {
    return("description")
  }

  return("dontknow")
}

file_path_or_null <- function(x) {
  x_c <- clean_str(x)
  if (is.null(x_c)) {
    return(x)
  }
  if (file_exist_abort(x)) {
    return(x)
  }
  return(NULL)
}

#' Coerce and clean data from DESCRIPTION to create metadata
#' @noRd
clean_package_meta <- function(meta) {
  if (!inherits(meta, "packageDescription")) {
    # Add encoding
    meta <- list()
    meta$Encoding <- "UTF-8"
    return(meta)
  }

  # Convert to a desc object

  # First write to a dcf file
  tmp <- tempfile("DESCRIPTION")
  meta_unl <- unclass(meta)
  write.dcf(meta_unl, tmp)
  pkg <- desc::desc(tmp)
  pkg$coerce_authors_at_r()
  # Extract package data
  meta <- pkg$get(desc::cran_valid_fields)

  # Clean missing and drop empty fields
  meta <- drop_null(lapply(meta, clean_str))

  # Check encoding
  if (!is.null(meta$Encoding)) {
    meta <- lapply(meta, iconv, from = meta$Encoding, to = "UTF-8")
  } else {
    meta$Encoding <- "UTF-8"
  }
  unlink(tmp, force = TRUE)
  meta
}



# Convert a DESCRIPTION object to meta object using desc package
desc_to_meta <- function(x) {
  src <- x
  my_meta <- desc::desc(src)
  my_meta$coerce_authors_at_r()


  # As list
  my_meta_l <- my_meta$get(desc::cran_valid_fields)
  my_meta_l <- as.list(my_meta_l)
  v_nas <- vapply(my_meta_l, is.na, logical(1))
  my_meta_l <- my_meta_l[!v_nas]

  meta_proto <- packageDescription("cffr")

  class(my_meta_l) <- class(meta_proto)
  attr(my_meta_l, "file") <- x

  my_meta_l
}
