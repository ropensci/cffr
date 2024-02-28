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
