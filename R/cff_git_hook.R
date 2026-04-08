#' Use a git pre-commit hook `r lifecycle::badge("experimental")`
#'
#' @description
#'
#' Install a
#'
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0(" [pre-commit hook]",
#'            "(https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks",
#'            "#_committing_workflow_hooks)"))
#'
#' ```
#' that reminds you to update your `CITATION.cff` file. This is a wrapper around
#' [usethis::use_git_hook()].
#'
#' @name cff_git_hook
#'
#' @family git
#'
#' @export
#' @encoding UTF-8
#'
#' @return Invisible. This function is called for its side effects.
#'
#' @seealso
#'
#' - [usethis::use_git_hook()], which is the underlying function used by
#'   `cff_git_hook_install()`.
#'
#' - [usethis::use_git()] and related function of \CRANpkg{usethis} for using
#'   Git with **R** packages.
#'
#' @details
#'
#' This function installs a pre-commit hook using
#' [usethis::use_git_hook()].
#'
#' A pre-commit hook is a script that identifies simple issues before
#' submission to code review. This pre-commit hook warns you if any of the
#' following conditions are met:
#' - You included your `DESCRIPTION` or `inst/CITATION` file in a commit but
#'   did not include your `CITATION.cff`, and the `CITATION.cff` file is
#'   "older" than your `DESCRIPTION` or `inst/CITATION` file.
#' - You updated your `CITATION.cff` but did not include it in
#'   your commit.
#'
#' # A word of caution
#'
#' The pre-commit hook may prevent you from committing if you are not updating
#' your `CITATION.cff`. However, the detection mechanism is not perfect and may
#' be triggered even if you have attempted to update your `CITATION.cff` file.
#'
#' This typically occurs when you have updated your `DESCRIPTION` or
#' `inst/CITATION` files, but those changes do not affect your
#' `CITATION.cff` file (for example, you are adding new dependencies).
#'
#' In those cases, you can override the check by running
#' `git commit --no-verify` in the terminal.
#'
#' If you are using **RStudio**, you can also run this command from an **R**
#' script by selecting that line and sending it to the terminal using:
#'
#' - Windows & Linux: `Ctrl+Alt+Enter`.
#' - Mac: `Cmd+Option+Return`.
#'
#' # Removing the git pre-commit hook
#'
#' You can remove the pre-commit hook using `cff_git_hook_remove()`.
#'
#' @examples
#' \dontrun{
#' cff_git_hook_install()
#' }
#'
cff_git_hook_install <- function() {
  # nocov start
  bash_file <- system.file("bash/citation-cff-pre-commit.sh", package = "cffr")

  if (requireNamespace("usethis", quietly = TRUE)) {
    usethis::use_git_hook("pre-commit", readLines(con = bash_file))
  } else {
    cli::cli_alert_danger(
      paste0(
        "Please install {.pkg usethis} to use the pre-commit hook: ",
        '{.run install.packages("usethis")}'
      )
    )
  }
  invisible()
  # nocov end
}

#' @rdname cff_git_hook
#' @export
#' @encoding UTF-8
cff_git_hook_remove <- function() {
  # nocov start
  hookfile <- file.path(".git", "hooks", "pre-commit")

  if (file_exist_abort(hookfile)) {
    cli::cli_alert_info(
      "Removing git pre-commit hook (was on {.path {hookfile}})"
    )
    unlink(hookfile, force = TRUE)
  }

  invisible()
  # nocov end
}
