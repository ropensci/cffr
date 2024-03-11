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
#'            "#_committing_workflow_hooks) "))
#'
#' ```
#' that remembers you to update your `CITATION.cff` file. This is a wrapper of
#' [usethis::use_git_hook()].
#'
#' @name cff_git_hook
#'
#' @family git
#'
#' @export
#'
#' @return Invisible. This function is called for its side effects.
#'
#' @seealso
#'
#' - [usethis::use_git_hook()], that is the underlying function used by
#'   `cff_git_hook_install()`.
#'
#' - [usethis::use_git()] and related function of \CRANpkg{usethis} for using
#'   Git with **R** packages.
#'
#' @details
#'
#' This function would install a pre-commit hook using
#' [usethis::use_git_hook()].
#'
#' A pre-commit hook is a script that identifies  simple issues before
#' submission to code review. This pre-commit hook would warn you if any of the
#' following conditions are met:
#' - You included in a commit your `DESCRIPTION` or `inst/CITATION` file, you
#'   are not including your `CITATION.cff` and the `CITATION.cff` file is
#'   "older" than any of your `DESCRIPTION` or `inst/CITATION` file.
#' - You have updated your `CITATION.cff` but you are not including it on
#'   your commit.
#'
#' # A word of caution
#'
#' The pre-commit hook may prevent you to commit if you are not updating your
#' `CITATION.cff`. However, the mechanism of detection is not perfect and would
#' be triggered also even if you have tried to update your `CITATION.cff` file.
#'
#' This is typically the case when you have updated your `DESCRIPTION` or
#' `inst/CITATION` files but those changes doesn't make a change on your
#' `CITATION.cff` file (i.e. you are including new dependencies).
#'
#' In those cases, you can override the check running `git commit --no-verify`
#' on the terminal.
#'
#' If you are using **RStudio** you can run also this command from a **R**
#' script by selecting that line and sending it to the terminal using:
#'
#' - Windows & Linux: `Ctrl+Alt+Enter`.
#' - Mac: `Cmd+Option+Return`.
#'
#' # Removing the git pre-commit hook
#'
#' You can remove the pre-commit hook by running `cff_git_hook_remove()`.
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
  return(invisible())
  # nocov end
}

#' @rdname cff_git_hook
#' @export
cff_git_hook_remove <- function() {
  # nocov start
  hookfile <- file.path(".git", "hooks", "pre-commit")

  if (file_exist_abort(hookfile)) {
    cli::cli_alert_info(
      "Removing git pre-commit hook (was on {.path {hookfile}})"
    )
    unlink(hookfile, force = TRUE)
  }

  return(invisible())
  # nocov end
}
