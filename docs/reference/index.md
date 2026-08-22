# Package index

## Create and maintain `CITATION.cff` files

Main workflow for R package authors.

- [`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)
  :

  Write a `CITATION.cff` file

- [`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
  :

  Create a `cff` object from multiple sources

- [`cff()`](https://docs.ropensci.org/cffr/reference/cff.md) :

  Create `cff` objects from direct inputs

- [`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md)
  :

  Validate a `CITATION.cff` file or a `cff` object

- [`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md)
  :

  Modify a `cff` object

## Read and write citation metadata

### Read metadata

Read CFF, BibTeX and R package metadata.

- [`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  [`cff_read_cff_citation()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  [`cff_read_description()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  [`cff_read_citation()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  [`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  :

  Read an external file as a `cff` object

- [`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md)
  :

  Read BibTeX markup as a `cff_ref_lst` object

### Write metadata

Write CFF objects as citation files or BibTeX.

- [`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)
  [`cff_write_citation()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)
  :

  Export R objects to multiple file types

## Convert between CFF, R and BibTeX

Convert citation metadata to standard R objects and back.

### Conversion helpers

- [`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md)
  :

  Create [`bibentry`](https://rdrr.io/r/utils/bibentry.html) objects
  from multiple sources

- [`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md) :

  Coerce lists and citation objects to `cff`

- [`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
  :

  Coerce R objects to `cff_pers_lst` objects

### BibTeX helpers

## Inspect CFF schema values

List valid keys, licenses, versions and source types.

- [`cff_schema_keys()`](https://docs.ropensci.org/cffr/reference/cff_schema.md)
  [`cff_schema_keys_license()`](https://docs.ropensci.org/cffr/reference/cff_schema.md)
  [`cff_schema_definitions_person()`](https://docs.ropensci.org/cffr/reference/cff_schema.md)
  [`cff_schema_definitions_entity()`](https://docs.ropensci.org/cffr/reference/cff_schema.md)
  [`cff_schema_definitions_refs()`](https://docs.ropensci.org/cffr/reference/cff_schema.md)
  : Inspect CFF schema values

## Automation

Helpers for keeping `CITATION.cff` synchronized with package metadata.

- [`cff_gha_update()`](https://docs.ropensci.org/cffr/reference/cff_gha_update.md)
  :

  Install a [cffr](https://CRAN.R-project.org/package=cffr) GitHub
  Actions workflow

- [`cff_git_hook_install()`](https://docs.ropensci.org/cffr/reference/cff_git_hook.md)
  [`cff_git_hook_remove()`](https://docs.ropensci.org/cffr/reference/cff_git_hook.md)
  :

  Use a Git pre-commit hook **\[experimental\]**

## Data

Datasets used internally to map citation metadata.

- [`cran_to_spdx`](https://docs.ropensci.org/cffr/reference/cran_to_spdx.md)
  :

  Mapping between `License` fields and SPDX

## Package internals and lifecycle

### Class system

Structure and behavior of CFF objects.

- [`cff_class`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`cff_ref`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`cff_pers`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`print.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`c.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`[.cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`[.cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.data.frame.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.data.frame.cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.data.frame.cff_pers`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.data.frame.cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.data.frame.cff_ref`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`head.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`tail.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.list.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`toBibtex.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`toBibtex.cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`toBibtex.cff_ref`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`toBibtex.cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`toBibtex.cff_pers`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.person.cff_pers`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.person.cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.person.cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.person.cff_ref`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  [`as.person.cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  :

  The `cff` class

### Deprecated functions

Superseded interfaces retained for compatibility.

- [`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md)
  **\[obsoleta\]** :

  Previous API: parse a `bibentry` object to `cff`

- [`cff_from_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_from_bib.md)
  **\[obsoleta\]** :

  Previous API: create a `cff` object from BibTeX entries

- [`cff_parse_person()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md)
  [`cff_parse_person_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md)
  **\[obsoleta\]** :

  Previous API: parse a `person` to `cff`

- [`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md)
  [`cff_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md)
  **\[obsoleta\]** : Previous API: create BibTeX entries from multiple
  sources

- [`write_bib()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)
  [`write_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)
  **\[obsoleta\]** : Previous API: write files

### Package overview

Package-level documentation and references.

- [`cffr`](https://docs.ropensci.org/cffr/reference/cffr-package.md)
  [`cffr-package`](https://docs.ropensci.org/cffr/reference/cffr-package.md)
  : cffr: Generate Citation File Format ('CFF') Metadata for R Packages
