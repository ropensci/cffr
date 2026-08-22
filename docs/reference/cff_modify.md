# Modify a [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object

Add new keys to a
[`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object or
modify existing ones.

## Usage

``` r
cff_modify(x, ...)
```

## Arguments

- x:

  A [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object.

- ...:

  Named arguments used to modify `x`. See also the `...` argument in
  [`cff()`](https://docs.ropensci.org/cffr/reference/cff.md).

## Value

A [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object.

## Details

Keys provided in `...` override the corresponding key in `x`.

You can add additional keys not detected by
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
using the `keys` argument. A list of valid keys can be retrieved with
[`cff_schema_keys()`](https://docs.ropensci.org/cffr/reference/cff_schema.md).
See the following guide for additional details: [Citation File Format
schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

## See also

This function is a wrapper of
[`utils::modifyList()`](https://rdrr.io/r/utils/modifyList.html).

Core [cffr](https://CRAN.R-project.org/package=cffr) workflow:
[`cff()`](https://docs.ropensci.org/cffr/reference/cff.md),
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md),
[`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md),
[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)

## Examples

``` r
x <- cff()
x
#> cff-version: 1.2.0
#> message: If you use this software, please cite it using these metadata.
#> title: My Research Software
#> authors:
#> - family-names: Doe
#>   given-names: John

cff_validate(x)
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✔ This <cff> object is valid.

x_mod <- cff_modify(x,
  contact = as_cff_person("A contact"),
  message = "This overwrites keys",
  title = "New Title",
  abstract = "New abstract",
  doi = "10.21105/joss.03900"
)

x_mod
#> cff-version: 1.2.0
#> message: This overwrites keys
#> title: New Title
#> authors:
#> - family-names: Doe
#>   given-names: John
#> contact:
#> - family-names: contact
#>   given-names: A
#> abstract: New abstract
#> doi: 10.21105/joss.03900

cff_validate(x_mod)
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✔ This <cff> object is valid.
```
