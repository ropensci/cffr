# Read an external file as a [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object

Read files and convert them to
[`cff`](https://docs.ropensci.org/cffr/reference/cff.md) objects.
Supported files are:

- `CITATION.cff` files.

- `DESCRIPTION` files.

- R citation files (usually located in `inst/CITATION`).

- BibTeX files (with extension `*.bib`).

`cff_read()` attempts to guess the type of file provided in `path`.
However, we provide aliases for each specific file type:

- `cff_read_cff_citation()`, which uses
  [`yaml::read_yaml()`](https://yaml.r-lib.org/reference/read_yaml.html).

- `cff_read_description()`, which uses
  [`desc::desc()`](https://desc.r-lib.org/reference/desc.html).

- `cff_read_citation()`, which uses
  [`utils::readCitationFile()`](https://rdrr.io/r/utils/citation.html).

- `cff_read_bib()`, which requires
  [bibtex](https://CRAN.R-project.org/package=bibtex) (\>= 0.5.0) and
  uses
  [`bibtex::read.bib()`](https://docs.ropensci.org/bibtex/reference/read.bib.html).

## Usage

``` r
cff_read(path, ...)

cff_read_cff_citation(path, ...)

cff_read_description(
  path,
  cff_version = "1.2.0",
  gh_keywords = TRUE,
  authors_roles = c("aut", "cre"),
  ...
)

cff_read_citation(path, meta = NULL, ...)

cff_read_bib(path, encoding = "UTF-8", ...)
```

## Arguments

- path:

  A path to a file.

- ...:

  Arguments passed to other functions, for example to
  [`yaml::read_yaml()`](https://yaml.r-lib.org/reference/read_yaml.html)
  or
  [`bibtex::read.bib()`](https://docs.ropensci.org/bibtex/reference/read.bib.html).

- cff_version:

  The Citation File Format schema version used for the generated
  metadata.

- gh_keywords:

  A logical value. If `TRUE` and the package is hosted on GitHub, add
  the repository topics as keywords.

- authors_roles:

  Roles to be considered as authors of the package when generating the
  `CITATION.cff` file. See **Details**.

- meta:

  A list of package metadata as obtained by
  [`utils::packageDescription()`](https://rdrr.io/r/utils/packageDescription.html)
  or `NULL` (the default). See **Details**.

- encoding:

  Encoding to be assumed for `path`. See
  [`base::readLines()`](https://rdrr.io/r/base/readLines.html).

## Value

- `cff_read_cff_citation()` and `cff_read_description()` return an
  object with class `cff`.

- `cff_read_citation()` and `cff_read_bib()` return an object of classes
  [`cff_ref_lst, cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
  according to the `definitions.reference` specified in the following
  guide: [Citation File Format schema
  guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

Learn more about the [cffr](https://CRAN.R-project.org/package=cffr)
class system in
[cff_class](https://docs.ropensci.org/cffr/reference/cff_class.md).

## Details

For details of `cff_read_description()`, see
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md).

### The `meta` object

Section 1.9 CITATION files of *Writing R Extensions* (R Core Team 2026)
specifies how to create dynamic `CITATION` files using a `meta` object.
Therefore, the `meta` argument in `cff_read_citation()` may be needed to
read some files correctly.

## References

R Core Team (2026). *Writing R Extensions*.
<https://cran.r-project.org/doc/manuals/r-release/R-exts.html>.

Hernangómez D (2022). "BibTeX and CFF, a potential crosswalk."
[cffr](https://CRAN.R-project.org/package=cffr) vignette.
<https://docs.ropensci.org/cffr/articles/bibtex-cff.html>.

## See also

The underlying functions used for reading external files:

- [`yaml::read_yaml()`](https://yaml.r-lib.org/reference/read_yaml.html)
  for `CITATION.cff` files.

- [`desc::desc()`](https://desc.r-lib.org/reference/desc.html) for
  `DESCRIPTION` files.

- [`utils::readCitationFile()`](https://rdrr.io/r/utils/citation.html)
  for R citation files.

- [`bibtex::read.bib()`](https://docs.ropensci.org/bibtex/reference/read.bib.html)
  for BibTeX files (extension `*.bib`).

Read external citation metadata:
[`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md)

Work with BibTeX metadata:
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
[`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md),
[`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)

## Examples

``` r
# Create a `cff` object from a `CITATION.cff` file.
from_cff_file <- cff_read(system.file("examples/CITATION_basic.cff",
  package = "cffr"
))

head(from_cff_file, 7)
#> cff-version: 1.2.0
#> message: If you use this software in your research, please cite it as below.
#> title: cff-validator
#> abstract: Validate your repository's CITATION.cff file using R software
#> authors:
#> - family-names: Hernangómez
#>   given-names: Diego
#>   orcid: https://orcid.org/0000-0001-8457-4658
#> license: MIT
#> repository-code: https://github.com/dieghernan/cff-validator

# Create a `cff` object from DESCRIPTION.
from_desc <- cff_read(system.file("examples/DESCRIPTION_basic",
  package = "cffr"
))

from_desc
#> cff-version: 1.2.0
#> message: 'To cite package "basicdesc" in publications use:'
#> type: software
#> title: 'basicdesc: A Basic Description'
#> version: 0.1.6
#> authors:
#> - family-names: Basic
#>   given-names: Marc
#>   email: marcbasic@gmail.com
#> abstract: A very basic description. Should parse without problems.
#> repository-code: https://github.com/basic/package
#> url: https://basic.github.io/package
#> contact:
#> - family-names: Basic
#>   given-names: Marc
#>   email: marcbasic@gmail.com
#> license: GPL-3.0-only

# Create a `cff` object from BibTeX.
if (requireNamespace("bibtex", quietly = TRUE)) {
  from_bib <- cff_read(system.file("examples/example.bib",
    package = "cffr"
  ))

  # First item only.
  from_bib[[1]]
}
#> type: generic
#> title: Citation File Format
#> authors:
#> - family-names: Druskat
#>   given-names: Stephan
#> - family-names: Spaaks
#>   given-names: Jurriaan H.
#> - family-names: Chue Hong
#>   given-names: Neil
#> - family-names: Haines
#>   given-names: Robert
#> - family-names: Baker
#>   given-names: James
#> - family-names: Bliven
#>   given-names: Spencer
#> - family-names: Willighagen
#>   given-names: Egon
#> - family-names: Pérez-Suárez
#>   given-names: David
#> - family-names: Konovalov
#>   given-names: Alexander
#> year: '2021'
#> month: '8'
#> doi: 10.5281/zenodo.5171937
#> url: https://github.com/citation-file-format/citation-file-format
#> date-accessed: '2021-11-07'
#> copyright: CC-BY-4.0
#> abstract: The Citation File Format lets you provide citation metadata for software
#>   or datasets in plaintext files that are easy to read by both humans and machines.
# Create a `cff` object from CITATION.
from_citation <- cff_read(system.file("CITATION", package = "cffr"))

# First item only.
from_citation[[1]]
#> type: article
#> title: 'cffr: Generate Citation File Format Metadata for R Packages'
#> authors:
#> - family-names: Hernangómez
#>   given-names: Diego
#> doi: 10.21105/joss.03900
#> url: https://doi.org/10.21105/joss.03900
#> year: '2021'
#> publisher:
#>   name: The Open Journal
#> volume: '6'
#> issue: '67'
#> journal: Journal of Open Source Software
#> start: '3900'
```
