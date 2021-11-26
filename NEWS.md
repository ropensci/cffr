# cffr (development version)

-   Add new functions for working with git pre-commit hooks
    [![Experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental):

    -   `cff_git_hook_install()`
    -   `cff_git_hook_remove()`

# cffr 0.1.1

-   Accepted on JOSS
    [![DOI](https://joss.theoj.org/papers/10.21105/joss.03900/status.svg)](https://doi.org/10.21105/joss.03900)
-   Include `pages` on `cff_parse_citation()` .
-   New `gh_keywords` parameter on `cff_create()` /`cff_write()`. If `TRUE`, it
    would include GitHub repo topics as keywords.

# cffr 0.1.0

-   First CRAN release

# cffr 0.0.2

-   `cffr` is part now of rOpenSci.
-   Update on docs and README.
-   Add fuzzy match on `keys` parameter.
-   New dataset: `cran_to_spdx`.
-   Add DOI <https://doi.org/10.5281/zenodo.5509766>
-   Citation of installed packages extracted using `citation().`
-   Auto-generating `preferred-citation` key from DESCRIPTION.
-   Rename `cff_schema_definitions_reference()` to
    `cff_schema_definitions_refs()`.
-   "repository" key is supported.
-   Added vignette: `vignette("crosswalk", package = "cffr")`.
-   Add support to Bioconductor packages.
-   New function: `cff_gha_update()`.

# cffr 0.0.1

-   First stable release
