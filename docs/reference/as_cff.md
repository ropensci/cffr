# Coerce lists and citation objects to [`cff`](https://docs.ropensci.org/cffr/reference/cff.md)

`as_cff()` turns an existing list-like R object into a
[`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object, a list
with class `cff` and the corresponding
[subclass](https://docs.ropensci.org/cffr/reference/cff_class.md) when
applicable.

`as_cff()` is an S3 generic, with methods for:

- `person` objects as produced by
  [`utils::person()`](https://rdrr.io/r/utils/person.html).

- `bibentry` objects as produced by
  [`utils::bibentry()`](https://rdrr.io/r/utils/bibentry.html).

- `Bibtex` objects as produced by
  [`utils::toBibtex()`](https://rdrr.io/r/utils/toLatex.html).

- Default: Other inputs are first coerced with
  [`base::as.list()`](https://rdrr.io/r/base/list.html).

## Usage

``` r
as_cff(x, ...)

# Default S3 method
as_cff(x, ...)

# S3 method for class 'list'
as_cff(x, ...)

# S3 method for class 'person'
as_cff(x, ...)

# S3 method for class 'bibentry'
as_cff(x, ...)

# S3 method for class 'Bibtex'
as_cff(x, ...)
```

## Arguments

- x:

  A `person`, `bibentry` or other object that can be coerced to a list.

- ...:

  Additional arguments passed on to other methods.

## Value

- `as_cff.person()` returns an object with classes
  [`cff_pers_lst, cff`](https://docs.ropensci.org/cffr/reference/cff_class.md).

- `as_cff.bibentry()` and `as_cff.Bibtex()` return an object with
  classes
  [`cff_ref_lst, cff`](https://docs.ropensci.org/cffr/reference/cff_class.md).

- The remaining methods return an object of class `cff`. However, if `x`
  has a structure compatible with `definitions.person`,
  `definitions.entity` or `definitions.reference`, the object has the
  corresponding subclass.

Learn more about the [cffr](https://CRAN.R-project.org/package=cffr)
class system in
[cff_class](https://docs.ropensci.org/cffr/reference/cff_class.md).

## Details

For `as_cff.bibentry()` and `as_cff.Bibtex()`, see
[`vignette("bibtex-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/bibtex-cff.md)
to understand how the mapping is performed.

[`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
is preferred over `as_cff.person()` because it can handle `character`
inputs such as `"Davis, Jr., Sammy"`. For `person` objects both
functions behave similarly.

## See also

- [`cff()`](https://docs.ropensci.org/cffr/reference/cff.md) creates a
  full `cff` object from scratch.

- [`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md)
  modifies a `cff` object.

- [`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
  creates a `cff` object for an R package.

- [`cff_read()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  creates a `cff` object from an external file.

Convert between R classes:
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
[`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md),
[`cff_class`](https://docs.ropensci.org/cffr/reference/cff_class.md)

## Examples

``` r
# Convert a list to a `cff` object.
cffobj <- as_cff(list(
  "cff-version" = "1.2.0",
  title = "Manipulating files"
))

class(cffobj)
#> [1] "cff"

# Display the YAML representation.
cffobj
#> cff-version: 1.2.0
#> title: Manipulating files

# `bibentry` method.
a_cit <- citation("cffr")[[1]]

a_cit
#> Hernangómez D (2021). "cffr: Generate Citation File Format Metadata for
#> R Packages." _Journal of Open Source Software_, *6*(67), 3900.
#> doi:10.21105/joss.03900 <https://doi.org/10.21105/joss.03900>.
#> <https://doi.org/10.21105/joss.03900>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Article{hernangomez2021,
#>     doi = {10.21105/joss.03900},
#>     url = {https://doi.org/10.21105/joss.03900},
#>     year = {2021},
#>     publisher = {The Open Journal},
#>     volume = {6},
#>     number = {67},
#>     pages = {3900},
#>     author = {Diego Hernangómez},
#>     title = {{cffr}: Generate Citation File Format Metadata for {R} Packages},
#>     journal = {Journal of Open Source Software},
#>   }

as_cff(a_cit)
#> - type: article
#>   title: 'cffr: Generate Citation File Format Metadata for R Packages'
#>   authors:
#>   - family-names: Hernangómez
#>     given-names: Diego
#>   doi: 10.21105/joss.03900
#>   url: https://doi.org/10.21105/joss.03900
#>   year: '2021'
#>   publisher:
#>     name: The Open Journal
#>   volume: '6'
#>   issue: '67'
#>   journal: Journal of Open Source Software
#>   start: '3900'

# BibTeX method.
a_bib <- toBibtex(a_cit)

a_bib
#> @Article{hernangomez2021,
#>   doi = {10.21105/joss.03900},
#>   url = {https://doi.org/10.21105/joss.03900},
#>   year = {2021},
#>   publisher = {The Open Journal},
#>   volume = {6},
#>   number = {67},
#>   pages = {3900},
#>   author = {Diego Hernangómez},
#>   title = {{cffr}: Generate Citation File Format Metadata for {R} Packages},
#>   journal = {Journal of Open Source Software},
#> }

as_cff(a_cit)
#> - type: article
#>   title: 'cffr: Generate Citation File Format Metadata for R Packages'
#>   authors:
#>   - family-names: Hernangómez
#>     given-names: Diego
#>   doi: 10.21105/joss.03900
#>   url: https://doi.org/10.21105/joss.03900
#>   year: '2021'
#>   publisher:
#>     name: The Open Journal
#>   volume: '6'
#>   issue: '67'
#>   journal: Journal of Open Source Software
#>   start: '3900'
```
