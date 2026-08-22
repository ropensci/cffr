# Install a [cffr](https://CRAN.R-project.org/package=cffr) GitHub Actions workflow

This function installs a [GitHub
Actions](https://github.com/features/actions) workflow in your
repository. The workflow updates your `CITATION.cff` when any of these
events occur:

- You publish a new release of the package.

- Your `DESCRIPTION` or `inst/CITATION` file is modified.

- The action can be run manually.

## Usage

``` r
cff_gha_update(path = ".", overwrite = FALSE)
```

## Arguments

- path:

  Project root directory.

- overwrite:

  A logical value. If `TRUE`, overwrite an existing workflow.

## Value

Invisible. This function is called for its side effects.

## Details

Triggers on your action can be modified. See [Events that trigger
workflows](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows).

## See also

Keep `CITATION.cff` up to date:
[`cff_git_hook`](https://docs.ropensci.org/cffr/reference/cff_git_hook.md)

## Examples

``` r
if (FALSE) { # \dontrun{
cff_gha_update()
} # }
```
