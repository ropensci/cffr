# Previous API: parse a `person` to [`cff`](https://docs.ropensci.org/cffr/reference/cff.md)

**\[deprecated\]** Use
[`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md)
instead.

## Usage

``` r
cff_parse_person(person)

cff_parse_person_bibtex(person)
```

## Arguments

- person:

  It can be either:

  - A `person` object or list of `person` objects created with
    [`utils::person()`](https://rdrr.io/r/utils/person.html).

  - A `character` object or vector representing a person or persons.

## Value

A
[`cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
object.

## See also

[`as_cff_person()`](https://docs.ropensci.org/cffr/reference/as_cff_person.md).

Deprecated functions:
[`cff_extract_to_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_to_bib.md),
[`cff_from_bibtex()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_from_bib.md),
[`cff_parse_citation()`](https://docs.ropensci.org/cffr/reference/deprecated_cff_bibentry.md),
[`write_bib()`](https://docs.ropensci.org/cffr/reference/deprecated_write.md)

## Examples

``` r
# Create a person object.
a_person <- person(
  given = "First", family = "Author",
  role = c("aut", "cre"),
  email = "first.last@example.com", comment = c(
    ORCID = "0000-0001-8457-4658",
    affiliation = "An affiliation"
  )
)

a_person
#> [1] "First Author <first.last@example.com> [aut, cre] (ORCID: <https://orcid.org/0000-0001-8457-4658>, affiliation: An affiliation)"

cff_person <- as_cff_person(a_person)

cff_person
#> - family-names: Author
#>   given-names: First
#>   email: first.last@example.com
#>   orcid: https://orcid.org/0000-0001-8457-4658
#>   affiliation: An affiliation

# Back to person object with S3 method.
as.person(cff_person)
#> [1] "First Author <first.last@example.com> (ORCID: <https://orcid.org/0000-0001-8457-4658>, affiliation: An affiliation)"

# Parse a string.
a_str <- paste0(
  "Julio Iglesias <fake@email.com> ",
  "(<https://orcid.org/0000-0001-8457-4658>)"
)
as_cff_person(a_str)
#> - family-names: Iglesias
#>   given-names: Julio
#>   email: fake@email.com

# Several persons.
persons <- c(person("Clark", "Kent"), person("Lois", "Lane"))

as_cff_person(persons)
#> - family-names: Kent
#>   given-names: Clark
#> - family-names: Lane
#>   given-names: Lois

# Or use BibTeX style.

x <- "Frank Sinatra and Dean Martin and Davis, Jr., Sammy and Joey Bishop"

as_cff_person(x)
#> - family-names: Sinatra
#>   given-names: Frank
#> - family-names: Martin
#>   given-names: Dean
#> - family-names: Davis
#>   given-names: Sammy
#>   name-suffix: Jr.
#> - family-names: Bishop
#>   given-names: Joey

as_cff_person("Herbert von Karajan")
#> - family-names: Karajan
#>   given-names: Herbert
#>   name-particle: von
```
