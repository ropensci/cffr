# cffr 1.4.0

- DOIs in `inst/CITATION` `url` fields are detected, including those matching the pattern `.*dx.doi.org/`.
- The `website` field in `definitions.person` and `definitions.entity` uses ROR as a fallback.
- `cff_read()` correctly handles a single `languages` value (#105).
- `cff_validate()` now uses the [ajv](https://github.com/ajv-validator/ajv) validation engine via `jsonvalidate::json_validate()`, which returns more informative error messages.

# cffr 1.3.0

- The minimum required **R** version is now **4.1.0**.
- Vignettes were migrated to Quarto.

# cffr 1.2.1

- `as_cff_person()` improves comment detection and parsing across its function
  family.
- `cff_gha_update()` now runs in `ubuntu-latest` by default to save [GitHub Actions quota](https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-actions/about-billing-for-github-actions#minute-multipliers) (#90, thanks to \@Pakillo).
- The mapping of **CRAN** packages to SPDX codes was updated.

# cffr 1.2.0

- `cff_write()` gains a new `r_citation` argument. When it is set to `TRUE`,
  an **R** citation file (`inst/CITATION`) is generated or updated with the
  information from the generated `CITATION.cff` file. **No backup copy is
  created**. For more control, use `cff_write_citation()` (#79).
- `repository-code` now also recognizes [Codeberg](https://codeberg.org/) as a
  valid repository (#88).
- `repository-code` recognizes repositories regardless of casing. Lowercase is
  still recommended as a good practice for **R** developers.

# cffr 1.1.1

- ORCID extraction was adapted for **R \> 4.4.1**.

# cffr 1.1.0

- **cffr** now automatically adds DOIs to packages on **CRAN** (e.g.
  <https://doi.org/10.32614/CRAN.package.cffr>):
  - If the package has a `CITATION` file providing a DOI, the `CITATION` DOI is
    used as the main `CITATION.cff` `doi` and the **CRAN** DOI is added as an
    `identifier`.
  - Otherwise, the **CRAN** DOI is used as `doi`.
  - When extracting dependencies (e.g. `cff_create(dependencies = TRUE)`) and
    the package dependency is on **CRAN**, the **CRAN** DOI is used for the
    dependency in the `references` key.
- `commit` is extracted from `RemoteSha`.
- The `cran_to_spdx` dataset was updated.

# cffr 1.0.1

- `cff_write()` gains a new `encoding` argument to make it work with
  different encodings. See `iconv()`.
- Fixed **NOTEs** caused by empty lines in docs.

# cffr 1.0.0

This is a major release with some notable changes. The main change **affects
non-core functions**. The natural workflow (`cff_create()` → `cff_write()` →
`cff_validate()`) should not be affected.

## Major changes

### Classes and methods

**cffr** now implements a new class system for
[`definitions.reference`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsreference),
[`definitions.person`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsperson)
and
[`definitions.entity`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsentity)
objects:

- A list of `definitions.reference` objects (e.g. `references`) has class
  `cff_ref_lst, cff` and individual elements (e.g. `preferred-citation` or each
  member of `references`) have class `cff_ref, cff`.
- A list of `definitions.person` or `definitions.entity` objects (e.g.
  `authors`, `contact`) has class `cff_pers_lst, cff` and individual elements
  (e.g. `publisher` or each member of `authors`) have class `cff_pers, cff`.

This change allows writing specific [S3
methods](https://adv-r.hadley.nz/s3.html) and extends the capabilities of the
package.

- `as_cff()` is a new S3 generic method that replaces `as.cff()` and coerces
  **R** objects to `cff` class format. Current methods provided are:
  - `as_cff.Bibtex()`.
  - `as_cff.bibentry()`, replacing `cff_parse_citation()`.
  - `as_cff.person()`, similar to `as_cff_person()` but only for `person`
    objects. We recommend using `as_cff_person()` since it can also coerce
    strings representing authors in BibTeX markup (`"{von Neumen}, James"`),
    which cannot be captured properly via methods.
- `as_bibentry()` is a new method for a variety of classes (`character`, `list`,
  `NULL` and classes defined by **cffr**).
- `as_cff_person()` is a new method.
- The following **base** and **utils** methods now support the `cff` class:
  - `as.data.frame.cff()`.
  - `as.person()`, although **only** for `definitions.person` or
    `definitions.entity` (e.g. `authors`, `contacts`, `editors`, `publisher`,
    etc.).
  - `head.cff()`, `tail.cff()`.
  - `toBibtex.cff()`.

### API

The API has been completely revised to provide more clarity on function naming
and to facilitate internal maintenance. This change **only** **affects non-core
functions**. Each function now does fewer things but does them better. The old
API [has been
deprecated](https://lifecycle.r-lib.org/articles/stages.html#deprecated) and
now warns when used, providing advice on the replacement function.

#### Deprecation

- `cff_to_bibtex()` and `cff_extract_to_bibtex()`: replaced by the
  `as_bibentry()` S3 generic.
- `cff_parse_person()` and `cff_parse_person_bibtex()`: replaced by the
  `as_cff_person()` S3 generic.
- `cff_parse_citation()`: replaced by the `as_cff()` S3 generic.
- `cff_from_bibtex()`: replaced by `cff_read_bib()` (for `*.bib` files) and
  `cff_read_bib_text()` (for character strings).
- `write_bib()` and `write_citation()`: replaced by `cff_write_bib()` and
  `cff_write_citation()`, respectively.
- Argument `path` in `cff()` is also deprecated, use `cff_read()` instead.

### New capabilities

- `cff_read()` now handles reading from external files exclusively. It is
  designed to fit all supported file types in a single entry point, along with
  new specific readers used under the hood by `cff_read()`:
  - `cff_read_cff_citation()`.
  - `cff_read_description()`.
  - `cff_read_citation()`.
  - `cff_read_bib()`.
- `cff_modify()` is a new function for updating and modifying `cff` objects
  easily.

## Other changes

- The minimum required **R** version is now **4.0.0**.
- The BibTeX crosswalk was updated (see
  `vignette("bibtex-cff", package = "cffr")`), with corresponding changes in
  the mapping performed by `as_bibtex()` and `cff_parse_citation()`:
  - **\@inbook** and **\@book** gain a new value in CFF when **series** is
    provided: `collection-type: book-series`.
  - **cffr** can now handle BibLaTeX **\@inbook**, which differs significantly
    from BibTeX **\@inbook**.

# cffr 0.5.0

## Lifecycle

- `cff_to_bibtex()` and `cff_extract_to_bibtex()` have been merged.
  `cff_extract_to_bibtex()` is now soft-deprecated.

## New features

- `write_citation()` is a new function that can generate an `inst/CITATION`
  file from a `cff` object (#51).

## Enhancements

- Additional authors of an **R** package can now be included based on roles in
  the `DESCRIPTION` file, via the `authors_roles` argument (#49).

- The message interface now uses [**cli**](https://cli.r-lib.org/).

- The invisible result of `cff_validate()` now includes the summary of errors
  (if any) as an `attributes()` named `"error"`, as
  `jsonvalidate::json_validate()` does when `verbose = TRUE`:

  > Be verbose? If `TRUE`, then an attribute `"errors"` will list validation
  > failures as a data frame.

- Improved extraction of `date-released`.

# cffr 0.4.1

- Replaced the **crayon** dependency with **cli** (#46).
- `cff_validate()` performance was improved.

# cffr 0.4.0

- Fixed typo (#40, thanks to \@dpprdan).
- Added `cff_from_bibtex()`.
- Dependency URLs now behave consistently when RSPM is the default repository
  (for example, on GitHub Actions or RStudio Cloud).

# cffr 0.3.0

- `preferred-citation` is only produced when a `CITATION` **R** file has been
  provided with the package (#37).
- Improved email handling for authors.
- Added `cff_read()`. This functionality was already implemented in `cff()`,
  but the new function provides clarity.

# cffr 0.2.3

- Fixed the HTML5 issue as requested by **CRAN**.

# cffr 0.2.2

- **cffr** now uses a local copy of `schema.json` for validation (#33).

# cffr 0.2.1

- The GitHub Action now runs only on the `master` or `main` branch.
- References are handled better.

# cffr 0.2.0

- **cffr** now also extracts information about package dependencies and adds
  the main citation of the dependencies to the `references` field, using
  `citation(auto = TRUE)`.
  - Added the `dependencies` argument to `cff_create()` and `cff_write()`.
- Other improvements to `cff_parse_citation()` include:
  - `cff_parse_citation()` extracts more information about authors, based on
    the fields provided in the `DESCRIPTION` file.
  - `cff_parse_citation()` does a better job extracting information from
    `bibentry()`/BibTeX and mapping it to `preferred-citation/references`
    fields of CFF.
- Added new functions for working with git pre-commit hooks
  [![Experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental):
  - `cff_git_hook_install()`.
  - `cff_git_hook_remove()`.
- Added new BibTeX functions:
  - `cff_extract_to_bibtex()`.
  - `cff_to_bibtex()`.
  - `cff_parse_person_bibtex()`.
  - `write_bib()`.
- Added a new dependency: **lifecycle**.

# cffr 0.1.1

- Accepted by JOSS.
  [![DOI](https://joss.theoj.org/papers/10.21105/joss.03900/status.svg)](https://doi.org/10.21105/joss.03900)
- Added `pages` to `cff_parse_citation()`.
- Added the `gh_keywords` argument to `cff_create()`/`cff_write()`. If `TRUE`,
  it includes GitHub repository topics as keywords.

# cffr 0.1.0

- First CRAN release.

# cffr 0.0.2

- **cffr** is now part of rOpenSci.
- Updated documentation and README.
- Added fuzzy matching for the `keys` argument.
- Added the `cran_to_spdx` dataset.
- Added the DOI <https://doi.org/10.5281/zenodo.5509766>.
- Installed package citations are extracted using `citation()`.
- The `preferred-citation` key is automatically generated from `DESCRIPTION`.
- Renamed `cff_schema_definitions_reference()` to
  `cff_schema_definitions_refs()`.
- `repository` key is supported.
- Added the `vignette("r-cff", package = "cffr")` vignette.
- Added support for **Bioconductor** packages.
- Added `cff_gha_update()`.

# cffr 0.0.1

- First stable release.
