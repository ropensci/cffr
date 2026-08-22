# Previous API: create BibTeX entries from multiple sources

**\[deprecated\]** Use
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md)
instead.

## Usage

``` r
cff_extract_to_bibtex(x, what = c("preferred", "references", "all"))

cff_to_bibtex(x, what = c("preferred", "references", "all"))
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

- what:

  Fields to extract from a full `cff` object. It can be:

  - `preferred`: Create a single entry with the main citation
    information of the package (key `preferred-citation`).

  - `references`: Extract all entries of the `references` key.

  - `all`: Extract both the `preferred-citation` and `references` keys.

  See
  [`vignette("r-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/r-cff.md).

## Value

See
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md).

## See also

Deprecated functions:
[`cff_from_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_from_bib.md),
[`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md),
[`cff_parse_person()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md),
[`write_bib()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)

## Examples

``` r
# \donttest{
# From a `cff` object.
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
# }
```
