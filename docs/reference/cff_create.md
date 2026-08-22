# Create a [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object from multiple sources

Create a full, possibly valid
[`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object from a
given source. This object can be written to a `CITATION.cff` file with
[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md).
See **Examples**.

This function performs most metadata extraction and conversion in
[cffr](https://CRAN.R-project.org/package=cffr).

## Usage

``` r
cff_create(
  x,
  keys = list(),
  cff_version = "1.2.0",
  gh_keywords = TRUE,
  dependencies = TRUE,
  authors_roles = c("aut", "cre")
)
```

## Arguments

- x:

  The source used to generate the
  [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object. It
  can be:

  - A missing value, which retrieves the `DESCRIPTION` file from your
    in-development R package.

  - An existing [`cff`](https://docs.ropensci.org/cffr/reference/cff.md)
    object.

  - The name of an installed package (`"jsonlite"`).

  - A path to a `DESCRIPTION` file (`"./DESCRIPTION"`).

- keys:

  A list of additional keys to add to the
  [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object. See
  [`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md).

- cff_version:

  The Citation File Format schema version used for the generated
  metadata.

- gh_keywords:

  A logical value. If `TRUE` and the package is hosted on GitHub, add
  the repository topics as keywords.

- dependencies:

  A logical value. If `TRUE`, add the package dependencies to the
  `references` CFF key.

- authors_roles:

  Roles to be considered as authors of the package when generating the
  `CITATION.cff` file. See **Details**.

## Value

A [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object.

## Details

If `x` is a path to a `DESCRIPTION` file or if `inst/CITATION` is not
present in your package, [cffr](https://CRAN.R-project.org/package=cffr)
auto-generates a `preferred-citation` key using the information provided
in that file.

By default, only persons whose role in the `DESCRIPTION` file of the
package is author (`"aut"`) or maintainer (`"cre"`) are considered
package authors. The default setting can be controlled with the
`authors_roles` argument. See **Details** on
[`utils::person()`](https://rdrr.io/r/utils/person.html) for additional
information about person roles.

## See also

[Citation File Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

- [`vignette("cffr", package = "cffr")`](https://docs.ropensci.org/cffr/articles/cffr.md)
  shows an introduction to manipulating
  [`cff`](https://docs.ropensci.org/cffr/reference/cff.md) objects.

- [`vignette("r-cff", package = "cffr")`](https://docs.ropensci.org/cffr/articles/r-cff.md)
  provides details on how the metadata of a package is mapped to produce
  a `cff` object.

Core [cffr](https://CRAN.R-project.org/package=cffr) workflow:
[`cff()`](https://docs.ropensci.org/cffr/reference/cff.md),
[`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md),
[`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md),
[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md)

## Examples

``` r
# \donttest{
# Installed package.
cff_create("jsonlite")
#> cff-version: 1.2.0
#> message: 'To cite package "jsonlite" in publications use:'
#> type: software
#> license: MIT
#> title: 'jsonlite: A Simple and Robust JSON Parser and Generator for R'
#> version: 2.0.0
#> identifiers:
#> - type: doi
#>   value: 10.32614/CRAN.package.jsonlite
#> - type: url
#>   value: https://arxiv.org/abs/1403.2805
#> abstract: A reasonably fast JSON parser and generator, optimized for statistical data
#>   and the web. Offers simple, flexible tools for working with JSON in R, and is particularly
#>   powerful for building pipelines and interacting with a web API. The implementation
#>   is based on the mapping described in the vignette (Ooms, 2014). In addition to converting
#>   JSON data from/to R objects, 'jsonlite' contains functions to stream, validate,
#>   and prettify JSON data. The unit tests included with the package verify that all
#>   edge cases are encoded and decoded consistently for use with dynamic data in systems
#>   and applications.
#> authors:
#> - family-names: Ooms
#>   given-names: Jeroen
#>   email: jeroenooms@gmail.com
#>   orcid: https://orcid.org/0000-0002-4035-0289
#> preferred-citation:
#>   type: article
#>   title: 'The jsonlite Package: A Practical and Consistent Mapping Between JSON Data
#>     and R Objects'
#>   authors:
#>   - family-names: Ooms
#>     given-names: Jeroen
#>     email: jeroenooms@gmail.com
#>     orcid: https://orcid.org/0000-0002-4035-0289
#>   journal: arXiv:1403.2805 [stat.CO]
#>   year: '2014'
#>   url: https://arxiv.org/abs/1403.2805
#> repository: https://CRAN.R-project.org/package=jsonlite
#> repository-code: https://github.com/jeroen/jsonlite
#> url: https://jeroen.r-universe.dev/jsonlite
#> date-released: '2025-03-27'
#> contact:
#> - family-names: Ooms
#>   given-names: Jeroen
#>   email: jeroenooms@gmail.com
#>   orcid: https://orcid.org/0000-0002-4035-0289
#> keywords:
#> - json
#> - parser
#> - r
#> - rstats
#> references:
#> - type: software
#>   title: methods
#>   abstract: 'R: A Language and Environment for Statistical Computing'
#>   notes: Depends
#>   authors:
#>   - name: R Core Team
#>     website: https://ror.org/02zz1nj61
#>   institution:
#>     name: R Foundation for Statistical Computing
#>     website: https://ror.org/05qewa988
#>     address: Vienna, Austria
#>   year: '2026'
#>   doi: 10.32614/R.manuals
#> - type: software
#>   title: httr
#>   abstract: 'httr: Tools for Working with URLs and HTTP'
#>   notes: Suggests
#>   url: https://httr.r-lib.org/
#>   repository: https://CRAN.R-project.org/package=httr
#>   authors:
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.httr
#> - type: software
#>   title: vctrs
#>   abstract: 'vctrs: Vector Helpers'
#>   notes: Suggests
#>   url: https://vctrs.r-lib.org/
#>   repository: https://CRAN.R-project.org/package=vctrs
#>   authors:
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   - family-names: Henry
#>     given-names: Lionel
#>     email: lionel@posit.co
#>   - family-names: Vaughan
#>     given-names: Davis
#>     email: davis@posit.co
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.vctrs
#> - type: software
#>   title: testthat
#>   abstract: 'testthat: Unit Testing for R'
#>   notes: Suggests
#>   url: https://testthat.r-lib.org
#>   repository: https://CRAN.R-project.org/package=testthat
#>   authors:
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.testthat
#> - type: software
#>   title: knitr
#>   abstract: 'knitr: A General-Purpose Package for Dynamic Report Generation in R'
#>   notes: Suggests
#>   url: https://yihui.org/knitr/
#>   repository: https://CRAN.R-project.org/package=knitr
#>   authors:
#>   - family-names: Xie
#>     given-names: Yihui
#>     email: xie@yihui.name
#>     orcid: https://orcid.org/0000-0003-0645-5666
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.knitr
#> - type: software
#>   title: rmarkdown
#>   abstract: 'rmarkdown: Dynamic Documents for R'
#>   notes: Suggests
#>   url: https://pkgs.rstudio.com/rmarkdown/
#>   repository: https://CRAN.R-project.org/package=rmarkdown
#>   authors:
#>   - family-names: Allaire
#>     given-names: JJ
#>     email: jj@posit.co
#>   - family-names: Xie
#>     given-names: Yihui
#>     email: xie@yihui.name
#>     orcid: https://orcid.org/0000-0003-0645-5666
#>   - family-names: Dervieux
#>     given-names: Christophe
#>     email: cderv@posit.co
#>     orcid: https://orcid.org/0000-0003-4474-2498
#>   - family-names: McPherson
#>     given-names: Jonathan
#>     email: jonathan@posit.co
#>   - family-names: Luraschi
#>     given-names: Javier
#>   - family-names: Ushey
#>     given-names: Kevin
#>     email: kevin@posit.co
#>   - family-names: Atkins
#>     given-names: Aron
#>     email: aron@posit.co
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   - family-names: Cheng
#>     given-names: Joe
#>     email: joe@posit.co
#>   - family-names: Chang
#>     given-names: Winston
#>     email: winston@posit.co
#>   - family-names: Iannone
#>     given-names: Richard
#>     email: rich@posit.co
#>     orcid: https://orcid.org/0000-0003-3925-190X
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.rmarkdown
#> - type: software
#>   title: sf
#>   abstract: 'sf: Simple Features for R'
#>   notes: Suggests
#>   url: https://r-spatial.github.io/sf/
#>   repository: https://CRAN.R-project.org/package=sf
#>   authors:
#>   - family-names: Pebesma
#>     given-names: Edzer
#>     email: edzer.pebesma@uni-muenster.de
#>     orcid: https://orcid.org/0000-0001-8049-7069
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.sf

# Demo file.
demo_file <- system.file("examples/DESCRIPTION_basic", package = "cffr")
cff_create(demo_file)
#> cff-version: 1.2.0
#> message: 'To cite package "basicdesc" in publications use:'
#> type: software
#> license: GPL-3.0-only
#> title: 'basicdesc: A Basic Description'
#> version: 0.1.6
#> abstract: A very basic description. Should parse without problems.
#> authors:
#> - family-names: Basic
#>   given-names: Marc
#>   email: marcbasic@gmail.com
#> repository-code: https://github.com/basic/package
#> url: https://basic.github.io/package
#> contact:
#> - family-names: Basic
#>   given-names: Marc
#>   email: marcbasic@gmail.com

# Add additional keys.

newkeys <- list(
  message = "This overwrites keys",
  abstract = "New abstract",
  keywords = c("A", "new", "list", "of", "keywords"),
  authors = as_cff_person("New author")
)

cff_create(demo_file, keys = newkeys)
#> cff-version: 1.2.0
#> message: This overwrites keys
#> type: software
#> license: GPL-3.0-only
#> title: 'basicdesc: A Basic Description'
#> version: 0.1.6
#> abstract: New abstract
#> authors:
#> - family-names: author
#>   given-names: New
#> repository-code: https://github.com/basic/package
#> url: https://basic.github.io/package
#> contact:
#> - family-names: Basic
#>   given-names: Marc
#>   email: marcbasic@gmail.com
#> keywords:
#> - A
#> - new
#> - list
#> - of
#> - keywords

# Update a key in a list, for example authors or contacts.
# Add a new contact.

old <- cff_create(demo_file)

new_contact <- append(
  old$contact,
  as_cff_person(person(
    given = "I am",
    family = "New Contact"
  ))
)

cff_create(demo_file, keys = list("contact" = new_contact))
#> cff-version: 1.2.0
#> message: 'To cite package "basicdesc" in publications use:'
#> type: software
#> license: GPL-3.0-only
#> title: 'basicdesc: A Basic Description'
#> version: 0.1.6
#> abstract: A very basic description. Should parse without problems.
#> authors:
#> - family-names: Basic
#>   given-names: Marc
#>   email: marcbasic@gmail.com
#> repository-code: https://github.com/basic/package
#> url: https://basic.github.io/package
#> contact:
#> - family-names: Basic
#>   given-names: Marc
#>   email: marcbasic@gmail.com
#> - family-names: New Contact
#>   given-names: I am
# }
```
