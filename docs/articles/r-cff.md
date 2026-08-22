# From R to CFF

This vignette provides an explicit map between the metadata sources used
by **cffr** and each valid key in the [Citation File Format schema
version
1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#valid-keys).

## Summary

This section summarizes the keys that **cffr** can populate and the
metadata source for each one. Details for each key are presented in the
next section. The assessment is based on the [Guide to Citation File
Format schema version
1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#valid-keys)
([Druskat et al. 2021](#ref-druskat_citation_2021)).

| key                                         | source                        |
|:--------------------------------------------|:------------------------------|
| [abstract](#abstract)                       | DESCRIPTION file              |
| [authors](#authors)                         | DESCRIPTION file              |
| [cff-version](#cff-version)                 | function argument             |
| [commit](#commit)                           | DESCRIPTION file              |
| [contact](#contact)                         | DESCRIPTION file              |
| [date-released](#date-released)             | DESCRIPTION file              |
| [doi](#doi)                                 | inst/CITATION                 |
| [identifiers](#identifiers)                 | DESCRIPTION and inst/CITATION |
| [keywords](#keywords)                       | DESCRIPTION file              |
| [license](#license)                         | DESCRIPTION file              |
| [license-url](#license-url)                 | Ignored by cffr               |
| [message](#message)                         | DESCRIPTION file              |
| [preferred-citation](#preferred-citation)   | inst/CITATION                 |
| [references](#references)                   | DESCRIPTION and inst/CITATION |
| [repository](#repository)                   | DESCRIPTION file              |
| [repository-artifact](#repository-artifact) | Ignored by cffr               |
| [repository-code](#repository-code)         | DESCRIPTION file              |
| [title](#title)                             | DESCRIPTION file              |
| [type](#type)                               | Fixed value: ‘software’       |
| [url](#url)                                 | DESCRIPTION file              |
| [version](#version)                         | DESCRIPTION file              |

Table 1: cffr and R packages: Conversion table

## Details

### abstract

This key is extracted from the `"Description"` field of the
`DESCRIPTION` file.

**Example**

``` r

library(cffr)

# Create a `cff` object for YAML.

cff_obj <- cff_create("rmarkdown")

# Get the DESCRIPTION of **rmarkdown** to check.

pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cat(cff_obj$abstract)
#> Convert R Markdown documents into a variety of formats.

cat(pkg$get("Description"))
#> Convert R Markdown documents into a variety of formats.
```

Back to [Table 1](#tbl-summary).

### authors

This key is coerced from the `"Authors"` or `"Authors@R"` field of the
`DESCRIPTION` file. By default, persons with the role `"aut"` or `"cre"`
are considered, but this can be modified with the `authors_roles`
argument.

**Example**

``` r

# An example DESCRIPTION.
path <- system.file("examples/DESCRIPTION_many_persons", package = "cffr")
pkg <- desc::desc(path)

# See the listed persons.
pkg$get_authors()
#> [1] "Diego Hernangómez <fake@gmail.com> [aut, cre] (ORCID: <https://orcid.org/0000-0001-8457-4658>, email: error, not-valid: error)"
#> [2] "Joe Doe <I am a wrong email> [aut] (affiliation: This One, country: ES, date-end: error)"                                      
#> [3] "Pepe Doe <fake@gmail.com> [aut] (error)"                                                                                       
#> [4] "I am an entity [cre] (date-end: 2020-01-01, affiliation: error)"                                                               
#> [5] "ERROR entity [cph] (for the administrative boundaries.)"                                                                       
#> [6] "ERROR person [cph] (ORCID: <https://orcid.org/0000-0003-2042-7063>, for the gisco_countrycode dataset.)"

# Default behavior: use authors and creators (maintainers).
cff_obj <- cff_create(path)
cff_obj$authors
#> - family-names: Hernangómez
#>   given-names: Diego
#>   email: fake@gmail.com
#>   orcid: https://orcid.org/0000-0001-8457-4658
#> - family-names: Doe
#>   given-names: Joe
#>   affiliation: This One
#>   country: ES
#> - family-names: Doe
#>   given-names: Pepe
#>   email: fake@gmail.com
#> - name: I am an entity
#>   date-end: '2020-01-01'

# Use copyright holders and maintainers.
cff_obj_alt <- cff_create(path, authors_roles = c("cre", "cph"))
cff_obj_alt$authors
#> - family-names: Hernangómez
#>   given-names: Diego
#>   email: fake@gmail.com
#>   orcid: https://orcid.org/0000-0001-8457-4658
#> - name: I am an entity
#>   date-end: '2020-01-01'
#> - name: ERROR entity
#> - family-names: person
#>   given-names: ERROR
#>   orcid: https://orcid.org/0000-0003-2042-7063
```

Back to [Table 1](#tbl-summary).

### cff-version

Set this key with the `cff_version` argument of
[`cff_create()`](https://docs.ropensci.org/cffr/reference/cff_create.md)
or
[`cff_write()`](https://docs.ropensci.org/cffr/reference/cff_write.md):

**Example**

``` r

cff_objv110 <- cff_create("jsonlite", cff_version = "v1.1.0")

cat(cff_objv110$`cff-version`)
#> v1.1.0
```

Back to [Table 1](#tbl-summary).

### commit

This key is extracted from the `"RemoteSha"` field of the `DESCRIPTION`
file. This field is present in packages installed from
[r-universe](https://r-universe.dev/search) or with packages such as
**remotes** and **pak**.

**Example**

``` r

# An example DESCRIPTION.
path <- system.file("examples/DESCRIPTION_r_universe", package = "cffr")
pkg <- desc::desc(path)

# See `RemoteSha`.
pkg$get("RemoteSha")
#>                                  RemoteSha 
#> "bdd9a29d7eabcc43c3195fe461f884932eba763c"

cff_read(path)
#> cff-version: 1.2.0
#> message: 'To cite package "codemetar" in publications use:'
#> type: software
#> title: 'codemetar: Generate ''CodeMeta'' Metadata for R Packages'
#> version: 0.3.5
#> authors:
#> - family-names: Boettiger
#>   given-names: Carl
#>   email: cboettig@gmail.com
#>   orcid: https://orcid.org/0000-0002-1642-628X
#> - family-names: Salmon
#>   given-names: Maëlle
#>   orcid: https://orcid.org/0000-0002-2815-0399
#> abstract: The 'Codemeta' Project defines a 'JSON-LD' format for describing software
#>   metadata, as detailed at <https://codemeta.github.io>. This package provides utilities
#>   to generate, parse, and modify 'codemeta.json' files automatically for R packages,
#>   as well as tools and examples for working with 'codemeta.json' 'JSON-LD' more generally.
#> repository: https://ropensci.r-universe.dev
#> repository-code: https://github.com/ropensci/codemetar
#> url: https://docs.ropensci.org/codemetar/
#> date-released: '2024-02-09'
#> contact:
#> - family-names: Boettiger
#>   given-names: Carl
#>   email: cboettig@gmail.com
#>   orcid: https://orcid.org/0000-0002-1642-628X
#> keywords:
#> - metadata
#> - codemeta
#> - ropensci
#> - citation
#> - credit
#> - linked-data
#> - json-ld
#> - peer-reviewed
#> - r
#> - r-package
#> - rstats
#> license: GPL-3.0-only
#> commit: bdd9a29d7eabcc43c3195fe461f884932eba763c
#> doi: 10.32614/CRAN.package.codemetar
```

Back to [Table 1](#tbl-summary).

### contact

This key is coerced from the `"Authors"` or `"Authors@R"` field of the
`DESCRIPTION` file. Only persons with the role `"cre"` (that is,
maintainers) are considered.

**Example**

``` r

cff_obj <- cff_create("rmarkdown")
pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cff_obj$contact
#> - family-names: Xie
#>   given-names: Yihui
#>   email: xie@yihui.name
#>   orcid: https://orcid.org/0000-0003-0645-5666

pkg$get_author()
#> [1] "Yihui Xie <xie@yihui.name> [aut, cre] (ORCID: <https://orcid.org/0000-0003-0645-5666>)"
```

Back to [Table 1](#tbl-summary).

### date-released

This key is extracted from the `DESCRIPTION` file using this logic:

- `"Date"`, when present.
- Otherwise, `"Date/Publication"`. This field is present in packages
  built on **CRAN** and **Bioconductor**.
- Otherwise, `"Packaged"`, which is present in packages built by
  [r-universe](https://r-universe.dev/search).

**Example**

``` r

# Use an installed package.

cff_obj <- cff_create("rmarkdown")
pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cat(pkg$get("Date/Publication"))
#> 2026-03-26 16:30:02 UTC

cat(cff_obj$`date-released`)
#> 2026-03-26

# A DESCRIPTION file without a `Date`.
nodate <- system.file("examples/DESCRIPTION_basic", package = "cffr")
tmp <- tempfile("DESCRIPTION")

# Create a temporary file.
file.copy(nodate, tmp)
#> [1] TRUE

pkgnodate <- desc::desc(tmp)
cffnodate <- cff_create(tmp)

# No value is returned.
cat(cffnodate$`date-released`)

pkgnodate
#> Type: Package
#> Package: basicdesc
#> Title: A Basic Description
#> Version: 0.1.6
#> Authors@R (parsed):
#>     * Marc Basic <marcbasic@gmail.com> [aut, cre, cph]
#> Description: A very basic description. Should parse without problems.
#> License: GPL-3
#> URL: https://github.com/basic/package, https://basic.github.io/package
#> BugReports: https://github.com/basic/package/issues
#> Encoding: UTF-8
#> LazyData: true
#> RoxygenNote: 6.0.1.9000

# Add a `Date`.

desc::desc_set("Date", "1999-01-01", file = tmp)
#> Type: Package
#> Package: basicdesc
#> Title: A Basic Description
#> Version: 0.1.6
#> Date: 1999-01-01
#> Authors@R (parsed):
#>     * Marc Basic <marcbasic@gmail.com> [aut, cre, cph]
#> Description: A very basic description. Should parse without problems.
#> License: GPL-3
#> URL: https://github.com/basic/package, https://basic.github.io/package
#> BugReports: https://github.com/basic/package/issues
#> Encoding: UTF-8
#> LazyData: true
#> RoxygenNote: 6.0.1.9000

cat(cff_create(tmp)$`date-released`)
#> 1999-01-01
```

Back to [Table 1](#tbl-summary).

### doi

This key is coerced from the `"doi"` field of the
[preferred-citation](#preferred-citation) object. If not present and the
package is on **CRAN**, it is populated with the DOI provided by
**CRAN** (for example, <https://doi.org/10.32614/CRAN.package.cffr>).

**Example**

``` r

cff_doi <- cff_create("cffr")

cat(cff_doi$doi)
#> 10.21105/joss.03900

cat(cff_doi$`preferred-citation`$doi)
#> 10.21105/joss.03900
```

Back to [Table 1](#tbl-summary).

### identifiers

This key contains the available package identifiers:

- From the `DESCRIPTION` field, it includes all the URLs not included in
  [url](#url) or [repository-code](#repository-code).
- From the `CITATION` file, it includes all the DOIs not included in
  [doi](#doi) and the identifiers (if any) not included in the
  `"identifiers"` key of [preferred-citation](#preferred-citation).
- If the package is on **CRAN** and it has a `CITATION` file providing a
  DOI, the DOI provided by **CRAN** is added as well.

**Example**

``` r

file <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

pkg <- desc::desc(file)

cat(pkg$get_urls())
#> https://github.com/test/package https://test.github.io/package/ https://r-forge.r-project.org/projects/test/ http://google.ru https://gitlab.com/r-packages/behaviorchange

cat(cff_create(file)$url)
#> https://test.github.io/package/

cat(cff_create(file)$`repository-code`)
#> https://github.com/test/package

cff_create(file)$identifiers
#> - type: url
#>   value: https://r-forge.r-project.org/projects/test/
#> - type: url
#>   value: http://google.ru
#> - type: url
#>   value: https://gitlab.com/r-packages/behaviorchange
```

Back to [Table 1](#tbl-summary).

### keywords

This key is extracted from the `DESCRIPTION` file. The keywords should
appear in the `DESCRIPTION` as:

    ...
    X-schema.org-keywords: keyword1, keyword2, keyword3

**Example**

``` r

# A DESCRIPTION file without keywords
nokeywords <- system.file("examples/DESCRIPTION_basic", package = "cffr")
tmp2 <- tempfile("DESCRIPTION")

# Create a temporary file.
file.copy(nokeywords, tmp2)
#> [1] TRUE

pkgnokeywords <- desc::desc(tmp2)
cffnokeywords <- cff_create(tmp2)

# No value is returned.
cat(cffnokeywords$keywords)

pkgnokeywords
#> Type: Package
#> Package: basicdesc
#> Title: A Basic Description
#> Version: 0.1.6
#> Authors@R (parsed):
#>     * Marc Basic <marcbasic@gmail.com> [aut, cre, cph]
#> Description: A very basic description. Should parse without problems.
#> License: GPL-3
#> URL: https://github.com/basic/package, https://basic.github.io/package
#> BugReports: https://github.com/basic/package/issues
#> Encoding: UTF-8
#> LazyData: true
#> RoxygenNote: 6.0.1.9000

# Add keywords.

desc::desc_set(
  "X-schema.org-keywords",
  "keyword1, keyword2, keyword3",
  file = tmp2
)
#> Type: Package
#> Package: basicdesc
#> Title: A Basic Description
#> Version: 0.1.6
#> Authors@R (parsed):
#>     * Marc Basic <marcbasic@gmail.com> [aut, cre, cph]
#> Description: A very basic description. Should parse without problems.
#> License: GPL-3
#> URL: https://github.com/basic/package, https://basic.github.io/package
#> BugReports: https://github.com/basic/package/issues
#> Encoding: UTF-8
#> LazyData: true
#> RoxygenNote: 6.0.1.9000
#> X-schema.org-keywords: keyword1, keyword2, keyword3

cat(cff_create(tmp2)$keywords)
#> keyword1 keyword2 keyword3
```

If the package source code is hosted on GitHub, **cffr** can also
retrieve the topics of the repository with the [GitHub
API](https://docs.github.com/en/rest) and include those topics as
keywords. This option is controlled with the `gh_keywords` argument:

**Example**

``` r

# Get a `cff` object from **jsonvalidate**.

jsonval <- cff_create("jsonvalidate")

# Keywords are retrieved from the GitHub repository.

jsonval
#> cff-version: 1.2.0
#> message: 'To cite package "jsonvalidate" in publications use:'
#> type: software
#> license: MIT
#> title: 'jsonvalidate: Validate ''JSON'' Schema'
#> version: 1.5.0
#> doi: 10.32614/CRAN.package.jsonvalidate
#> abstract: Uses the node library 'is-my-json-valid' or 'ajv' to validate 'JSON' against
#>   a 'JSON' schema. Drafts 04, 06 and 07 of 'JSON' schema are supported.
#> authors:
#> - family-names: FitzJohn
#>   given-names: Rich
#>   email: rich.fitzjohn@gmail.com
#> - family-names: Ashton
#>   given-names: Rob
#> - family-names: Buus
#>   given-names: Mathias
#> - family-names: Poberezkin
#>   given-names: Evgeny
#> repository: https://CRAN.R-project.org/package=jsonvalidate
#> repository-code: https://github.com/ropensci/jsonvalidate
#> url: https://docs.ropensci.org/jsonvalidate/
#> date-released: '2025-02-07'
#> contact:
#> - family-names: FitzJohn
#>   given-names: Rich
#>   email: rich.fitzjohn@gmail.com
#> keywords:
#> - json
#> - json-validation
#> - jsonvalidate
#> - r
#> - r-package
#> - rstats
#> references:
#> - type: software
#>   title: R6
#>   abstract: 'R6: Encapsulated Classes with Reference Semantics'
#>   notes: Imports
#>   url: https://r6.r-lib.org
#>   repository: https://CRAN.R-project.org/package=R6
#>   authors:
#>   - family-names: Chang
#>     given-names: Winston
#>     email: winston@posit.co
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.R6
#> - type: software
#>   title: V8
#>   abstract: 'V8: Embedded JavaScript and WebAssembly Engine for R'
#>   notes: Imports
#>   url: https://jeroen.r-universe.dev/V8
#>   repository: https://CRAN.R-project.org/package=V8
#>   authors:
#>   - family-names: Ooms
#>     given-names: Jeroen
#>     email: jeroenooms@gmail.com
#>     orcid: https://orcid.org/0000-0002-4035-0289
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.V8
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
#>   title: jsonlite
#>   abstract: 'jsonlite: A Simple and Robust JSON Parser and Generator for R'
#>   notes: Suggests
#>   url: https://jeroen.r-universe.dev/jsonlite
#>   repository: https://CRAN.R-project.org/package=jsonlite
#>   authors:
#>   - family-names: Ooms
#>     given-names: Jeroen
#>     email: jeroenooms@gmail.com
#>     orcid: https://orcid.org/0000-0002-4035-0289
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.jsonlite
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
#>   title: withr
#>   abstract: 'withr: Run Code ''With'' Temporarily Modified Global State'
#>   notes: Suggests
#>   url: https://withr.r-lib.org
#>   repository: https://CRAN.R-project.org/package=withr
#>   authors:
#>   - family-names: Hester
#>     given-names: Jim
#>   - family-names: Henry
#>     given-names: Lionel
#>     email: lionel@posit.co
#>   - family-names: Müller
#>     given-names: Kirill
#>     email: krlmlr+r@mailbox.org
#>   - family-names: Ushey
#>     given-names: Kevin
#>     email: kevinushey@gmail.com
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   - family-names: Chang
#>     given-names: Winston
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.withr

# Check keywords.
jsonval$keywords
#> [1] "json"            "json-validation" "jsonvalidate"    "r"              
#> [5] "r-package"       "rstats"

# The repository.
jsonval$`repository-code`
#> [1] "https://github.com/ropensci/jsonvalidate"
```

Back to [Table 1](#tbl-summary).

### license

This key is extracted from the `"License"` field of the `DESCRIPTION`
file.

**Example**

``` r

cff_obj <- cff_create("yaml")

cat(cff_obj$license)
#> BSD-3-Clause

pkg <- desc::desc(file.path(find.package("yaml"), "DESCRIPTION"))

cat(pkg$get("License"))
#> BSD_3_clause + file LICENSE
```

Back to [Table 1](#tbl-summary).

### license-url

This key is not extracted from package metadata. See its description in
the [Guide to CFF schema
v1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#license-url).

> - **description**: The URL of the license text under which the
>   software or dataset is licensed (only for non-standard licenses not
>   included in the [SPDX License
>   List](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#definitionslicense-enum)).
>
> - **usage**:
>
>   ``` yaml
>   license-url: "https://obscure-licenses.com?id=1234"
>   ```

Back to [Table 1](#tbl-summary).

### message

This key is generated from the package metadata with this template:

``` r

msg <- paste0(
  'To cite package "',
  "NAME_OF_THE_PACKAGE",
  '" in publications use:'
)
```

**Example**

``` r

cat(cff_create("jsonlite")$message)
#> To cite package "jsonlite" in publications use:
```

Back to [Table 1](#tbl-summary).

### preferred-citation

This key is extracted from `inst/CITATION`. If multiple references are
provided, it selects the first citation as `"preferred-citation"` and
uses the remaining citations as [references](#references).

**Example**

``` r

cffobj <- cff_create("rmarkdown")

cffobj$`preferred-citation`
#> type: manual
#> title: 'rmarkdown: Dynamic Documents for R'
#> authors:
#> - family-names: Allaire
#>   given-names: JJ
#>   email: jj@posit.co
#> - family-names: Xie
#>   given-names: Yihui
#>   email: xie@yihui.name
#>   orcid: https://orcid.org/0000-0003-0645-5666
#> - family-names: Dervieux
#>   given-names: Christophe
#>   email: cderv@posit.co
#>   orcid: https://orcid.org/0000-0003-4474-2498
#> - family-names: McPherson
#>   given-names: Jonathan
#>   email: jonathan@posit.co
#> - family-names: Luraschi
#>   given-names: Javier
#> - family-names: Ushey
#>   given-names: Kevin
#>   email: kevin@posit.co
#> - family-names: Atkins
#>   given-names: Aron
#>   email: aron@posit.co
#> - family-names: Wickham
#>   given-names: Hadley
#>   email: hadley@posit.co
#> - family-names: Cheng
#>   given-names: Joe
#>   email: joe@posit.co
#> - family-names: Chang
#>   given-names: Winston
#>   email: winston@posit.co
#> - family-names: Iannone
#>   given-names: Richard
#>   email: rich@posit.co
#>   orcid: https://orcid.org/0000-0003-3925-190X
#> year: '2026'
#> notes: R package version 2.31
#> url: https://github.com/rstudio/rmarkdown

citation("rmarkdown")[1]
#> Allaire J, Xie Y, Dervieux C, McPherson J, Luraschi J, Ushey K, Atkins
#> A, Wickham H, Cheng J, Chang W, Iannone R (2026). _rmarkdown: Dynamic
#> Documents for R_. R package version 2.31,
#> <https://github.com/rstudio/rmarkdown>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {rmarkdown: Dynamic Documents for R},
#>     author = {JJ Allaire and Yihui Xie and Christophe Dervieux and Jonathan McPherson and Javier Luraschi and Kevin Ushey and Aron Atkins and Hadley Wickham and Joe Cheng and Winston Chang and Richard Iannone},
#>     year = {2026},
#>     note = {R package version 2.31},
#>     url = {https://github.com/rstudio/rmarkdown},
#>   }
```

Back to [Table 1](#tbl-summary).

### references

This key is extracted from `inst/CITATION` if multiple references are
provided. The first citation becomes the [preferred
citation](#preferred-citation) and the remaining citations become
`"references"`. **cffr** can also extract package dependencies and add
them to this field by calling `citation(auto = TRUE)` for each
dependency.

**Example**

``` r

cffobj <- cff_create("rmarkdown")

cffobj$references
#> - type: book
#>   title: 'R Markdown: The Definitive Guide'
#>   authors:
#>   - family-names: Xie
#>     given-names: Yihui
#>   - family-names: Allaire
#>     given-names: J.J.
#>   - family-names: Grolemund
#>     given-names: Garrett
#>   publisher:
#>     name: Chapman and Hall/CRC
#>     address: Boca Raton, Florida
#>   year: '2018'
#>   isbn: '9781138359338'
#>   url: https://yihui.org/rmarkdown/
#> - type: book
#>   title: R Markdown Cookbook
#>   authors:
#>   - family-names: Xie
#>     given-names: Yihui
#>   - family-names: Dervieux
#>     given-names: Christophe
#>   - family-names: Riederer
#>     given-names: Emily
#>   publisher:
#>     name: Chapman and Hall/CRC
#>     address: Boca Raton, Florida
#>   year: '2020'
#>   isbn: '9780367563837'
#>   url: https://yihui.org/rmarkdown-cookbook
#> - type: software
#>   title: 'R: A Language and Environment for Statistical Computing'
#>   notes: Depends
#>   url: https://www.R-project.org/
#>   authors:
#>   - name: R Core Team
#>     website: https://ror.org/02zz1nj61
#>   institution:
#>     name: R Foundation for Statistical Computing
#>     website: https://ror.org/05qewa988
#>     address: Vienna, Austria
#>   year: '2026'
#>   doi: 10.32614/R.manuals
#>   version: '>= 3.0'
#> - type: software
#>   title: bslib
#>   abstract: 'bslib: Custom ''Bootstrap'' ''Sass'' Themes for ''shiny'' and ''rmarkdown'''
#>   notes: Imports
#>   url: https://rstudio.github.io/bslib/
#>   repository: https://CRAN.R-project.org/package=bslib
#>   authors:
#>   - family-names: Sievert
#>     given-names: Carson
#>     email: carson@posit.co
#>     orcid: https://orcid.org/0000-0002-4958-2844
#>   - family-names: Cheng
#>     given-names: Joe
#>     email: joe@posit.co
#>   - family-names: Aden-Buie
#>     given-names: Garrick
#>     email: garrick@posit.co
#>     orcid: https://orcid.org/0000-0002-7111-0077
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.bslib
#>   version: '>= 0.2.5.1'
#> - type: software
#>   title: evaluate
#>   abstract: 'evaluate: Parsing and Evaluation Tools that Provide More Details than
#>     the Default'
#>   notes: Imports
#>   url: https://evaluate.r-lib.org/
#>   repository: https://CRAN.R-project.org/package=evaluate
#>   authors:
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   - family-names: Xie
#>     given-names: Yihui
#>     orcid: https://orcid.org/0000-0003-0645-5666
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.evaluate
#>   version: '>= 0.13'
#> - type: software
#>   title: fontawesome
#>   abstract: 'fontawesome: Easily Work with ''Font Awesome'' Icons'
#>   notes: Imports
#>   url: https://rstudio.github.io/fontawesome/
#>   repository: https://CRAN.R-project.org/package=fontawesome
#>   authors:
#>   - family-names: Iannone
#>     given-names: Richard
#>     email: rich@posit.co
#>     orcid: https://orcid.org/0000-0003-3925-190X
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.fontawesome
#>   version: '>= 0.5.0'
#> - type: software
#>   title: htmltools
#>   abstract: 'htmltools: Tools for HTML'
#>   notes: Imports
#>   url: https://rstudio.github.io/htmltools/
#>   repository: https://CRAN.R-project.org/package=htmltools
#>   authors:
#>   - family-names: Cheng
#>     given-names: Joe
#>     email: joe@posit.co
#>   - family-names: Sievert
#>     given-names: Carson
#>     email: carson@posit.co
#>     orcid: https://orcid.org/0000-0002-4958-2844
#>   - family-names: Schloerke
#>     given-names: Barret
#>     email: barret@posit.co
#>     orcid: https://orcid.org/0000-0001-9986-114X
#>   - family-names: Chang
#>     given-names: Winston
#>     email: winston@posit.co
#>     orcid: https://orcid.org/0000-0002-1576-2126
#>   - family-names: Xie
#>     given-names: Yihui
#>     email: yihui@posit.co
#>   - family-names: Allen
#>     given-names: Jeff
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.htmltools
#>   version: '>= 0.5.1'
#> - type: software
#>   title: jquerylib
#>   abstract: 'jquerylib: Obtain ''jQuery'' as an HTML Dependency Object'
#>   notes: Imports
#>   repository: https://CRAN.R-project.org/package=jquerylib
#>   authors:
#>   - family-names: Sievert
#>     given-names: Carson
#>     email: carson@rstudio.com
#>     orcid: https://orcid.org/0000-0002-4958-2844
#>   - family-names: Cheng
#>     given-names: Joe
#>     email: joe@rstudio.com
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.jquerylib
#> - type: software
#>   title: jsonlite
#>   abstract: 'jsonlite: A Simple and Robust JSON Parser and Generator for R'
#>   notes: Imports
#>   url: https://jeroen.r-universe.dev/jsonlite
#>   repository: https://CRAN.R-project.org/package=jsonlite
#>   authors:
#>   - family-names: Ooms
#>     given-names: Jeroen
#>     email: jeroenooms@gmail.com
#>     orcid: https://orcid.org/0000-0002-4035-0289
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.jsonlite
#> - type: software
#>   title: knitr
#>   abstract: 'knitr: A General-Purpose Package for Dynamic Report Generation in R'
#>   notes: Imports
#>   url: https://yihui.org/knitr/
#>   repository: https://CRAN.R-project.org/package=knitr
#>   authors:
#>   - family-names: Xie
#>     given-names: Yihui
#>     email: xie@yihui.name
#>     orcid: https://orcid.org/0000-0003-0645-5666
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.knitr
#>   version: '>= 1.43'
#> - type: software
#>   title: methods
#>   abstract: 'R: A Language and Environment for Statistical Computing'
#>   notes: Imports
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
#>   title: tinytex
#>   abstract: 'tinytex: Helper Functions to Install and Maintain TeX Live, and Compile
#>     LaTeX Documents'
#>   notes: Imports
#>   url: https://github.com/rstudio/tinytex
#>   repository: https://CRAN.R-project.org/package=tinytex
#>   authors:
#>   - family-names: Xie
#>     given-names: Yihui
#>     email: xie@yihui.name
#>     orcid: https://orcid.org/0000-0003-0645-5666
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.tinytex
#>   version: '>= 0.31'
#> - type: software
#>   title: tools
#>   abstract: 'R: A Language and Environment for Statistical Computing'
#>   notes: Imports
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
#>   title: utils
#>   abstract: 'R: A Language and Environment for Statistical Computing'
#>   notes: Imports
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
#>   title: xfun
#>   abstract: 'xfun: Supporting Functions for Packages Maintained by ''Yihui Xie'''
#>   notes: Imports
#>   url: https://github.com/yihui/xfun
#>   repository: https://CRAN.R-project.org/package=xfun
#>   authors:
#>   - family-names: Xie
#>     given-names: Yihui
#>     email: xie@yihui.name
#>     orcid: https://orcid.org/0000-0003-0645-5666
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.xfun
#>   version: '>= 0.36'
#> - type: software
#>   title: yaml
#>   abstract: 'yaml: Methods to Convert R Data to YAML and Back'
#>   notes: Imports
#>   url: https://yaml.r-lib.org
#>   repository: https://CRAN.R-project.org/package=yaml
#>   authors:
#>   - family-names: Stephens
#>     given-names: Jeremy
#>   - family-names: Simonov
#>     given-names: Kirill
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.yaml
#>   version: '>= 2.1.19'
#> - type: software
#>   title: digest
#>   abstract: 'digest: Create Compact Hash Digests of R Objects'
#>   notes: Suggests
#>   url: https://eddelbuettel.github.io/digest/
#>   repository: https://CRAN.R-project.org/package=digest
#>   authors:
#>   - family-names: Eddelbuettel
#>     given-names: Dirk
#>     email: edd@debian.org
#>     orcid: https://orcid.org/0000-0001-6419-907X
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.digest
#> - type: software
#>   title: fs
#>   abstract: 'fs: Cross-Platform File System Operations Based on ''libuv'''
#>   notes: Suggests
#>   url: https://fs.r-lib.org
#>   repository: https://CRAN.R-project.org/package=fs
#>   authors:
#>   - family-names: Hester
#>     given-names: Jim
#>   - family-names: Wickham
#>     given-names: Hadley
#>   - family-names: Csárdi
#>     given-names: Gábor
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.fs
#> - type: software
#>   title: rsconnect
#>   abstract: 'rsconnect: Deploy Docs, Apps, and APIs to ''Posit Connect'', ''shinyapps.io'',
#>     and ''RPubs'''
#>   notes: Suggests
#>   url: https://rstudio.github.io/rsconnect/
#>   repository: https://CRAN.R-project.org/package=rsconnect
#>   authors:
#>   - family-names: Atkins
#>     given-names: Aron
#>     email: aron@posit.co
#>   - family-names: Allen
#>     given-names: Toph
#>   - family-names: Wickham
#>     given-names: Hadley
#>   - family-names: McPherson
#>     given-names: Jonathan
#>   - family-names: Allaire
#>     given-names: JJ
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.rsconnect
#> - type: software
#>   title: downlit
#>   abstract: 'downlit: Syntax Highlighting and Automatic Linking'
#>   notes: Suggests
#>   url: https://downlit.r-lib.org/
#>   repository: https://CRAN.R-project.org/package=downlit
#>   authors:
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.downlit
#>   version: '>= 0.4.0'
#> - type: software
#>   title: sass
#>   abstract: 'sass: Syntactically Awesome Style Sheets (''Sass'')'
#>   notes: Suggests
#>   url: https://rstudio.github.io/sass/
#>   repository: https://CRAN.R-project.org/package=sass
#>   authors:
#>   - family-names: Cheng
#>     given-names: Joe
#>     email: joe@rstudio.com
#>   - family-names: Mastny
#>     given-names: Timothy
#>     email: tim.mastny@gmail.com
#>   - family-names: Iannone
#>     given-names: Richard
#>     email: rich@rstudio.com
#>     orcid: https://orcid.org/0000-0003-3925-190X
#>   - family-names: Schloerke
#>     given-names: Barret
#>     email: barret@rstudio.com
#>     orcid: https://orcid.org/0000-0001-9986-114X
#>   - family-names: Sievert
#>     given-names: Carson
#>     email: carson@rstudio.com
#>     orcid: https://orcid.org/0000-0002-4958-2844
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.sass
#>   version: '>= 0.4.0'
#> - type: software
#>   title: shiny
#>   abstract: 'shiny: Web Application Framework for R'
#>   notes: Suggests
#>   url: https://shiny.posit.co/
#>   repository: https://CRAN.R-project.org/package=shiny
#>   authors:
#>   - family-names: Chang
#>     given-names: Winston
#>     email: winston@posit.co
#>     orcid: https://orcid.org/0000-0002-1576-2126
#>   - family-names: Cheng
#>     given-names: Joe
#>     email: joe@posit.co
#>   - family-names: Allaire
#>     given-names: JJ
#>     email: jj@posit.co
#>   - family-names: Sievert
#>     given-names: Carson
#>     email: carson@posit.co
#>     orcid: https://orcid.org/0000-0002-4958-2844
#>   - family-names: Schloerke
#>     given-names: Barret
#>     email: barret@posit.co
#>     orcid: https://orcid.org/0000-0001-9986-114X
#>   - family-names: Aden-Buie
#>     given-names: Garrick
#>     email: garrick@adenbuie.com
#>     orcid: https://orcid.org/0000-0002-7111-0077
#>   - family-names: Xie
#>     given-names: Yihui
#>     email: yihui@posit.co
#>   - family-names: Allen
#>     given-names: Jeff
#>   - family-names: McPherson
#>     given-names: Jonathan
#>     email: jonathan@posit.co
#>   - family-names: Dipert
#>     given-names: Alan
#>   - family-names: Borges
#>     given-names: Barbara
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.shiny
#>   version: '>= 1.6.0'
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
#>   version: '>= 3.0.3'
#> - type: software
#>   title: tibble
#>   abstract: 'tibble: Simple Data Frames'
#>   notes: Suggests
#>   url: https://tibble.tidyverse.org/
#>   repository: https://CRAN.R-project.org/package=tibble
#>   authors:
#>   - family-names: Müller
#>     given-names: Kirill
#>     email: kirill@cynkra.com
#>     orcid: https://orcid.org/0000-0002-1416-3412
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@rstudio.com
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.tibble
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
#>   title: withr
#>   abstract: 'withr: Run Code ''With'' Temporarily Modified Global State'
#>   notes: Suggests
#>   url: https://withr.r-lib.org
#>   repository: https://CRAN.R-project.org/package=withr
#>   authors:
#>   - family-names: Hester
#>     given-names: Jim
#>   - family-names: Henry
#>     given-names: Lionel
#>     email: lionel@posit.co
#>   - family-names: Müller
#>     given-names: Kirill
#>     email: krlmlr+r@mailbox.org
#>   - family-names: Ushey
#>     given-names: Kevin
#>     email: kevinushey@gmail.com
#>   - family-names: Wickham
#>     given-names: Hadley
#>     email: hadley@posit.co
#>   - family-names: Chang
#>     given-names: Winston
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.withr
#>   version: '>= 2.4.2'
#> - type: software
#>   title: xml2
#>   abstract: 'xml2: Parse XML'
#>   notes: Suggests
#>   url: https://xml2.r-lib.org
#>   repository: https://CRAN.R-project.org/package=xml2
#>   authors:
#>   - family-names: Wickham
#>     given-names: Hadley
#>   - family-names: Hester
#>     given-names: Jim
#>   - family-names: Ooms
#>     given-names: Jeroen
#>     email: jeroenooms@gmail.com
#>   year: '2026'
#>   doi: 10.32614/CRAN.package.xml2

citation("rmarkdown")[-1]
#> Xie Y, Allaire J, Grolemund G (2018). _R Markdown: The Definitive
#> Guide_. Chapman and Hall/CRC, Boca Raton, Florida. ISBN 9781138359338.
#> <https://yihui.org/rmarkdown/>.
#> 
#> Xie Y, Dervieux C, Riederer E (2020). _R Markdown Cookbook_. Chapman
#> and Hall/CRC, Boca Raton, Florida. ISBN 9780367563837.
#> <https://yihui.org/rmarkdown-cookbook>.
#> 
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

Back to [Table 1](#tbl-summary).

### repository

This key is extracted from the `"Repository"` field of the `DESCRIPTION`
file. This field is usually populated when a package is hosted in a
repository such as **CRAN** or
[r-universe](https://r-universe.dev/search). For packages without this
field in the `DESCRIPTION` (which is the typical case for an
in-development package), **cffr** tries to find the package in any of
the default repositories specified in `options("repos")`.

[Bioconductor](https://bioconductor.org/) packages are identified when
the
[`"biocViews"`](https://contributions.bioconductor.org/description.html#biocviews)
field is present in the `DESCRIPTION` file.

If **cffr** detects that the package is available on **CRAN**, it
returns the canonical URL form of the package (that is,
<https://CRAN.R-project.org/package=jsonlite>).

**Example**

``` r

# Use an installed package.

inst <- cff_create("jsonlite")

cat(inst$repository)
#> https://CRAN.R-project.org/package=jsonlite

# Demo file downloaded from the r-universe.

runiv <- system.file("examples/DESCRIPTION_r_universe", package = "cffr")
runiv_cff <- cff_create(runiv)

cat(runiv_cff$repository)
#> https://ropensci.r-universe.dev

desc::desc(runiv)$get("Repository")
#>                        Repository 
#> "https://ropensci.r-universe.dev"

# For an in-development package.

norepo <- system.file("examples/DESCRIPTION_basic", package = "cffr")

# No repository is available.
norepo_cff <- cff_create(norepo)

cat(norepo_cff[["repository"]])

# Change the name to a known package on CRAN: ggplot2.

tmp <- tempfile("DESCRIPTION")
file.copy(norepo, tmp)
#> [1] TRUE

# Change the package name.
desc::desc_set("Package", "ggplot2", file = tmp)
#> Type: Package
#> Package: ggplot2
#> Title: A Basic Description
#> Version: 0.1.6
#> Authors@R (parsed):
#>     * Marc Basic <marcbasic@gmail.com> [aut, cre, cph]
#> Description: A very basic description. Should parse without problems.
#> License: GPL-3
#> URL: https://github.com/basic/package, https://basic.github.io/package
#> BugReports: https://github.com/basic/package/issues
#> Encoding: UTF-8
#> LazyData: true
#> RoxygenNote: 6.0.1.9000

cat(cff_create(tmp)[["repository"]])
#> https://CRAN.R-project.org/package=ggplot2
```

Back to [Table 1](#tbl-summary).

### repository-artifact

This key is not extracted from package metadata. See its description in
the [Guide to CFF schema
v1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#repository-artifact).

> - **description**: The URL of the work in a build artifact/binary
>   repository (when the work is software).
>
> - **usage**:
>
>   ``` yaml
>   repository-artifact: "https://search.maven.org/artifact/org.corpus-tools/cff-maven-plugin/0.4.0/maven-plugin"
>   ```

Back to [Table 1](#tbl-summary).

### repository-code

This key is extracted from the `"BugReports"` or `"URL"` fields in the
`DESCRIPTION` file. **cffr** tries to identify the URL of the source on
the following repositories:

- [GitHub](https://github.com/).
- [GitLab](https://about.gitlab.com/).
- [R-Forge](https://r-forge.r-project.org/).
- [Bitbucket](https://bitbucket.org/).
- [Codeberg](https://codeberg.org/).

**Example**

``` r

# Installed package on GitHub.

cat(cff_create("jsonlite")$`repository-code`)
#> https://github.com/jeroen/jsonlite

# GitLab

gitlab <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")

cat(cff_create(gitlab)$`repository-code`)
#> https://gitlab.com/ninijay/methoden

# Codeberg
codeberg <- system.file("examples/DESCRIPTION_codeberg", package = "cffr")

cat(cff_create(codeberg)$`repository-code`)
#> https://codeberg.org/dgkf/options
```

Back to [Table 1](#tbl-summary).

### title

This key combines the `"Package"` and `"Title"` fields of the
`DESCRIPTION` file.

``` r

title <- paste0("NAME_OF_THE_PACKAGE", ": ", "TITLE_OF_THE_PACKAGE")
```

**Example**

``` r

# Use an installed package.

cat(cff_create("testthat")$title)
#> testthat: Unit Testing for R
```

Back to [Table 1](#tbl-summary).

### type

This key has the fixed value `"software"`. The other valid value is
`"dataset"`. See the [Guide to CFF schema
v1.2.0](https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md#type).

Back to [Table 1](#tbl-summary).

### url

This key is extracted from the `"BugReports"` or `"URL"` fields in the
`DESCRIPTION` file. It corresponds to the first URL that is different
from [repository-code](#repository-code).

**Example**

``` r

# Many URLs.
manyurls <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

cat(cff_create(manyurls)$url)
#> https://test.github.io/package/

# Check the source metadata.

desc::desc(manyurls)
#> Type: Package
#> Package: manyurls
#> Title: A lot of urls
#> Version: 0.1.6
#> Authors@R (parsed):
#>     * Marc Basic <marcbasic@gmail.com> [aut, cre, cph]
#> Description: This package has many urls. Specifically, 1 Bug Reports and 6
#>     URLs. Expected is to have 1 repository-code, 1 url and 3 URLs, since
#>     there is 1 duplicate and 1 invalid url.
#> License: GPL-3
#> URL: https://github.com/test/package, https://test.github.io/package/,
#>     https://r-forge.r-project.org/projects/test/, http://google.ru,
#>     https://gitlab.com/r-packages/behaviorchange, this.is.not.an.url
#> BugReports: https://github.com/test/package/issues
#> Encoding: UTF-8
```

Back to [Table 1](#tbl-summary).

### version

This key is extracted from the `"Version"` field in the `DESCRIPTION`
file.

``` r

# Should be (>= 3.0.0).
cat(cff_create("testthat")$version)
#> 3.3.2
```

Back to [Table 1](#tbl-summary).

## References

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, et al. 2021.
*Citation File Format*. Version 1.2.0. Zenodo.
<https://doi.org/10.5281/zenodo.5171937>.
