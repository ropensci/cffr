#' Encode UTF-8 text to LaTeX
#'
#' @description
#' Transform a UTF-8 string into LaTeX special characters.
#'
#' @param x A string, possibly encoded in UTF-8.
#'
#' @return A string with the corresponding transformations.
#'
#' @details
#' This is a variation of [tools::encoded_text_to_latex()] with some
#' additional replacements for better compatibility.
#'
#' @seealso [tools::encoded_text_to_latex()]
#'
#' @family bibtex
#' @keywords internal
#' @importFrom tools encoded_text_to_latex
#' @export
#' @encoding UTF-8
#' @examples
#' # Full range of supported characters in R.
#' library(tools)
#'
#' range <- 1:511
#'
#' ascii_table <- data.frame(
#'   dec = range,
#'   utf8 = intToUtf8(range, multiple = TRUE)
#' )
#'
#' # Add LaTeX using the base approach.
#' ascii_table$latex_base <- encoded_text_to_latex(ascii_table$utf8,
#'   encoding = "UTF-8"
#' )
#'
#' # With cffr.
#' ascii_table$latex_cffr <- encoded_utf_to_latex(ascii_table$utf8)
#'
#' ascii_table
encoded_utf_to_latex <- function(x) {
  encoded <- enc2utf8(x)
  out <- encoded_text_to_latex(encoded, encoding = "UTF-8")
  out <- gsub("(?<=\\\\)a ", " ", out, perl = TRUE, ignore.case = FALSE)
  out <- gsub(
    "(?<=\\\\)a(?=[[:punct:]])",
    "",
    out,
    perl = TRUE,
    ignore.case = FALSE
  )
  out <- gsub("(?<=\\\\)k ", " ", out, perl = TRUE, ignore.case = FALSE)
  out
}
