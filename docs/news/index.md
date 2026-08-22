# Changelog

## cffr 1.4.1

CRAN release: 2026-06-17

- Internal code and documentation were reviewed and refactored with AI
  assistance to improve maintainability, consistency and user-facing
  messages.
- Tests were improved with AI assistance to reduce dependence on
  external services and make internal fixtures more robust.

## cffr 1.4.0

CRAN release: 2026-05-04

- DOIs in `inst/CITATION` `url` fields are detected, including those
  matching the pattern `.*dx.doi.org/`.
- The `website` field in `definitions.person` and `definitions.entity`
  uses ROR as a fallback.
- [`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  correctly handles a single `languages` value
  ([\#105](https://github.com/ropensci/cffr/issues/105)).
- [`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md)
  now uses the [ajv](https://github.com/ajv-validator/ajv) validation
  engine through
  [`jsonvalidate::json_validate()`](https://docs.ropensci.org/jsonvalidate/reference/json_validate.html),
  which returns more informative error messages.

## cffr 1.3.0

CRAN release: 2026-03-13

- The minimum required **R** version is now **4.1.0**.
- Vignettes were migrated to Quarto.

## cffr 1.2.1

CRAN release: 2026-01-12

- [`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
  improves comment detection and parsing across its function family.
- [`cff_gha_update()`](https://docs.ropensci.org/cffr/reference/cff_gha_update.md)
  now runs in `ubuntu-latest` by default to save [GitHub Actions
  quota](https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-actions/about-billing-for-github-actions#minute-multipliers)
  ([\#90](https://github.com/ropensci/cffr/issues/90), thanks to
  [@Pakillo](https://github.com/Pakillo)).
- The mapping of **CRAN** packages to SPDX codes was updated.

## cffr 1.2.0

CRAN release: 2025-01-25

- [`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)
  gains a new `r_citation` argument. When it is set to `TRUE`, an **R**
  citation file (`inst/CITATION`) is generated or updated with the
  information from the generated `CITATION.cff` file. **No backup copy
  is created**. For more control, use
  [`cff_write_citation()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)
  ([\#79](https://github.com/ropensci/cffr/issues/79)).
- `repository-code` now also recognizes
  [Codeberg](https://codeberg.org/) as a valid repository
  ([\#88](https://github.com/ropensci/cffr/issues/88)).
- `repository-code` recognizes repositories regardless of casing.
  Lowercase is still recommended as a good practice for **R**
  developers.

## cffr 1.1.1

CRAN release: 2024-08-16

- ORCID extraction was adapted for **R \> 4.4.1**.

## cffr 1.1.0

CRAN release: 2024-07-23

- **cffr** now automatically adds DOIs to packages on **CRAN** (for
  example, <https://doi.org/10.32614/CRAN.package.cffr>):
  - If the package has a `CITATION` file providing a DOI, the `CITATION`
    DOI is used as the main `CITATION.cff` `doi` and the **CRAN** DOI is
    added as an `identifier`.
  - Otherwise, the **CRAN** DOI is used as `doi`.
  - When extracting dependencies (for example,
    `cff_create(dependencies = TRUE)`) and the package dependency is on
    **CRAN**, the **CRAN** DOI is used for the dependency in the
    `references` key.
- `commit` is extracted from `RemoteSha`.
- The `cran_to_spdx` dataset was updated.

## cffr 1.0.1

CRAN release: 2024-04-09

- [`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)
  gains a new `encoding` argument to make it work with different
  encodings. See [`iconv()`](https://rdrr.io/r/base/iconv.html).
- Fixed **NOTEs** caused by empty lines in docs.

## cffr 1.0.0

CRAN release: 2024-03-12

This is a major release with some notable changes. The main change
**affects non-core functions**. The natural workflow
([`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
→ [`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)
→
[`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md))
should not be affected.

### Major changes

#### Classes and methods

**cffr** now implements a new class system for
[`definitions.reference`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsreference),
[`definitions.person`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsperson)
and
[`definitions.entity`](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionsentity)
objects:

- A list of `definitions.reference` objects, such as `references`, has
  class `cff_ref_lst, cff`. Individual elements, such as
  `preferred-citation` or each member of `references`, have class
  `cff_ref, cff`.
- A list of `definitions.person` or `definitions.entity` objects, such
  as `authors` or `contact`, has class `cff_pers_lst, cff`. Individual
  elements, such as `publisher` or each member of `authors`, have class
  `cff_pers, cff`.

This change allows writing specific [S3
methods](https://adv-r.hadley.nz/s3.html) and extends the capabilities
of the package.

- [`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md) is a
  new S3 generic that replaces
  [`as.cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md) and
  coerces **R** objects to `cff` class format. Current methods provided
  are:
  - [`as_cff.Bibtex()`](https://docs.ropensci.org/cffr/reference/as_cff.md).
  - [`as_cff.bibentry()`](https://docs.ropensci.org/cffr/reference/as_cff.md),
    replacing
    [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md).
  - [`as_cff.person()`](https://docs.ropensci.org/cffr/reference/as_cff.md),
    similar to
    [`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
    but only for `person` objects. We recommend using
    [`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
    since it can also coerce strings representing authors in BibTeX
    markup (`"{von Neumen}, James"`), which cannot be captured properly
    through methods.
- [`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md)
  is a new method for a variety of classes (`character`, `list`, `NULL`
  and classes defined by **cffr**).
- [`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
  is a new method.
- The following **base** and **utils** package methods now support the
  `cff` class:
  - [`as.data.frame.cff()`](https://docs.ropensci.org/cffr/reference/cff_class.md).
  - [`as.person()`](https://rdrr.io/r/utils/person.html), although
    **only** for `definitions.person` or `definitions.entity`, such as
    `authors`, `contacts`, `editors` or `publisher`.
  - [`head.cff()`](https://docs.ropensci.org/cffr/reference/cff_class.md),
    [`tail.cff()`](https://docs.ropensci.org/cffr/reference/cff_class.md).
  - [`toBibtex.cff()`](https://docs.ropensci.org/cffr/reference/cff_class.md).

#### API

The API has been completely revised to provide more clarity on function
naming and to facilitate internal maintenance. This change **only**
**affects non-core functions**. Each function now does fewer things but
does them better. The old API [has been
deprecated](https://lifecycle.r-lib.org/articles/stages.html#deprecated)
and now warns when used, providing advice on the replacement function.

##### Deprecation

- [`cff_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md)
  and
  [`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md):
  replaced by the
  [`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md)
  S3 generic.
- [`cff_parse_person()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md)
  and
  [`cff_parse_person_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md):
  replaced by the
  [`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
  S3 generic.
- [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md):
  replaced by the
  [`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md) S3
  generic.
- [`cff_from_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_from_bib.md):
  replaced by
  [`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  (for `*.bib` files) and
  [`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md)
  (for character strings).
- [`write_bib()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)
  and
  [`write_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md):
  replaced by
  [`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)
  and
  [`cff_write_citation()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md),
  respectively.
- Argument `path` in
  [`cff()`](https://docs.ropensci.org/cffr/reference/cff.md) is also
  deprecated, use
  [`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  instead.

#### New capabilities

- [`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  now handles reading from external files exclusively. It is designed to
  fit all supported file types in a single entry point, along with new
  specific readers used under the hood by
  [`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md):
  - [`cff_read_cff_citation()`](https://docs.ropensci.org/cffr/reference/cff_read.md).
  - [`cff_read_description()`](https://docs.ropensci.org/cffr/reference/cff_read.md).
  - [`cff_read_citation()`](https://docs.ropensci.org/cffr/reference/cff_read.md).
  - [`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md).
- [`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md)
  is a new function for updating and modifying `cff` objects easily.

### Other changes

- The minimum required **R** version is now **4.0.0**.
- The BibTeX crosswalk was updated (see
  [`vignette("bibtex-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/bibtex-cff.md)),
  with corresponding changes in the mapping performed by `as_bibtex()`
  and
  [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md):
  - **@inbook** and **@book** gain a new value in CFF when **series** is
    provided: `collection-type: book-series`.
  - **cffr** can now handle BibLaTeX **@inbook**, which differs
    significantly from BibTeX **@inbook**.

## cffr 0.5.0

CRAN release: 2023-05-05

### Lifecycle

- [`cff_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md)
  and
  [`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md)
  have been merged.
  [`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md)
  is now soft-deprecated.

### New features

- [`write_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)
  is a new function that can generate an `inst/CITATION` file from a
  `cff` object ([\#51](https://github.com/ropensci/cffr/issues/51)).

### Enhancements

- Additional authors of an **R** package can now be included based on
  roles in the `DESCRIPTION` file, through the `authors_roles` argument
  ([\#49](https://github.com/ropensci/cffr/issues/49)).

- The message interface now uses [**cli**](https://cli.r-lib.org/).

- The invisible result of
  [`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md)
  now includes the summary of errors (if any) as an
  [`attributes()`](https://rdrr.io/r/base/attributes.html) named
  `"error"`, as
  [`jsonvalidate::json_validate()`](https://docs.ropensci.org/jsonvalidate/reference/json_validate.html)
  does when `verbose = TRUE`:

  > Be verbose? If `TRUE`, then an attribute `"errors"` will list
  > validation failures as a data frame.

- Improved extraction of `date-released`.

## cffr 0.4.1

CRAN release: 2023-01-30

- Replaced the **crayon** dependency with **cli**
  ([\#46](https://github.com/ropensci/cffr/issues/46)).
- [`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md)
  performance was improved.

## cffr 0.4.0

CRAN release: 2022-11-17

- Fixed typo ([\#40](https://github.com/ropensci/cffr/issues/40), thanks
  to [@dpprdan](https://github.com/dpprdan)).
- Added
  [`cff_from_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_from_bib.md).
- Dependency URLs now behave consistently when RSPM is the default
  repository (for example, on GitHub Actions or RStudio Cloud).

## cffr 0.3.0

CRAN release: 2022-09-23

- `preferred-citation` is only produced when `inst/CITATION` has been
  provided with the package
  ([\#37](https://github.com/ropensci/cffr/issues/37)).
- Improved email handling for authors.
- Added
  [`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md).
  This functionality was already implemented in
  [`cff()`](https://docs.ropensci.org/cffr/reference/cff.md), but the
  new function provides clarity.

## cffr 0.2.3

CRAN release: 2022-08-15

- Fixed the HTML5 issue as requested by **CRAN**.

## cffr 0.2.2

CRAN release: 2022-04-08

- **cffr** now uses a local copy of `schema.json` for validation
  ([\#33](https://github.com/ropensci/cffr/issues/33)).

## cffr 0.2.1

CRAN release: 2022-01-16

- The GitHub Actions workflow now runs only on the `master` or `main`
  branch.
- References are handled better.

## cffr 0.2.0

CRAN release: 2022-01-04

- **cffr** now also extracts information about package dependencies and
  adds the main citation of the dependencies to the `references` key,
  using `citation(auto = TRUE)`.
  - Added the `dependencies` argument to
    [`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
    and
    [`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md).
- Other improvements to
  [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md)
  include:
  - [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md)
    extracts more information about authors, based on the fields
    provided in the `DESCRIPTION` file.
  - [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md)
    does a better job extracting information from
    [`bibentry()`](https://rdrr.io/r/utils/bibentry.html)/BibTeX and
    mapping it to the `preferred-citation` and `references` CFF keys.
- Added new functions for working with git pre-commit hooks
  [![Experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental):
  - [`cff_git_hook_install()`](https://docs.ropensci.org/cffr/reference/cff_git_hook.md).
  - [`cff_git_hook_remove()`](https://docs.ropensci.org/cffr/reference/cff_git_hook.md).
- Added new BibTeX functions:
  - [`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md).
  - [`cff_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md).
  - [`cff_parse_person_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md).
  - [`write_bib()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md).
- Added a new dependency: **lifecycle**.

## cffr 0.1.1

CRAN release: 2021-11-11

- Accepted by JOSS.
  [![DOI](https://joss.theoj.org/papers/10.21105/joss.03900/status.svg)](https://doi.org/10.21105/joss.03900)
- Added `pages` to
  [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md).
- Added the `gh_keywords` argument to
  [`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)/[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md).
  If `TRUE`, it includes GitHub repository topics as keywords.

## cffr 0.1.0

CRAN release: 2021-11-04

- First CRAN release.

## cffr 0.0.2

- **cffr** is now part of rOpenSci.
- Updated documentation and README.
- Added fuzzy matching for the `keys` argument.
- Added the `cran_to_spdx` dataset.
- Added the DOI <https://doi.org/10.5281/zenodo.5509766>.
- Installed package citations are extracted using
  [`citation()`](https://rdrr.io/r/utils/citation.html).
- The `preferred-citation` key is automatically generated from
  `DESCRIPTION`.
- Renamed `cff_schema_definitions_reference()` to
  [`cff_schema_definitions_refs()`](https://docs.ropensci.org/cffr/reference/cff_schema.md).
- `repository` key is supported.
- Added the
  [`vignette("r-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/r-cff.md)
  vignette.
- Added support for **Bioconductor** packages.
- Added
  [`cff_gha_update()`](https://docs.ropensci.org/cffr/reference/cff_gha_update.md).

## cffr 0.0.1

- First stable release.
