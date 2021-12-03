#' BibTeX utils
#'
#' Functions for reading and creating `.bib` files.
#'
#' @name bibtex
#'
#' @return
#' [cff_read_bib()] returns a `citation, bibentry` object as produced by
#' [citation()]
#'
#' @family bibtex
#'
#' @param file The path to a `.bib` file.
#'
#' @seealso [citation()], [bibentry()], [knitr::write_bib()].
#'
#' @details
#'
#' These are simple I/O functions for working with BibTeX files. Other options
#' are:
#'
#' - [bibtex](https://github.com/ropensci/bibtex) package.
#' - [RefManageR](https://github.com/ropensci/RefManageR) package.
#' - [knitr::write_bib()].
#'
#' @export
#'
#' @note
#'
#' **R** does not support **Conference** BibTex entries. However, this entry is
#' equivalent to **InProceedings** according to Patashnik (1988).
#'
#' See [bibentry()] for more info.
#'
#' @references
#' Patashnik, O. (1988, February). *BIBTEXTING*. BibTeX - Process
#' Bibliographies for LATEX, Etc. Retrieved December 1, 2021, from
#' <https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.
#'
#' @examples
#' # Reading .bib files
#'
#' file <- system.file("examples/bibtex_example.bib",
#'   package = "cffr"
#' )
#' parsed <- cff_read_bib(file)
#'
#'
#' print(parsed, bibtex = TRUE)
#'
#' # Compare with the file
#' cat(readLines(file), sep = "\n")
#'
#' # To cffr citation
#'
#' cff_parse_citation(parsed)
cff_read_bib <- function(file) {

  # Read all as UTF-8
  lines <- trimws(readLines(file, encoding = "UTF-8"))

  # Detect blocks
  ls <- substr(lines, 1, 1)
  init <- grep("@", ls)
  end <- which(ls == "}")

  # Validate
  if (length(init) != length(end)) {
    stop("Invalid .bib file. Not matching brackets of citation")
  }

  # Parse individually
  final <- lapply(seq_len(length(init)), function(x) {
    single_bibtex2r(init[x], end[x], lines)
  })

  final <- do.call("c", final)

  # Add citation class
  class(final) <- unique(c("citation", class(final)))
  final
}



#' Read a single BibTeX entry
#' @noRd
single_bibtex2r <- function(init, end, lines) {
  # Split section
  sect <- lines[seq(init, end - 1)]

  headd <- gsub(",", "", sect[1])

  # Guess type and key
  headd2 <- trimws(unlist(strsplit(headd, "\\{")))
  headd2 <- gsub("@", "", headd2)


  # Parse rest of fields
  rest <- sect[-1]
  rest <- strsplit(rest, "=")

  # Split fields
  names <- trimws(unlist(sapply(rest, "[[", 1)))
  values <- trimws(unlist(sapply(rest, "[[", 2)))

  # Clean values
  values <- gsub(",$", "", values)
  # Keep intermediate brackets
  values <- gsub("^\\{|\\}$", "", values)

  params <- as.list(values)
  names(params) <- names

  # Handle authors
  if (!is.null(params$author)) {
    aut <- trimws(unlist(strsplit(params$author, " and ")))
    aut_end <- lapply(aut, function(x) {

      # See if I have to keep the name as is (brackets)
      splits <- strsplit(x, "")[[1]]
      firstchar <- splits[1]
      lastchar <- rev(splits)[1]
      if (firstchar == "{" && lastchar == "}") {
        return(person(given = gsub("^\\{|\\}$", "", x)))
      }

      y <- trimws(unlist(strsplit(x, ",")))

      if (length(y) < 2) {
        # Mode <Name Surname>: We not parse as person
        # It could be a single
        return(as.person(y))
      }

      # Mode <Surname, Name>
      person(given = y[2], family = y[1])
    })
    params$author <- do.call("c", aut_end)
  }

  # Handle editor
  if (!is.null(params$editor)) {
    # As entity
    newedit <- paste(trimws(params$editor), collapse = " ")
    params$editor <- person(newedit)
  }

  # Add key and bibtype
  params$bibtype <- tools::toTitleCase(headd2[1])

  # Switch conference to InProceedings
  if (tolower(params$bibtype) == "conference") {
    params$bibtype <- "InProceedings"
  }

  params$key <- headd2[2]

  # Try to parse with bibentry function
  citend <- try(do.call("bibentry", params), silent = TRUE)

  # On error switch to Misc with a warning
  if (inherits(citend, "try-error")) {
    warning(
      "\nOn Citation @",
      headd2[2],
      ":\n",
      as.character(citend),
      "\nParsing as Misc\n----",
      call. =  FALSE
    )

    params$bibtype <- "Misc"
    citend <- do.call("bibentry", params)
  }

  return(citend)
}


#' Encode UTF-8 text to LaTeX
#'
#' @description
#' Transform a UTF-8 string to LaTeX special characters.
#'
#' @return A string with the corresponding transformations.
#'
#' @param x A string, possibly encoded in UTF-8 encoding system.
#'
#' @family bibtex
#'
#' @seealso [tools::encoded_text_to_latex()]
#'
#' @importFrom tools encoded_text_to_latex
#'
#' @details
#'
#' This is a variation of [tools::encoded_text_to_latex()] performing some
#' additional replacements to increase compatibility.
#'
#' @keywords internal
#' @export
#'
#' @examples
#' \dontrun{
#' # Full range of supported characters on R
#' library(tools)
#'
#' range <- 1:511
#'
#' ascii_table <- data.frame(
#'   dec = range,
#'   utf8 = intToUtf8(range, multiple = TRUE)
#' )
#'
#' # Add latex using base approach
#' ascii_table$latex_base <- encoded_text_to_latex(ascii_table$utf8,
#'   encoding = "UTF-8"
#' )
#'
#' # With cffr
#' ascii_table$latex_cffr <- encoded_utf_to_latex(ascii_table$utf8)
#'
#' ascii_table
#' }
encoded_utf_to_latex <- function(x) {
  encoded <- enc2utf8(x)
  out <- encoded_text_to_latex(encoded, encoding = "UTF-8")
  out <- gsub("(?<=\\\\)a ", " ", out, perl = TRUE, ignore.case = FALSE)
  out <- gsub("(?<=\\\\)a(?=[[:punct:]])", "", out,
    perl = TRUE,
    ignore.case = FALSE
  )
  out <- gsub("(?<=\\\\)k ", " ", out, perl = TRUE, ignore.case = FALSE)
  out
}
