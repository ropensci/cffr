# Use a Git pre-commit hook **\[experimental\]**

Install a [pre-commit
hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks#_committing_workflow_hooks)
that reminds you to update your `CITATION.cff` file. This is a wrapper
around
[`usethis::use_git_hook()`](https://usethis.r-lib.org/reference/use_git_hook.html).

## Usage

``` r
cff_git_hook_install()

cff_git_hook_remove()
```

## Value

Invisible. This function is called for its side effects.

## Details

This function installs a pre-commit hook using
[`usethis::use_git_hook()`](https://usethis.r-lib.org/reference/use_git_hook.html).

A pre-commit hook is a script that identifies simple issues before
submission to code review. This pre-commit hook warns you if any of the
following conditions are met:

- You included your `DESCRIPTION` or `inst/CITATION` file in a commit
  but did not include your `CITATION.cff` and the `CITATION.cff` file is
  "older" than your `DESCRIPTION` or `inst/CITATION` file.

- You updated your `CITATION.cff` but did not include it in your commit.

## A word of caution

The pre-commit hook may prevent you from committing if you are not
updating your `CITATION.cff`. However, the detection mechanism is not
perfect and may be triggered even if you have attempted to update your
`CITATION.cff` file.

This typically occurs when you have updated your `DESCRIPTION` or
`inst/CITATION` files, but those changes do not affect your
`CITATION.cff` file, for example, when you add new dependencies.

In those cases, you can override the check by running
`git commit --no-verify` in the terminal.

If you are using **RStudio**, you can also run this command from an R
script by selecting that line and sending it to the terminal using:

- Windows & Linux: `Ctrl+Alt+Enter`.

- Mac: `Cmd+Option+Return`.

## Removing the Git pre-commit hook

You can remove the pre-commit hook using `cff_git_hook_remove()`.

## See also

- [`usethis::use_git_hook()`](https://usethis.r-lib.org/reference/use_git_hook.html),
  which is the underlying function used by `cff_git_hook_install()`.

- [`usethis::use_git()`](https://usethis.r-lib.org/reference/use_git.html)
  and related functions of
  [usethis](https://CRAN.R-project.org/package=usethis) for using Git
  with R packages.

Keep `CITATION.cff` up to date:
[`cff_gha_update()`](https://docs.ropensci.org/cffr/reference/cff_gha_update.md)

## Examples

``` r
if (FALSE) { # \dontrun{
cff_git_hook_install()
} # }
```
