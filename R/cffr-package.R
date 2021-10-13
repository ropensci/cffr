#' @docType package
#' @name cffr-package
#' @aliases cffr
#' @keywords internal
#'
#' @title cffr: Generate Citation File Format ('cff') Metadata for R Packages
#'
#' @description
#' \if{html}{\figure{logo.png}{options: align='right' alt='logo' width='120'}}
#'
#' The Citation File Format version 1.2.0 (Druskat, S. et al. (2021)
#' [<doi:10.5281/zenodo.5171937>](https://doi.org/10.5281/zenodo.5171937) is
#' a human and machine readable file format which provides citation metadata
#' for software. This package provides core utilities to generate and validate
#' this metadata.
#'
#' @author
#' ```{r, echo=FALSE, results='asis'}
#'
#' pak <- cffr::cff_create("cffr")
#' maint <- pak$contact[[1]]
#'
#' cat(
#'   "**Maintainer**:",
#'   maint$`given-names`,
#'   maint$`family-names`,
#'   paste0("([ORCID](", maint$orcid, "))")
#' )
#'
#' ```
#'
#' Other contributors:
#'
#' ```{r, echo=FALSE, results='asis'}
#'
#' all <- desc::desc()
#'
#' auths <- all$get_authors()
#'
#' nocre <- unlist(lapply(auths, function(x) {
#'   !"cre" %in% x$role
#' }))
#'
#' nocre_ext <- auths[nocre]
#'
#' cat(unlist(lapply(nocre_ext, function(x) {
#'   rol <- x$role[1]
#'   rolparsed <- roxygen2:::role_lookup[rol]
#'
#'   paste(
#'     "  * ", x$given, x$family,
#'     paste0("\\[", rolparsed, "\\]"),
#'     "\n"
#'   )
#' })))
#'
#' ```
#' @seealso
#'
#' Useful links:
#'
#' ```{r, echo=FALSE, results='asis'}
#'
#' pak <- packageDescription("cffr")
#' urls <- pak[["URL"]]
#' urlsplit <- unlist(strsplit(urls, ",\\n"))
#' cat("\n")
#' cat(paste0("  * <", urlsplit, ">", collapse = "\n"))
#' cat("\n")
#' cat(paste0("  * Report bugs at <", pak[["BugReports"]], ">"))
#' ```




# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

# import stuffs
#' @importFrom utils download.file as.person read.csv person
#' installed.packages  packageDescription citation available.packages
#' modifyList
NULL
