# Create `cff` objects from direct inputs

A class and utility methods for reading, creating and storing CFF
information. See
[cff_class](https://docs.ropensci.org/cffr/reference/cff_class.md) to
learn more about `cff` objects.

## Usage

``` r
cff(path, ...)
```

## Arguments

- path:

  **\[deprecated\]** `path` is no longer supported, use
  [`cff_read_cff_citation()`](https://docs.ropensci.org/cffr/reference/cff_read.md)
  instead.

- ...:

  Named arguments to be used for creating a `cff` object. If no
  arguments are supplied (the default behavior), a minimal valid `cff`
  object is created.

## Value

A `cff` object. Under the hood, a `cff` object is a regular
[`base::list()`](https://rdrr.io/r/base/list.html) object with a special
[`print`](https://docs.ropensci.org/cffr/reference/cff_class.md) method.

## Details

`cff()` converts `_` in the argument name to `-`. For example,
`cff_version = "1.2.0"` is converted to `cff-version = "1.2.0"`.

Valid arguments are those specified on
[`cff_schema_keys()`](https://docs.ropensci.org/cffr/reference/cff_schema.md):

- `cff-version`

- `message`

- `type`

- `license`

- `title`

- `version`

- `doi`

- `identifiers`

- `abstract`

- `authors`

- `preferred-citation`

- `repository`

- `repository-artifact`

- `repository-code`

- `commit`

- `url`

- `date-released`

- `contact`

- `keywords`

- `references`

- `license-url`

## See also

Core [cffr](https://CRAN.R-project.org/package=cffr) workflow:
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md),
[`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md),
[`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md),
[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)

## Examples

``` r
# Blank `cff` object.
cff()
#> cff-version: 1.2.0
#> message: If you use this software, please cite it using these metadata.
#> title: My Research Software
#> authors:
#> - family-names: Doe
#>   given-names: John

# Use custom parameters.
test <- cff(
  title = "Manipulating files",
  keywords = c("A", "new", "list", "of", "keywords"),
  authors = as_cff_person("New author")
)
test
#> title: Manipulating files
#> keywords:
#> - A
#> - new
#> - list
#> - of
#> - keywords
#> authors:
#> - family-names: author
#>   given-names: New
# \donttest{
# This would fail.
cff_validate(test)
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✖ Validation failed. This <cff> object has the following errors:
#> * cff/: must have required property 'cff-version'
#> * cff/: must have required property 'message'
# }

# Modify with cff_create().
new <- cff_create(test, keys = list(
  "cff_version" = "1.2.0",
  message = "A blank file"
))
new
#> cff-version: 1.2.0
#> message: A blank file
#> title: Manipulating files
#> authors:
#> - family-names: author
#>   given-names: New
#> keywords:
#> - A
#> - new
#> - list
#> - of
#> - keywords

# This would pass.
cff_validate(new)
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✔ This <cff> object is valid.
```
