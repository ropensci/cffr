# Previous API: create a [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object from BibTeX entries

**\[deprecated\]** Use either
[`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
or
[`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md).

## Usage

``` r
cff_from_bibtex(x, encoding = "UTF-8", ...)
```

## Arguments

- x:

  The source used to generate the
  [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object. It
  must be a `character` object indicating either:

  - The path to a BibTeX file.

  - A vector of characters with a complete BibTeX string. See
    **Examples**.

- encoding:

  Encoding to be assumed for `x`. See
  [`base::readLines()`](https://rdrr.io/r/base/readLines.html).

- ...:

  Arguments passed to
  [`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md).

## Value

A [`cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
object. See
[`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
for reading `*.bib` files and
[`cff_read_bib_text()`](https://docs.ropensci.org/cffr/reference/cff_read_bib_text.md)
for reading BibTeX entries supplied as a `character` vector.

## See also

Deprecated functions:
[`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md),
[`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md),
[`cff_parse_person()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md),
[`write_bib()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)

## Examples

``` r
if (requireNamespace("bibtex", quietly = TRUE)) {
  x <- c(
    "@book{einstein1921,
    title        = {Relativity: The Special and the General Theory},
    author       = {Einstein, Albert},
    year         = 1920,
    publisher    = {Henry Holt and Company},
    address      = {London, United Kingdom},
    isbn         = 9781587340925
}",
    "@misc{misc-full,
    title        = {Handing out random pamphlets in airports},
    author       = {Joe-Bob Missilany},
    year         = 1984,
    month        = oct,
    note         = {This is a full MISC entry},
    howpublished = {Handed out at O'Hare}
}"
  )

  cff_read_bib_text(x)

  # From a file.

  x2 <- system.file("examples/example.bib", package = "cffr")
  cff_read_bib(x2)
}
#> - type: generic
#>   title: Citation File Format
#>   authors:
#>   - family-names: Druskat
#>     given-names: Stephan
#>   - family-names: Spaaks
#>     given-names: Jurriaan H.
#>   - family-names: Chue Hong
#>     given-names: Neil
#>   - family-names: Haines
#>     given-names: Robert
#>   - family-names: Baker
#>     given-names: James
#>   - family-names: Bliven
#>     given-names: Spencer
#>   - family-names: Willighagen
#>     given-names: Egon
#>   - family-names: Pérez-Suárez
#>     given-names: David
#>   - family-names: Konovalov
#>     given-names: Alexander
#>   year: '2021'
#>   month: '8'
#>   doi: 10.5281/zenodo.5171937
#>   url: https://github.com/citation-file-format/citation-file-format
#>   date-accessed: '2021-11-07'
#>   copyright: CC-BY-4.0
#>   abstract: The Citation File Format lets you provide citation metadata for software
#>     or datasets in plaintext files that are easy to read by both humans and machines.
#> - type: article
#>   title: 'cffr: Generate Citation File Format Metadata for R Packages'
#>   authors:
#>   - family-names: Hernangómez
#>     given-names: Diego
#>   year: '2021'
#>   journal: Journal of Open Source Software
#>   publisher:
#>     name: The Open Journal
#>   volume: '6'
#>   issue: '67'
#>   doi: 10.21105/joss.03900
#>   url: https://doi.org/10.21105/joss.03900
#>   copyright: All rights reserved
#>   notes: 'Publisher: The Open Journal'
#>   start: '3900'
```
