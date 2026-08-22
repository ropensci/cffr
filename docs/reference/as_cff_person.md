# Coerce R objects to [`cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md) objects

`as_cff_person()` turns an existing list-like R object into a
[`cff_pers_lst`](https://docs.ropensci.org/cffr/reference/cff_class.md)
object representing a list of `definitions.person` or
`definitions.entity`, as defined in the following guide: [Citation File
Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

`as_cff_person()` is an S3 generic, with methods for:

- `person`: Objects created with
  [`utils::person()`](https://rdrr.io/r/utils/person.html).

- `character`: Strings with the definition for one or more authors,
  using the standard BibTeX notation (see Markey, 2009) and related
  formats, such as the output of
  [`base::format()`](https://rdrr.io/r/base/format.html) for `person`
  objects (see
  [`format.person()`](https://rdrr.io/r/utils/person.html)).

- Default: Other inputs are first coerced with
  [`base::as.character()`](https://rdrr.io/r/base/character.html).

The inverse transformation (`cff_pers_lst` to `person`) can be done with
the methods
[`as.person.cff_pers()`](https://docs.ropensci.org/cffr/reference/cff_class.md)
and
[`as.person.cff_pers_lst()`](https://docs.ropensci.org/cffr/reference/cff_class.md).

## Usage

``` r
as_cff_person(x, ...)

# Default S3 method
as_cff_person(x, ...)

# S3 method for class 'person'
as_cff_person(x, ...)

# S3 method for class 'character'
as_cff_person(x, ...)
```

## Arguments

- x:

  Any R object.

- ...:

  Ignored by this method.

## Value

`as_cff_person()` returns an object of classes
[`cff_pers_lst, cff`](https://docs.ropensci.org/cffr/reference/cff_class.md)
according to the `definitions.person` or `definitions.entity` specified
in the following guide: [Citation File Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).
Each element of the `cff_pers_lst` object has classes
[`cff_pers, cff`](https://docs.ropensci.org/cffr/reference/cff_class.md).

## Details

`as_cff_person()` recognizes whether the input should be converted with
the CFF reference for `definitions.person` or `definitions.entity`.

`as_cff_person()` uses a custom algorithm that parses names as explained
in Section 11 of "Tame the BeaST" (Markey, 2009) (see also Decoret,
2007):

- `First von Last`.

- `von Last, First`.

- `von Last, Jr, First`.

Mapping is performed as follows:

- `First` is mapped to the CFF key `given-names`.

- `von` is mapped to the CFF key `name-particle`.

- `Last` is mapped to the CFF key `family-names`.

- `Jr` is mapped to the CFF key `name-suffix`.

For entities, the entire `character` is mapped to `name`. We recommend
"protecting" entity names with
[`{}`](https://rdrr.io/r/base/Paren.html):

    # Avoid unprotected entity names.
    entity <- "Elephant and Castle"
    as_cff_person(entity)
    - name: Elephant
    - name: Castle

    # Protect entity names with braces.
    entity_protect <- "{Elephant and Castle}"
    as_cff_person(entity_protect)
    - name: Elephant and Castle

`as_cff_person()` attempts to extract as much information as possible.
For `character` strings from
[`format.person()`](https://rdrr.io/r/utils/person.html), the email and
ORCID are also extracted.

## References

Patashnik O (1988). "BIBTEXing."
<https://osl.ugr.es/CTAN/biblio/bibtex/base/btxdoc.pdf>.

Markey N (2009). *Tame the BeaST: The B to X of BibTeX*.
<https://osl.ugr.es/CTAN/info/bibtex/tamethebeast/ttb_en.pdf>.

Decoret X (2007). "A summary of BibTeX."
<https://maverick.inria.fr/~Xavier.Decoret/resources/xdkbibtex/bibtex_summary.html#names>.

## See also

Examples in
[`vignette("cffr", package = "cffr")`](https://docs.ropensci.org/cffr/articles/cffr.md)
and [`utils::person()`](https://rdrr.io/r/utils/person.html). Learn more
about the `cff_pers_lst` and `cff_pers` classes in
[cff_class](https://docs.ropensci.org/cffr/reference/cff_class.md).

Convert between R classes:
[`as_bibentry()`](https://docs.ropensci.org/cffr/reference/as_bibentry.md),
[`as_cff()`](https://docs.ropensci.org/cffr/reference/as_cff.md),
[`cff_class`](https://docs.ropensci.org/cffr/reference/cff_class.md)

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

# Class cff_pers_lst / cff.
class(cff_person)
#> [1] "cff_pers_lst" "cff"         

# Each element has class cff_pers / cff.
class(cff_person[[1]])
#> [1] "cff_pers" "cff"     

# Print.
cff_person
#> - family-names: Author
#>   given-names: First
#>   email: first.last@example.com
#>   orcid: https://orcid.org/0000-0001-8457-4658
#>   affiliation: An affiliation

# Back to person object with S3 method.
as.person(cff_person)
#> [1] "First Author <first.last@example.com> (ORCID: <https://orcid.org/0000-0001-8457-4658>, affiliation: An affiliation)"

# Coerce a string.
a_str <- paste0(
  "Julio Iglesias <fake@email.com> ",
  "(city: Miami, region: California, country: US)"
)
as_cff_person(a_str)
#> - family-names: Iglesias
#>   given-names: Julio
#>   email: fake@email.com
#>   city: Miami
#>   region: California
#>   country: US

# Several persons.
persons <- c(
  person("Clark", "Kent", comment = c(affiliation = "Daily Planet")),
  person("Lois", "Lane"), person("Oscorp Inc.")
)

a_cff <- as_cff_person(persons)

a_cff
#> - family-names: Kent
#>   given-names: Clark
#>   affiliation: Daily Planet
#> - family-names: Lane
#>   given-names: Lois
#> - name: Oscorp Inc.

# Printed as BibTeX thanks to the method.
toBibtex(a_cff)
#> Kent, Clark and Lane, Lois and {Oscorp Inc.}

# Or as person object.
as.person(a_cff)
#> [1] "Clark Kent (affiliation: Daily Planet)"
#> [2] "Lois Lane"                             
#> [3] "Oscorp Inc."                           

# Or use BibTeX style as input.

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

toBibtex(as_cff_person("Herbert von Karajan"))
#> von Karajan, Herbert
```
