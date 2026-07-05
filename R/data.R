#' Mapping between `License` fields and SPDX
#'
#' A dataset containing the mapping between the `License` strings observed
#' in CRAN packages and their approximate match in the
#' [SPDX License List](https://spdx.org/licenses/).
#'
#' @format
#' A data frame with `r nrow(cran_to_spdx)` rows and two variables:
#' \describe{
#'   \item{`LICENSE`}{A valid `License` string on CRAN.}
#'   \item{`SPDX`}{A valid SPDX license identifier.}
#' }
#'
#' @source <https://spdx.org/licenses/>.
#'
#' @seealso *Writing R Extensions*,
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Licensing section]",
#'            "(https://cran.r-project.org/doc/manuals/",
#'            "r-release/R-exts.html#Licensing)."))
#'
#' ```
#'
#' @rdname cran_to_spdx
#' @name cran_to_spdx
#' @docType data
#' @keywords datasets
#' @encoding UTF-8
#' @examples
#' data("cran_to_spdx")
#'
#' head(cran_to_spdx, 20)
NULL
