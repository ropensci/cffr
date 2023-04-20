#' Install a cffr GitHub Action
#'
#' @description
#'
#' This function would install a GitHub Action on your repo. The action
#' will update your `CITATION.cff` when any of these events occur:
#' - You publish a new release of the package.
#' - Your DESCRIPTION or inst/CITATION are modified.
#' - The action can be run also manually.
#'
#' @param path Project directory
#' @param overwrite If already present, do you want to overwrite your action?
#'
#' @return Invisible, this function is called by its side effects.
#'
#' @details
#'
#' Triggers on your action can be modified, see
#' [Events that trigger workflows](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows).
#'
#' @examples
#' \dontrun{
#' cff_gha_update()
#' }
#' @export
#'
#' @family git
cff_gha_update <- function(path = ".",
                           overwrite = FALSE) {
  destdir <- file.path(path, ".github", "workflows")
  checkdir <- dir.exists(destdir)

  if (isFALSE(checkdir)) {
    cli::cli_alert_info(paste0("Creating directory ", cli::col_blue(destdir)))
    dir.create(destdir, recursive = TRUE, showWarnings = FALSE)
  }

  newfile <- file.path(destdir, "update-citation-cff.yaml")

  if (!file.exists(newfile) || isTRUE(overwrite)) {
    cli::cli_alert_success(paste0(
      "Installing ",
      cli::col_blue("update-citation-cff.yaml")
    ))
    file.copy(system.file("yaml/update-citation-cff.yaml", package = "cffr"),
      newfile,
      overwrite = TRUE
    )
  } else {
    cli::cli_alert_warning(
      paste0(
        "File ", cli::col_blue("update-citation-cff.yaml"),
        " already installed. Use ", cli::col_blue("<overwrite = TRUE>"),
        " for overwrite"
      )
    )
  }

  if (file.exists(file.path(path, ".Rbuildignore"))) {
    ignore <- readLines(file.path(path, ".Rbuildignore"))

    # If not already
    if (!("^\\.github$" %in% ignore)) {
      ignore <- c(ignore, "^\\.github$")
      ignore <- unique(ignore)
      cli::cli_alert_info(
        paste0(
          "Adding ", cli::col_blue("'.github'"), " to ",
          cli::col_blue(".Rbuildignore")
        )
      )

      writeLines(ignore, ".Rbuildignore")
    }
  }

  return(invisible())
}
