# Previous API: parse a `bibentry` object to `cff`

**\[deprecated\]** Use the
[`as_cff.bibentry()`](https://docs.ropensci.org/cffr/reference/as_cff.md)
method instead.

## Usage

``` r
cff_parse_citation(bib)
```

## Arguments

- bib:

  A `bibentry` object.

## Value

A [`cff_ref_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
object.

## See also

[`as_cff.bibentry()`](https://docs.ropensci.org/cffr/reference/as_cff.md).

Deprecated functions:
[`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md),
[`cff_from_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_from_bib.md),
[`cff_parse_person()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_person.md),
[`write_bib()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)

## Examples

``` r
bib <- citation("base")
bib
#> To cite R in publications use:
#> 
#>   R Core Team (2026). _R: A Language and Environment for Statistical
#>   Computing_. R Foundation for Statistical Computing, Vienna, Austria.
#>   doi:10.32614/R.manuals <https://doi.org/10.32614/R.manuals>.
#>   <https://www.R-project.org/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {R: A Language and Environment for Statistical Computing},
#>     author = {{R Core Team}},
#>     organization = {R Foundation for Statistical Computing},
#>     address = {Vienna, Austria},
#>     year = {2026},
#>     doi = {10.32614/R.manuals},
#>     url = {https://www.R-project.org/},
#>   }
#> 
#> We have invested a lot of time and effort in creating R, please cite it
#> when using it for data analysis. See also 'citation("pkgname")' for
#> citing R packages.

# To cff.
bib_to_cff <- as_cff(bib)
bib_to_cff
#> - type: manual
#>   title: 'R: A Language and Environment for Statistical Computing'
#>   authors:
#>   - name: R Core Team
#>     website: https://ror.org/02zz1nj61
#>   institution:
#>     name: R Foundation for Statistical Computing
#>     website: https://ror.org/05qewa988
#>     address: Vienna, Austria
#>   year: '2026'
#>   doi: 10.32614/R.manuals
#>   url: https://www.R-project.org/
```
