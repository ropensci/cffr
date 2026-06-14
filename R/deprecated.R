#' Previous API: Create BibTeX entries from several sources
#'
#' @description
#' `r lifecycle::badge('deprecated')` Please use [as_bibentry()] instead.
#'
#' @inheritParams as_bibentry
#'
#' @return See [as_bibentry()].
#'
#' @family deprecated
#' @rdname deprecated_cff_to_bib
#' @keywords internal
#' @export
#' @encoding UTF-8
#' @examples
#' \donttest{
#' # From a `cff` object.
#' cff_object <- cff()
#'
#' cff_object
#'
#' # A bibentry object.
#' bib <- as_bibentry(cff_object)
#' }
cff_extract_to_bibtex <- function(
  x,
  what = c("preferred", "references", "all")
) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn(
      "0.5.0",
      "cff_extract_to_bibtex()",
      details = "Function renamed, use `as_bibentry()` instead."
    )
  }
  as_bibentry(x, what)
}

#' @rdname deprecated_cff_to_bib
#' @keywords internal
#' @export
#' @encoding UTF-8
cff_to_bibtex <- function(x, what = c("preferred", "references", "all")) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn(
      "1.0.0",
      "cff_extract_to_bibtex()",
      details = "Function renamed, use `as_bibentry()` instead."
    )
  }
  as_bibentry(x, what)
}

#' Previous API: Create a [`cff`] object from BibTeX entries
#'
#' @description
#' `r lifecycle::badge('deprecated')` Please use either [cff_read_bib()] or
#' [cff_read_bib_text()] instead.
#'
#' @param x The source used to generate the
#'   [`cff`] object. Must be a `character` object indicating either:
#'   - The path to a BibTeX file.
#'   - A vector of characters with a complete BibTeX string. See **Examples**.
#' @inheritParams cff_read_bib_text
#'
#' @return
#' See [cff_read_bib()] for reading `*.bib` files and [cff_read_bib_text()]
#' for reading a `character` object representing a BibTeX entry.
#'
#' @family deprecated
#' @rdname deprecated_cff_from_bib
#' @keywords internal
#' @export
#' @encoding UTF-8
#' @examples
#' if (requireNamespace("bibtex", quietly = TRUE)) {
#'   x <- c(
#'     "@book{einstein1921,
#'     title        = {Relativity: The Special and the General Theory},
#'     author       = {Einstein, Albert},
#'     year         = 1920,
#'     publisher    = {Henry Holt and Company},
#'     address      = {London, United Kingdom},
#'     isbn         = 9781587340925
#' }",
#'     "@misc{misc-full,
#'     title        = {Handing out random pamphlets in airports},
#'     author       = {Joe-Bob Missilany},
#'     year         = 1984,
#'     month        = oct,
#'     note         = {This is a full MISC entry},
#'     howpublished = {Handed out at O'Hare}
#' }"
#'   )
#'
#'   cff_read_bib_text(x)
#'
#'   # From a file.
#'
#'   x2 <- system.file("examples/example.bib", package = "cffr")
#'   cff_read_bib(x2)
#' }
cff_from_bibtex <- function(x, encoding = "UTF-8", ...) {
  if (length(x) == 1 && file_exist_abort(x)) {
    if (requireNamespace("lifecycle", quietly = TRUE)) {
      lifecycle::deprecate_warn("1.0.0", "cff_from_bibtex()", "cff_read_bib()")
    }

    # Read the BibTeX file.
    return(cff_read_bib(x, encoding = encoding, ...))
  }

  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn(
      "1.0.0",
      "cff_from_bibtex()",
      "cff_read_bib_text()"
    )
  }
  cff_read_bib_text(x, encoding = encoding, ...)
}

#' Previous API: Write files
#'
#' @description
#' `r lifecycle::badge('deprecated')` Please use [cff_write_bib()] or
#' [cff_write_citation()] instead.
#'
#' @inheritParams cff_write_bib
#'
#' @return Writes a file.
#'
#' @seealso
#' - [cff_write_bib()] for writing `*.bib` files.
#' - [cff_write_citation()] for writing \R `CITATION` files.
#'
#' @family deprecated
#' @rdname deprecated_write
#' @keywords internal
#' @export
#' @encoding UTF-8
#' @examples
#' bib <- bibentry("Misc",
#'   title = "My title",
#'   author = "Fran Pérez"
#' )
#'
#' my_temp_bib <- tempfile(fileext = ".bib")
#'
#' cff_write_bib(bib, file = my_temp_bib)
#'
#' cat(readLines(my_temp_bib), sep = "\n")
#'
#' cff_write_bib(bib, file = my_temp_bib, ascii = TRUE, append = TRUE)
#'
#' cat(readLines(my_temp_bib), sep = "\n")
write_bib <- function(
  x,
  file = tempfile(),
  append = FALSE,
  verbose = TRUE,
  ascii = FALSE
) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn("1.0.0", "write_bib()", "cff_write_bib()")
  }

  cff_write_bib(x, file, append, verbose, ascii)
}

#' @rdname deprecated_write
#' @export
#' @encoding UTF-8
write_citation <- function(
  x,
  file = "./inst/CITATION",
  append = FALSE,
  verbose = TRUE,
  ...
) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn(
      "1.0.0",
      "write_citation()",
      "cff_write_citation()"
    )
  }
  cff_write_citation(x, file, append, verbose, ...)
}

#' Previous API: Parse a `person` to [`cff`]
#'
#' @description
#' `r lifecycle::badge('deprecated')` Please use [as_cff_person()] instead.
#'
#' @param person It can be either:
#'   - A `person` or list of `person` object created with [utils::person()].
#'   - A `character` object or vector representing a person or persons.
#'
#' @return A person in format `cff`.
#'
#' @seealso [as_cff_person()]
#'
#' @family deprecated
#' @rdname deprecated_cff_person
#' @keywords internal
#' @export
#' @encoding UTF-8
#' @examples
#' # Create a person object.
#' a_person <- person(
#'   given = "First", family = "Author",
#'   role = c("aut", "cre"),
#'   email = "first.last@example.com", comment = c(
#'     ORCID = "0000-0001-8457-4658",
#'     affiliation = "An affiliation"
#'   )
#' )
#'
#' a_person
#'
#' cff_person <- as_cff_person(a_person)
#'
#' cff_person
#'
#' # Back to person object with S3 method.
#' as.person(cff_person)
#'
#' # Parse a string.
#' a_str <- paste0(
#'   "Julio Iglesias <fake@email.com> ",
#'   "(<https://orcid.org/0000-0001-8457-4658>)"
#' )
#' as_cff_person(a_str)
#'
#' # Several persons.
#' persons <- c(person("Clark", "Kent"), person("Lois", "Lane"))
#'
#' as_cff_person(persons)
#'
#' # Or use BibTeX style.
#'
#' x <- "Frank Sinatra and Dean Martin and Davis, Jr., Sammy and Joey Bishop"
#'
#' as_cff_person(x)
#'
#' as_cff_person("Herbert von Karajan")
cff_parse_person <- function(person) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn("1.0.0", "cff_parse_person()", "as_cff_person()")
  }
  as_cff_person(person)
}

#' @rdname deprecated_cff_person
#' @export
#' @encoding UTF-8
#'
cff_parse_person_bibtex <- function(person) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn(
      "1.0.0",
      "cff_parse_person_bibtex()",
      "as_cff_person()"
    )
  }
  as_cff_person(person)
}

#' Previous API: Parse a `bibentry` to `cff`
#'
#' @description
#' `r lifecycle::badge('deprecated')` Please use the [as_cff.bibentry()]
#' method instead.
#'
#' @param bib A `bibentry` object.
#' @return A `bibentry` in format [`cff`].
#'
#' @seealso [as_cff.bibentry()]
#'
#' @family deprecated
#' @rdname deprecated_cff_bibentry
#' @keywords internal
#' @export
#' @encoding UTF-8
#' @examples
#' bib <- citation("base")
#' bib
#'
#' # To cff.
#' bib_to_cff <- as_cff(bib)
#' bib_to_cff
#'
cff_parse_citation <- function(bib) {
  if (requireNamespace("lifecycle", quietly = TRUE)) {
    lifecycle::deprecate_warn(
      "1.0.0",
      "cff_parse_citation()",
      "as_cff.bibentry()"
    )
  }
  as_cff(bib)
}
