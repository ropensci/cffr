# Write a `CITATION.cff` file

`cff_write()` is the primary workflow for package development.

This function writes a `CITATION.cff` file for a given package. It wraps
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
to create the [`cff`](https://docs.ropensci.org/cffr/reference/cff.md)
object, then writes it to a YAML-formatted file in one command.

## Usage

``` r
cff_write(
  x,
  outfile = "CITATION.cff",
  keys = list(),
  cff_version = "1.2.0",
  gh_keywords = TRUE,
  r_citation = FALSE,
  dependencies = TRUE,
  validate = TRUE,
  verbose = TRUE,
  authors_roles = c("aut", "cre"),
  encoding = "UTF-8"
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

- outfile:

  The name and path of the `CITATION.cff` to be created.

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

- r_citation:

  A logical value. If `TRUE`, the R package citation (for example,
  `inst/CITATION`) is created or updated. **No backup copy is created**.
  For more control, use
  [`cff_write_citation()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md).

- dependencies:

  A logical value. If `TRUE`, add the package dependencies to the
  `references` CFF key.

- validate:

  A logical value. If `TRUE`, validate the new file with
  [`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md).

- verbose:

  A logical value. If `TRUE`, the function displays informative
  messages.

- authors_roles:

  Roles to be considered as authors of the package when generating the
  `CITATION.cff` file. See **Details**.

- encoding:

  The name of the encoding to be assumed. Default is `"UTF-8"`, but it
  can be any other value accepted by
  [`base::iconv()`](https://rdrr.io/r/base/iconv.html), such as
  `"ASCII//TRANSLIT"`.

## Value

Invisibly returns the generated
[`cff`](https://docs.ropensci.org/cffr/reference/cff.md) object. This
function is called primarily for its side effect of writing a
`CITATION.cff` file.

## Details

For details of `authors_roles`, see
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md).

When creating and writing a `CITATION.cff` for the first time, this
function adds the pattern `"^CITATION\.cff$"` to your `.Rbuildignore`
file.

## See also

[Citation File Format schema
guide](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md).

Core [cffr](https://CRAN.R-project.org/package=cffr) workflow:
[`cff()`](https://docs.ropensci.org/cffr/reference/cff.md),
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md),
[`cff_modify()`](https://docs.ropensci.org/cffr/reference/cff_modify.md),
[`cff_validate()`](https://docs.ropensci.org/cffr/reference/cff_validate.md)

Write citation metadata files:
[`cff_write_bib()`](https://docs.ropensci.org/cffr/reference/cff_write_misc.md)

## Examples

``` r
# \donttest{
tmpfile <- tempfile(fileext = ".cff")
cff_obj <- cff_write("jsonlite", outfile = tmpfile)
#> ✔ C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd4725b2633.cff generated.
#> ══ Validating CFF ══════════════════════════════════════════════════════════════
#> ✔ C:\Users\diego\AppData\Local\Temp\RtmpkXftNS\file6cd4725b2633.cff is valid.

cff_obj
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

# Force cleanup.
file.remove(tmpfile)
#> [1] TRUE
# }
```
