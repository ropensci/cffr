# Validate a `CITATION.cff` file or a [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object

Validate a `CITATION.cff` file or a
[`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object using
the corresponding [validation
schema](https://github.com/citation-file-format/citation-file-format/blob/main/schema.json).

## Usage

``` r
cff_validate(x = "CITATION.cff", verbose = TRUE)
```

## Arguments

- x:

  A full `cff` object created with
  [`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
  or the path to a `CITATION.cff` file to be validated. A `*.cff` file
  is read with
  [`cff_read_cff_citation()`](https://docs.ropensci.org/cffr/reference/cff_read.md).

- verbose:

  A logical value. If `TRUE`, the function displays informative
  messages.

## Value

Invisibly returns a logical value indicating the validation result. On
error, the result has an `"errors"` attribute with the error summary. If
`verbose` is `TRUE`, the function also displays the result. See
**Examples** and [`base::attr()`](https://rdrr.io/r/base/attr.html).

## See also

[`jsonvalidate::json_validate()`](https://docs.ropensci.org/jsonvalidate/reference/json_validate.html),
which is the function that performs the validation.

[Citation File Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

Core [cffr](https://CRAN.R-project.org/package=cffr) workflow:
[`cff()`](https://docs.ropensci.org/cffr/reference/cff.md),
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md),
[`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md),
[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)

## Examples

``` r
# \donttest{
# Full `.cff` example.
cff_validate(system.file("examples/CITATION_complete.cff", package = "cffr"))
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✔ C:/Users/diego/AppData/Local/R/win-library/4.6/cffr/examples/CITATION_complete.cff is valid.

# Validate a `cff` object.
cffr <- cff_create("jsonlite")
class(cffr)
#> [1] "cff"
cff_validate(cffr)
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✔ This <cff> object is valid.
# }

# `.cff` with errors.
err_f <- system.file("examples/CITATION_error.cff", package = "cffr")
# You can manipulate the errors as a data frame.
res <- try(cff_validate(err_f))
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✖ Validation failed. C:/Users/diego/AppData/Local/R/win-library/4.6/cffr/examples/CITATION_error.cff has the following errors:
#> * cff/: must NOT have additional properties
#> * cff/authors/0: must NOT have additional properties
#> * cff/authors/0/orcid: must match pattern "https://orcid\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
#> * cff/authors/0/orcid: must match format "uri"
#> * cff/authors/0: must have required property 'name'
#> * cff/authors/0: must NOT have additional properties
#> * cff/authors/0: must NOT have additional properties
#> * cff/authors/0: must NOT have additional properties
#> * cff/authors/0/orcid: must match pattern "https://orcid\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
#> * cff/authors/0/orcid: must match format "uri"
#> * cff/authors/0: must match a schema in anyOf
#> * cff/doi: must match pattern "^10\.\d{4,9}(\.\d+)?/[A-Za-z0-9:/_;\-\.\(\)\[\]\\]+$"
#> * cff/keywords/0: must be string
#> * cff/license: must be equal to one of the allowed values
#> * cff/license: must be array
#> * cff/license: must match exactly one schema in oneOf
#> * cff/url: must match pattern "^(https|http|ftp|sftp)://.+"
#> * cff/url: must match format "uri"

isTRUE(res)
#> [1] FALSE
isFALSE(res)
#> [1] TRUE

# Detailed results.
df_errors <- attr(res, "errors")

df_errors[, c("field", "message")]
#>                  field
#> 1                 cff/
#> 2        cff/authors/0
#> 3  cff/authors/0/orcid
#> 4  cff/authors/0/orcid
#> 5        cff/authors/0
#> 6        cff/authors/0
#> 7        cff/authors/0
#> 8        cff/authors/0
#> 9  cff/authors/0/orcid
#> 10 cff/authors/0/orcid
#> 11       cff/authors/0
#> 12             cff/doi
#> 13      cff/keywords/0
#> 14         cff/license
#> 15         cff/license
#> 16         cff/license
#> 17             cff/url
#> 18             cff/url
#>                                                                                  message
#> 1                                                    must NOT have additional properties
#> 2                                                    must NOT have additional properties
#> 3  must match pattern "https://orcid\\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
#> 4                                                                must match format "uri"
#> 5                                                     must have required property 'name'
#> 6                                                    must NOT have additional properties
#> 7                                                    must NOT have additional properties
#> 8                                                    must NOT have additional properties
#> 9  must match pattern "https://orcid\\.org/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]{1}"
#> 10                                                               must match format "uri"
#> 11                                                          must match a schema in anyOf
#> 12 must match pattern "^10\\.\\d{4,9}(\\.\\d+)?/[A-Za-z0-9:/_;\\-\\.\\(\\)\\[\\]\\\\]+$"
#> 13                                                                        must be string
#> 14                                            must be equal to one of the allowed values
#> 15                                                                         must be array
#> 16                                                must match exactly one schema in oneOf
#> 17                                      must match pattern "^(https|http|ftp|sftp)://.+"
#> 18                                                               must match format "uri"

# An R citation file is not a `.cff` file, so it throws an error.
try(cff_validate(system.file("CITATION", package = "cffr")))
#> Error in abort_if_not_cff(x) : 
#>   `x` is not a '*.cff' file.
```
