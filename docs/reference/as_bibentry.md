# Create [`bibentry`](https://rdrr.io/r/utils/bibentry.html) objects from multiple sources

This function creates
[`bibentry`](https://rdrr.io/r/utils/bibentry.html) objects from
multiple metadata sources
([`cff`](https://docs.ropensci.org/cffr/reference/cff.md) objects,
`DESCRIPTION` files and other sources). The inverse transformation
(`bibentry` object to
[`cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md))
can be done with the corresponding
[`as_cff.bibentry()`](https://docs.ropensci.org/cffr/reference/as_cff.md)
method.

With
[`toBibtex()`](https://docs.ropensci.org/cffr/reference/cff_class.md),
you can convert [`cff`](https://docs.ropensci.org/cffr/reference/cff.md)
objects to BibTeX markup on the fly. See **Examples**.

## Usage

``` r
as_bibentry(x, ...)

# Default S3 method
as_bibentry(x, ...)

# S3 method for class 'character'
as_bibentry(x, ..., what = c("preferred", "references", "all"))

# S3 method for class '`NULL`'
as_bibentry(x, ...)

# S3 method for class 'list'
as_bibentry(x, ...)

# S3 method for class 'cff'
as_bibentry(x, ..., what = c("preferred", "references", "all"))

# S3 method for class 'cff_ref_lst'
as_bibentry(x, ...)

# S3 method for class 'cff_ref'
as_bibentry(x, ...)
```

## Arguments

- x:

  The source used to generate the `bibentry` object with
  [cffr](https://CRAN.R-project.org/package=cffr). It can be:

  - A missing value, which retrieves the `DESCRIPTION` file from your
    in-development package.

  - An existing `cff` object created with
    [`cff()`](https://docs.ropensci.org/cffr/reference/cff.md),
    [`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
    or [`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md).

  - A path to a `CITATION.cff` file (`"CITATION.cff"`).

  - The name of an installed package (`"jsonlite"`).

  - A path to a `DESCRIPTION` file (`"DESCRIPTION"`).

- ...:

  Additional arguments passed to or from methods.

- what:

  Fields to extract from a full `cff` object. It can be:

  - `preferred`: Create a single entry with the main citation
    information of the package (key `preferred-citation`).

  - `references`: Extract all entries of the `references` key.

  - `all`: Extract both the `preferred-citation` and `references` keys.

  See
  [`vignette("r-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/r-cff.md).

## Value

`as_bibentry()` returns a `bibentry` object with one or more entries.

## Details

An R `bibentry` object is the representation of a BibTeX entry. These
objects can be converted to BibTeX markup with
[`utils::toBibtex()`](https://rdrr.io/r/utils/toLatex.html), which
creates an object of class `Bibtex` that can be printed and exported as
a valid BibTeX entry.

`as_bibentry()` tries to map the information of the source `x` into a
[`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object and
performs a mapping of the metadata to BibTeX, according to
[`vignette("bibtex-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/bibtex-cff.md).

## References

Patashnik O (1988). "BIBTEXing."
<https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.

Haines R, The Ruby Citation File Format Developers (2022). "Ruby CFF
Library."
[doi:10.5281/zenodo.7294987](https://doi.org/10.5281/zenodo.7294987) .
<https://github.com/citation-file-format/ruby-cff>.

Hernangómez D (2022). "BibTeX and CFF, a potential crosswalk."
[cffr](https://CRAN.R-project.org/package=cffr) vignette.
<https://docs.ropensci.org/cffr/articles/bibtex-cff.html>.

## See also

- [`utils::bibentry()`](https://rdrr.io/r/utils/bibentry.html) documents
  the `bibentry` class.

- [`vignette("r-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/r-cff.md)
  explains how the metadata of a package is mapped to produce a `cff`
  object.

- [`vignette("bibtex-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/bibtex-cff.md)
  provides details about the internal mapping performed between `cff`
  objects and BibTeX markup, both `cff` to BibTeX and BibTeX to `cff`.

- [`utils::toBibtex()`](https://rdrr.io/r/utils/toLatex.html) converts
  `bibentry` objects to BibTeX markup.

Work with BibTeX metadata:
[`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md),
[`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md),
[`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)

Convert between R classes:
[`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md),
[`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md),
[`cff_class`](https://docs.ropensci.org/cffr/reference/cff_class.md)

## Examples

``` r
# \donttest{
# From a `cff` object ----
cff_object <- cff()

cff_object
#> cff-version: 1.2.0
#> message: If you use this software, please cite it using these metadata.
#> title: My Research Software
#> authors:
#> - family-names: Doe
#>   given-names: John

# A bibentry object.
bib <- as_bibentry(cff_object)

class(bib)
#> [1] "bibentry"

bib
#> Doe J (????). "My Research Software."

# Print as BibTeX.
toBibtex(bib)
#> @Misc{doe,
#>   title = {My Research Software},
#>   author = {John Doe},
#> }

# Thanks to the S3 method, you can also do this.
toBibtex(cff_object)
#> @Misc{doe,
#>   title = {My Research Software},
#>   author = {John Doe},
#> }

# Other sources ----
# From a CITATION.cff.

path <- system.file("examples/CITATION_complete.cff", package = "cffr")
cff_file <- as_bibentry(path)

cff_file
#> van der Real Person, IV O, Entity Project Team Conference entity
#> (2017). "Book Title." In van der Real Person, IV O, Entity Project Team
#> Conference entity (eds.), volume 2 number 123 series Collection Title,
#> chapter Chapter 2 - "Reference keys", 123-456, 2nd edition edition.
#> Entity Project Team Conference entity, 22 Acacia Avenue, Citationburgh,
#> Renfrewshire, GB. ISBN 978-1-89183-044-0. doi:10.5281/zenodo.1003150
#> <https://doi.org/10.5281/zenodo.1003150>. A field for general notes
#> about the reference, usable in other formats such as BibTeX.,
#> <http://j.mp>.

# For an installed package with options.
installed_package <- as_bibentry("jsonvalidate", what = "all")

installed_package
#> FitzJohn R, Ashton R, Buus M, Poberezkin E (2025). "jsonvalidate:
#> Validate 'JSON' Schema." doi:10.32614/CRAN.package.jsonvalidate
#> <https://doi.org/10.32614/CRAN.package.jsonvalidate>.
#> <https://docs.ropensci.org/jsonvalidate/>.
#> 
#> Chang W (2026). "R6." doi:10.32614/CRAN.package.R6
#> <https://doi.org/10.32614/CRAN.package.R6>. Imports,
#> <https://r6.r-lib.org>.
#> 
#> Ooms J (2026). "V8." doi:10.32614/CRAN.package.V8
#> <https://doi.org/10.32614/CRAN.package.V8>. Imports,
#> <https://jeroen.r-universe.dev/V8>.
#> 
#> Xie Y (2026). "knitr." doi:10.32614/CRAN.package.knitr
#> <https://doi.org/10.32614/CRAN.package.knitr>. Suggests,
#> <https://yihui.org/knitr/>.
#> 
#> Ooms J (2026). "jsonlite." doi:10.32614/CRAN.package.jsonlite
#> <https://doi.org/10.32614/CRAN.package.jsonlite>. Suggests,
#> <https://jeroen.r-universe.dev/jsonlite>.
#> 
#> Allaire J, Xie Y, Dervieux C, McPherson J, Luraschi J, Ushey K, Atkins
#> A, Wickham H, Cheng J, Chang W, Iannone R (2026). "rmarkdown."
#> doi:10.32614/CRAN.package.rmarkdown
#> <https://doi.org/10.32614/CRAN.package.rmarkdown>. Suggests,
#> <https://pkgs.rstudio.com/rmarkdown/>.
#> 
#> Wickham H (2026). "testthat." doi:10.32614/CRAN.package.testthat
#> <https://doi.org/10.32614/CRAN.package.testthat>. Suggests,
#> <https://testthat.r-lib.org>.
#> 
#> Hester J, Henry L, Müller K, Ushey K, Wickham H, Chang W (2026).
#> "withr." doi:10.32614/CRAN.package.withr
#> <https://doi.org/10.32614/CRAN.package.withr>. Suggests,
#> <https://withr.r-lib.org>.

# Use a DESCRIPTION file.
path2 <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")
desc_file <- as_bibentry(path2)

toBibtex(desc_file)
#> @Misc{boettiger_etall,
#>   title = {codemetar: Generate 'CodeMeta' Metadata for R Packages},
#>   author = {Carl Boettiger and Maëlle Salmon},
#>   doi = {10.32614/CRAN.package.codemetar},
#>   url = {https://ropensci.github.io/codemetar},
#>   abstract = {The 'Codemeta' Project defines a 'JSON-LD' format for describing software metadata, as detailed at <https://codemeta.github.io>. This package provides utilities to generate, parse, and modify 'codemeta.json' files automatically for R packages, as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.},
#>   keywords = {metadata,codemeta,ropensci,citation,credit,linked-data},
#>   version = {0.1.6},
#> }
# }
```
