# cffr 0.4.0

-   Fix typo (#40) by @dpprdan
-   Add new function `cff_from_bibtex()`.
-   Consistent behavior on dependency urls when RSPM is the default repo (i.e.
    on GitHub Actions or RStudio Cloud).

# cffr 0.3.0

-   `preferred-citation` is only produced when a CITATION (**R**) file has been
    provided with the package (#37).
-   Improve email handling on authors.
-   Add `cff_read()` function. This functionality was already implemented on
    `cff()` but new function added in order to provide clarity.

# cffr 0.2.3

-   Fix HTML5 issue as per CRAN request

# cffr 0.2.2

-   **cffr** now uses a local copy of the schema.json for validating. (#33).

# cffr 0.2.1

-   GitHub Action now runs only on `master` or `main`branch.

-   Better handling of references

# cffr 0.2.0

-   Now **cffr** extracts also information of the package dependencies and adds
    the main citation of the dependencies to the `references` field, using
    `citation(auto = TRUE)`.

    -   New `dependencies` parameter on `cff_create()` and `cff_write()`.

-   Other improvements on `cff_parse_citation():`

    -   `cff_parse_citation()` extracts more information of authors, based on
        the fields provided on the DESCRIPTION file.

    -   `cff_parse_citation()` does a better job extracting information from
        `bibentry()` /BibTeX and mapping it to `preferred-citation/references`
        fields of CFF.

-   Add new functions for working with git pre-commit hooks
    [![Experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental):

    -   `cff_git_hook_install()`
    -   `cff_git_hook_remove()`

-   New BibTeX functions:

    -   `cff_extract_to_bibtex()`
    -   `cff_to_bibtex()`
    -   `cff_parse_person_bibtex()`
    -   `write_bib()`

-   Add a new dependency: `lifecycle`.

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
