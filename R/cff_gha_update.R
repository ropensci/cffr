#' Install a \CRANpkg{cffr} GitHub Actions workflow
#'
#' @description
#' This function installs a
#' [GitHub Actions](https://github.com/features/actions) workflow in your
#' repository. The workflow
#' updates your `CITATION.cff` when any of these events occur:
#' - You publish a new release of the package.
#' - Your `DESCRIPTION` or `inst/CITATION` file is modified.
#' - The action can be run manually.
#'
#' @param path Project root directory.
#' @param overwrite A logical value. If `TRUE`, overwrite an existing workflow.
#'
#' @inherit cff_git_hook return
#'
#' @details
#' Triggers on your action can be modified. See
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [Events that trigger workflows]",
#'            "(https://docs.github.com/en/actions/learn-github-actions/",
#'            "events-that-trigger-workflows)."))
#'
#' ```
#'
#' @family git
#' @export
#' @encoding UTF-8
#' @examples
#' \dontrun{
#' cff_gha_update()
#' }
cff_gha_update <- function(path = ".", overwrite = FALSE) {
  destdir <- file.path(path, ".github", "workflows")
  checkdir <- dir.exists(destdir)

  if (isFALSE(checkdir)) {
    cli::cli_alert_info("Creating directory {.path {destdir}}.")
    dir.create(destdir, recursive = TRUE, showWarnings = FALSE)
  }

  newfile <- file.path(destdir, "update-citation-cff.yaml")

  if (!file_exist_abort(newfile) || isTRUE(overwrite)) {
    cli::cli_alert_success("Workflow installed at {.file {newfile}}.")

    file.copy(
      system.file("yaml/update-citation-cff.yaml", package = "cffr"),
      newfile,
      overwrite = TRUE
    )
  } else {
    cli::cli_alert_warning(paste0(
      "Workflow file {.file {newfile}} already exists. ",
      "Set {.arg overwrite} to {.val TRUE} to overwrite it."
    ))
  }

  rbuildignore <- file.path(path, ".Rbuildignore")

  if (file_exist_abort(rbuildignore)) {
    ignore <- readLines(rbuildignore)

    # If not already present.
    if (!("^\\.github$" %in% ignore)) {
      ignore <- c(ignore, "^\\.github$")
      ignore <- unique(ignore)
      cli::cli_alert_info("Adding {.path .github} to {.file .Rbuildignore}.")
      writeLines(ignore, rbuildignore)
    }
  }

  invisible()
}
