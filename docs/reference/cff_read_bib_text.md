# Read BibTeX markup as a [`cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md) object

Convert one or more complete BibTeX entries supplied as a `character`
vector into a
[`cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
object.

## Usage

``` r
cff_read_bib_text(x, encoding = "UTF-8", ...)
```

## Arguments

- x:

  A `character` vector with one or more complete BibTeX entries.

- encoding:

  Encoding to be assumed for `x`. See
  [`base::readLines()`](https://rdrr.io/r/base/readLines.html).

- ...:

  Arguments passed to
  [`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md).

## Value

An object of classes
[`cff_ref_lst, cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
according to the `definitions.reference` specified in the following
guide: [Citation File Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).
Each element of the `cff_ref_lst` object has classes
[`cff_ref, cff`](https://docs.ropensci.org/cffr/reference/cff_class.md).

## Details

This function writes `x` to a temporary `*.bib` file and reads it using
[`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md).

This function requires
[bibtex](https://CRAN.R-project.org/package=bibtex) (\>= 0.5.0) and uses
[`bibtex::read.bib()`](https://docs.ropensci.org/bibtex/reference/read.bib.html)
for parsing.

## See also

[`cff_read_bib()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
for reading `*.bib` files.

Work with BibTeX metadata:
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
[`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md),
[`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)

Read external citation metadata:
[`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md)

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
}
#> - type: book
#>   title: 'Relativity: The Special and the General Theory'
#>   authors:
#>   - family-names: Einstein
#>     given-names: Albert
#>   year: '1920'
#>   publisher:
#>     name: Henry Holt and Company
#>     address: London, United Kingdom
#>   isbn: '9781587340925'
#> - type: generic
#>   title: Handing out random pamphlets in airports
#>   authors:
#>   - family-names: Missilany
#>     given-names: Joe-Bob
#>   year: '1984'
#>   month: '10'
#>   notes: This is a full MISC entry
#>   medium: Handed out at O'Hare
```
