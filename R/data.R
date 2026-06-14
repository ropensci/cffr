#' Mapping between `License` fields and SPDX
#'
#' A dataset containing the mapping between the `License` strings observed
#' on CRAN packages and their approximate match on the
#' [SPDX License List](https://spdx.org/licenses/).
#'
#' @format
#' A data frame with `r nrow(cran_to_spdx)` rows and 2 variables:
#' \describe{
#'   \item{`LICENSE`}{A valid `License` string on CRAN.}
#'   \item{`SPDX`}{A valid SPDX License Identifier.}
#' }
#'
#' @source <https://spdx.org/licenses/>
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
#' @family datasets
#' @rdname cran_to_spdx
#' @name cran_to_spdx
#' @docType data
#' @encoding UTF-8
#' @examples
#' data("cran_to_spdx")
#'
#' head(cran_to_spdx, 20)
NULL
