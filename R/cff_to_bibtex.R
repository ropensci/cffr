

cff_to_bibtex <- function(x) {
  stopifnotcff(x)

  # Read cff of CITATION.cff file
  if (!is.cff(x)) x <- cff(x)

  # Extract preferred-citation
  cit <- x[["preferred-citation"]]

  # If not available create auto
  if (is.null(cit)) cit <- parse_preferred_auto(x)

  # Parse authors, etc. to person() ----
  person_type <- sort(unique(c(
    "authors", other_persons(),
    other_persons_entity()
  )))

  person_to_deparse <- cit[names(cit) %in% person_type]
  person_deparsed <- lapply(person_to_deparse, cff_authors_to_person)


  # Start creating object ----
  old_names <- names(cit)
  old_names <- old_names[old_names != "type"]
  type <- tolower(cit$type)

  new_cit <- c(cit[!names(cit) %in% person_type], person_deparsed)

  # Reorder
  new_cit <- new_cit[old_names]

  # Pase month

  new_cit$month <- bibtex_month(new_cit$month)

  # Rename fields ----
  nm <- names(new_cit)

  # rename authors
  nm[nm == "authors"] <- "author"

  # rename editor
  nm[nm == "editors"] <- "editor"

  # rename chapter
  nm[nm == "section"] <- "chapter"

  # rename school
  nm[nm == "institution"] <- "school"

  # Handle booktitle

  if ("collection-title" %in% nm) {
    nm[nm == "title"] <- "booktitle"
    nm[nm == "collection-title"] <- "title"
  }

  names(new_cit) <- nm

  # Handle type ----
  new_type <- switch(type,
    "art" = "Article",
    "article" = "Article",
    "newspaper-article" = "Article",
    "book" = "Book",
    "manual" = "Manual",
    "thesis" = "MasterThesis",
    "proceedings" = "Proceedings",
    "report" = "TechReport",
    "unpublished" = "Unpublished",
    "Misc"
  )


  # Concatenate
  new_cit <- c(
    list(
      bibtype = new_type
    ),
    new_cit
  )



  # Add final key
  finalkey <- bibtex_keytext(new_cit)
  new_cit <- c(new_cit, list(key = finalkey))

  bibent <- do.call("bibentry", new_cit)

  bibtex <- toBibtex(bibent)

  return(bibtex)
}


#' Auto create a key for a BibTex citation
#'
#' @noRd
bibtex_keytext <- function(new_cit) {

  # Create key text with surname of two authors maz
  key1 <- unlist(new_cit$author$family[1:2])

  # If it is an entity...
  if (is.null(key1)) key1 <- unlist(new_cit$author$given[1:2])

  key1 <- key1[!is.na(key1)]

  # Add title
  key2 <- unlist(strsplit(new_cit$title, " "))

  # Collapse
  key_noyear <- c(key1, key2)[1:3]


  # Keep 3 first words if exists
  key_noyear <- key_noyear[!is.na(key_noyear)]


  key_noyear <- tolower(paste0(key_noyear, collapse = "_"))

  # Add year
  key3 <- new_cit$year

  finalkey <- paste0(key_noyear, "_", key3)

  # Remove extra chars on finalkey
  # https://stackoverflow.com/questions/10294284/remove-all-special-characters-from-a-string-in-r

  finalkey <- gsub("[^_0-9A-Za-z///' ]", "'", finalkey, ignore.case = TRUE)
  finalkey <- gsub("'", "", finalkey, ignore.case = TRUE)

  return(finalkey)
}

bibtex_month <- function(m) {
  if (is.null(m) || is.na(m)) {
    return(NULL)
  }

  # Guess if a valid integer is provided and output
  mnt_num <- tryCatch(as.numeric(m),
    warning = function(e) {
      return(FALSE)
    }
  )

  if (isFALSE(mnt_num)) {
    return(NULL)
  }

  mnt_end <- tolower(month.abb[mnt_num])

  return(mnt_end)
}
