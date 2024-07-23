# cffr 1.1.0

-   Now **cffr** adds automatically dois to packages on **CRAN** (e.g.
    <https://doi.org/10.32614/CRAN.package.cffr>):
    -   If the package has a `CITATION` file providing a doi, the `CITATION` doi
        would be used as the main `CITATION.cff` `doi` and the **CRAN** doi
        would be added as an `identifier`.
    -   Otherwise, **CRAN** doi would be used as `doi`.
    -   When extracting dependencies (e.g `cff_create(dependencies = TRUE)` and
        the package dependency is on **CRAN**, the **CRAN** doi would be used
        for the dependency in the `references` key.
-   Extract `commit` from `RemoteSha`.
-   Update `cran_to_spdx` dataset.

# cffr 1.0.1

-   Update `cff_write()` to add a new `encoding` argument to make it work with
    different encodings, see `iconv()`.
-   Fix **NOTEs** due to empty lines in docs.

# cffr 1.0.0

This is a major release with some notable changes. The change mainly **affects
to non-core functions**, hence the natural workflow (`cff_create()` →
`cff_write()` → `cff_validate()`) shouldn't be affected.

## Major changes

### Classes and methods

Now **cffr** implements a new class system for
[`definitions.reference`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsreference),
[`definitions.person`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsperson)
and
[`definitions.entity`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsentity)
objects:

-   List of `definitions.reference` (e.g, `references)` has class
    `cff_ref_lst, cff` and individual elements (e.g `preferred-citation` or each
    member of `references`) has class `cff_ref, cff`.
-   List of `definitions.person` or `definitions.entity` (e.g. `authors`,
    `contact`) has class `cff_pers_lst, cff` and individual elements (e.g
    `publisher` or each member of `authors`) has class `cff_pers, cff`.

This change allow to write specific [S3
Methods](https://adv-r.hadley.nz/s3.html) and extend the capabilities of the
package.

-   New `as_cff()` S3 generic method (replacing `as.cff()`): This method coerces
    **R** objects to `cff` class format. Current methods provided are:
    -   `as_cff.Bibtex()`.
    -   `as_cff.bibentry()`, replacing `cff_parse_citation()`.
    -   `as_cff.person()`, similar to `as_cff_person()` but only for `person`
        objects. We recommend using `as_cff_person()` since it can coerce also
        string representing authors in BibTeX markup (`"{von Neumen}, James"`),
        that can't be captured properly via methods.
-   New `as_bibentry()` method for a variety of classes (`character`, `list`,
    `NULL` and classes defined by **cffr**).
-   New `as_cff_person()` method.
-   The following **base** and **utils** methods supports now `cff` class:
    -   `as.data.frame.cff()`.
    -   `as.person()`, although **only** for `definitions.person` or
        `definitions.entity` (e.g. `authors`, `contacts`, `editors`,
        `publisher,` etc.).
    -   `head.cff()`, `tail.cff()`.
    -   `toBibtex.cff()`.

### API

The API has been completely reviewed to provide more clarity on functions naming
and to facilitate internal maintenance. This change **only** **affects to
non-core functions**. Now each function does less things but does it better. The
old API [has been
deprecated](https://lifecycle.r-lib.org/articles/stages.html#deprecated) and it
would warn when used, providing advice on the replacement function.

#### Deprecation

-   `cff_to_bibtex()` and `cff_extract_to_bibtex()`: replaced by `as_bibentry()`
    S3 generic.
-   `cff_parse_person()` and `cff_parse_person_bibtex()`: replaced by
    `as_cff_person()` S3 generic.
-   `cff_parse_citation()`: replaced by `as_cff()` S3 generic.
-   `cff_from_bibtex()`: replaced by `cff_read_bib()` (for `*.bib` files) and
    `cff_read_bib_text()` (for character strings).
-   `write_bib()` and `write_citation()` : replaced by `cff_write_bib()` and
    `cff_write_citation()` respectively.
-   Argument `path` in `cff()` is also deprecated, use `cff_read()` instead.

### New capabilities

-   Now reading from external files is performed exclusively by `cff_read()`
    (that is designed to fit all supported file types on a single entry point)
    and the new specific readers (that are used under the hood by `cff_read()`),
    namely:
    -   `cff_read_cff_citation()`,
    -   `cff_read_description()`,
    -   `cff_read_citation()`
    -   `cff_read_bib()`.
-   New `cff_modify()` function for updating and modifying `cff` objects easily.

## Other changes

-   Minimum **R** version required now is **4.0.0**.
-   Update of BibTeX crosswalk (see `vignette("bibtex_cff", package = "cffr")`)
    and consequently changes in the mapping performed by `as_bibtex()`
    `cff_parse_citation()`:
    -   **\@inbook** and **\@book** gains a new value on [CFF]{.underline} when
        **series** is provided: [collection-type: book-series.]{.underline}
    -   Can handle BibLaTeX **\@inbook**, that differs significantly from BibTeX
        **\@inbook**.

# cffr 0.5.0

## Lifecycle

-   Function `cff_to_bibtex()` and `cff_extract_to_bibtex()` have been merged,
    the latter (`cff_extract_to_bibtex()`) is now soft-deprecated.

## New features

-   New function `write_citation()` that can generate a inst/CITATION file from
    a `cff` object (#51).

## Enhancements

-   Additional authors of a **R** package can be now included based on the role
    on the `DESCRIPTION` file, via the parameter `authors_roles` (#49).

-   New message interface based on [**cli**](https://cli.r-lib.org/)
    capabilities.

-   Now the (invisible) result of `cff_validate()` includes the summary of
    errors (if any) as an `attributes()` named `"error"`, as
    `jsonvalidate::json_validate()` does when `verbose = TRUE`:

    > Be verbose? If `TRUE`, then an attribute `"errors"` will list validation
    > failures as a data.frame

-   Improvements in the extraction of `` `date-release` ``.

# cffr 0.4.1

-   Replace **crayon** dependency for **cli** (#46).
-   Improvements on the performance of `cff_validate()`.

# cffr 0.4.0

-   Fix typo (#40) by @dpprdan
-   Add new function `cff_from_bibtex()`.
-   Consistent behavior on dependency urls when RSPM is the default repo (i.e.
    on GitHub Actions or RStudio Cloud).

# cffr 0.3.0

-   `preferred-citation` is only produced when a `CITATION` **R** file has been
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
        the fields provided on the `DESCRIPTION` file.
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

-   **cffr** is part now of rOpenSci.
-   Update on docs and README.
-   Add fuzzy match on `keys` parameter.
-   New dataset: `cran_to_spdx`.
-   Add DOI <https://doi.org/10.5281/zenodo.5509766>
-   Citation of installed packages extracted using `citation().`
-   Auto-generating `preferred-citation` key from `DESCRIPTION`.
-   Rename `cff_schema_definitions_reference()` to
    `cff_schema_definitions_refs()`.
-   `repository` key is supported.
-   Added vignette: `vignette("crosswalk", package = "cffr")`.
-   Add support to Bioconductor packages.
-   New function: `cff_gha_update()`.

# cffr 0.0.1

-   First stable release
