protect_bib_braces <- function(x) {
  paste0("{", x, "}")
}

# Utils for as_bibentry() ----
get_bib_howpublised <- function(x) {
  howpublished <- x$medium

  if (!is.null(howpublished)) {
    f <- toupper(substr(howpublished, 0, 1))
    rest <- substr(howpublished, 2, nchar(howpublished))
    howpublished <- paste0(c(f, rest), collapse = "")
  }

  clean_str(howpublished)
}

get_bib_note <- function(x) {
  note <- x$notes

  # Unpublished entries need a note.
  if (all(is.null(note), tolower(x$type) == "unpublished")) {
    note <- "Extracted with cffr R package"
  }

  clean_str(note)
}

guess_bibtype <- function(x) {
  init_guess <- switch(tolower(x$type),
    "article" = "article",
    "book" = "book",
    "manual" = "manual",
    "unpublished" = "unpublished",
    "conference" = "inproceedings",
    "conference-paper" = "inproceedings",
    "proceedings" = "proceedings",
    "magazine-article" = "article",
    "newspaper-article" = "article",
    "pamphlet" = "booklet",
    "report" = "techreport",
    "thesis" = "mastersthesis",
    # Guess when no direct mapping is available.
    "misc"
  )

  # Try to guess inbook ----
  # inbook is a book where chapter or pages are present.
  has_chapter <- !is.null(clean_str(x$section))
  has_pages <- !is.null(clean_str(paste(
    unique(c(x$start, x$end)),
    collapse = "--"
  )))

  if (all(init_guess == "book", any(has_chapter, has_pages))) {
    init_guess <- "inbook"
    return(init_guess)
  }

  # Try to guess phdthesis ----
  if (init_guess == "mastersthesis") {
    ttype <- clean_str(gsub("[[:punct:]]", "", x$`thesis-type`, perl = TRUE))
    # PhD.
    if (all(!is.null(ttype), grepl("phd", ttype, ignore.case = TRUE))) {
      return("phdthesis")
    }
  }

  # Try to guess incollection ----
  # Hint: it is misc with collection-title and publisher.
  if (init_guess == "misc") {
    if (!is.null(clean_str(x$`collection-title`))) {
      return("incollection")
    }
  }

  init_guess
}

get_bib_address <- function(x) {
  # BibTeX 'address' is taken from the publisher (book, others) or the
  # conference (inproceedings).
  # Precedence is conference, institution, then publisher.
  if (!is.null(x$conference)) {
    addr_search <- x$conference
  } else if (!is.null(x$institution)) {
    addr_search <- x$institution
  } else {
    addr_search <- x$publisher
  }

  address <- clean_str(paste(
    c(
      addr_search$address,
      addr_search$city,
      addr_search$region,
      addr_search$country
    ),
    collapse = ", "
  ))

  # As a fallback, also use location.
  if (is.null(address) && !is.null(x$location)) {
    address <- clean_str(x$location$name)
  }

  address
}

get_bib_booktitle <- function(x, bibtype) {
  # Map collection title.
  # If inproceedings or incollection, map it to booktitle.
  # In the remaining cases, map it to series.

  book_series <- list()
  tag_value <- clean_str(x[["collection-title"]])

  if (!bibtype %in% c("incollection", "inproceedings")) {
    book_series$series <- tag_value
  } else {
    # Map booktitle only for incollection and inproceedings.
    book_series$booktitle <- tag_value

    # Fallback to the conference name for inproceedings.
    if (all(bibtype == "inproceedings", is.null(tag_value))) {
      book_series$booktitle <- clean_str(x$conference$name)
    }
  }
  book_series
}

get_bib_inst_org <- function(x, bibtype) {
  # For inproceedings, proceedings and manual, this field is organization.
  # For thesis, it should be school.

  inst_org <- list()
  # Use the name only.
  inst_name <- clean_str(x$institution$name)

  if (bibtype %in% c("inproceedings", "proceedings", "manual")) {
    inst_org$organization <- inst_name
  } else if (grepl("thesis", bibtype, ignore.case = TRUE)) {
    inst_org$school <- inst_name
  } else {
    inst_org$institution <- inst_name
  }

  # Fallback for techreport: search the first author affiliation.

  if (bibtype == "techreport" && is.null(inst_org$institution)) {
    inst_org$institution <- clean_str(x$authors[[1]]$affiliation)
  }

  inst_org
}

make_bibkey <- function(tobibentry) {
  # Be kind and provide a bibentry key.

  y <- tobibentry$year

  # Initialize `etall`.
  etall <- NULL

  # Some entries do not have authors but do have editors.
  # Others may have none, such as misc or pamphlet.

  init_aut <- tobibentry$author

  # Try to get the editor if the author is null.
  if (is.null(init_aut)) {
    init_aut <- tobibentry$editor
  }

  # If none, get a key based on title.
  if (any(is.null(init_aut), length(init_aut) == 0)) {
    r <- tolower(tobibentry$title)
    # Reduce length to 15 characters maximum.
    r <- substr(r, 0, 15)
  } else {
    # Use the first name or surname and et_all if there are additional authors.
    # Bear in mind that institutions have only given names.

    nauths <- length(init_aut)
    if (nauths > 1) {
      etall <- "_etall"
    }

    # Get information from the first author.
    unz <- unlist(init_aut[1])
    if ("family" %in% names(unz)) {
      r <- unz["family"]
    } else {
      r <- unz["given"]
    }

    r <- tolower(paste0(r, collapse = ""))
  }

  # Try hard to remove accents.
  # First use iconv.
  r <- iconv(r, from = "UTF-8", to = "ASCII//TRANSLIT", sub = "?")

  # Then convert to LaTeX.
  r <- encoded_utf_to_latex(r)

  # Finally, keep only a-z letters for the key.
  r <- gsub("[^_a-z]", "", r)

  # Append etall and year.
  key <- paste0(c(r, etall), collapse = "")
  key <- paste(c(key, y), collapse = ":")
  key
}

get_bib_month <- function(x) {
  m <- x$month

  # Fallback.

  if (is.null(m) && !is.null(x$`date-published`)) {
    # Should be YYYY-MM-DD to be valid in CFF.
    m <- as.integer(format(as.Date(x$`date-published`), "%m"))
  }

  # Try to get a three-letter month string.
  m_int <- suppressWarnings(as.integer(m))
  m_letters <- clean_str(tolower(month.abb[m_int]))

  if (!is.null(m_letters)) {
    month <- m_letters
  } else {
    month <- clean_str(m)
  }

  month
}

get_bib_year <- function(x) {
  year <- x$year

  # Fallback.

  if (is.null(year) && !is.null(x$`date-released`)) {
    # Should be YYYY-MM-DD to be valid in CFF.
    year <- substr(x$`date-released`, 1, 4)
  }

  clean_str(year)
}
