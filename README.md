

<!-- README.md is generated from README.qmd. Please edit that file -->

# cffr <a href="https://docs.ropensci.org/cffr/"><img src="man/figures/logo.png" alt="cffr website" align="right" height="139"/></a>

<!-- badges: start -->

[![CRAN-status](https://www.r-pkg.org/badges/version/cffr)](https://CRAN.R-project.org/package=cffr)
[![CRAN-results](https://badges.cranchecks.info/worst/cffr.svg)](https://cran.r-project.org/web/checks/check_results_cffr.html)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/cffr?color=blue)](https://cran.r-project.org/package=cffr)
[![R-CMD-check](https://github.com/ropensci/cffr/actions/workflows/check-full.yaml/badge.svg)](https://github.com/ropensci/cffr/actions/workflows/check-full.yaml)
[![R-hub](https://github.com/ropensci/cffr/actions/workflows/rhub.yaml/badge.svg)](https://github.com/ropensci/cffr/actions/workflows/rhub.yaml)
[![codecov](https://codecov.io/gh/ropensci/cffr/branch/main/graph/badge.svg?token=YRO3XL8RWK)](https://app.codecov.io/gh/ropensci/cffr)
[![r-universe](https://ropensci.r-universe.dev/badges/cffr)](https://ropensci.r-universe.dev/cffr)
[![CITATION-cff](https://github.com/ropensci/cffr/actions/workflows/cff-validator.yml/badge.svg)](https://github.com/ropensci/cffr/actions/workflows/cff-validator.yml)
[![DOI](https://joss.theoj.org/papers/10.21105/joss.03900/status.svg)](https://doi.org/10.21105/joss.03900)
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
![GitHub code size in
bytes](https://img.shields.io/github/languages/code-size/ropensci/cffr)
[![peer-review](https://badges.ropensci.org/463_status.svg)](https://github.com/ropensci/software-review/issues/463)

<!-- badges: end -->

**cffr** provides utilities to generate, coerce, modify, and validate
`CITATION.cff` files automatically for **R** packages, along with tools
and examples for working with .cff files more generally.

## What is a `CITATION.cff` file?

[Citation File Format (CFF](https://citation-file-format.github.io/))
([Druskat et al. 2021](#ref-druskat_citation_2021)) (v1.2.0) are plain
text files with human- and machine-readable citation information for
software (and datasets). Code developers can include them in their
repositories to let others know how to correctly cite their software.

This format is gaining popularity within the software citation
ecosystem. Recently,
[GitHub](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files),
[Zenodo](https://citation-file-format.github.io/#/supported-by-zenodo-),
and
[Zotero](https://citation-file-format.github.io/#/supported-by-zotero-)
have fully supported this citation format ([Druskat
2021](#ref-druskat_stephan_making_2021)). GitHub support is of special
interest:

<img src="vignettes/tweet-1.png" data-fig-align="center"
data-fig-alt="Tweet of Nat Friedman about CFF files" width="400" />

*— Nat Friedman (@natfriedman) July 27, 2021*

See [Enhanced support for citations on
GitHub](https://github.blog/news-insights/company-news/enhanced-support-citations-github/)
([Smith 2021](#ref-smith2021)) for more information.

### Related projects

[The CodeMeta Project](https://codemeta.github.io/) ([Jones et al.
2017](#ref-jones2017)) creates a concept vocabulary that can be used to
standardize the exchange of software metadata across repositories and
organizations. One of the many uses of a `codemeta.json` file (created
following the standards defined by The CodeMeta Project) is to provide
citation metadata such as title, authors, publication year, and venue
([Fenner 2021](#ref-fenner2021)). The packages **codemeta** ([Boettiger
and Salmon 2021a](#ref-codemeta)) and **codemetar** ([Boettiger and
Salmon 2021b](#ref-codemetar2021)) allow for generating `codemeta.json`
files from R package metadata.

## The cffr package

**cffr** maximizes data extraction by utilizing both the `DESCRIPTION`
file and the `CITATION` file (if present) from your package. Note that
**cffr** works best if your package passes
`R CMD check/devtools::check()`.

As per 2026-02-14 there are at least 470 repos on GitHub using **cffr**.
[Check them out
here](https://github.com/search?q=cffr%20path%3A**%2FCITATION.cff&type=code).

### Installation

Install **cffr** from [CRAN](https://CRAN.R-project.org/package=cffr):

``` r
install.packages("cffr")
```

You can install the developing version of **cffr** with:

``` r
remotes::install_github("ropensci/cffr")
```

Alternatively, you can install **cffr** using the
[r-universe](https://ropensci.r-universe.dev/cffr):

``` r
# Install cffr in R:
install.packages(
  "cffr",
  repos = c("https://ropensci.r-universe.dev", "https://cloud.r-project.org")
)
```

### Example

By default most often from within your package folder you’ll simply run
`cff_write()`, that creates a `cff` object, write it on a `CITATION.cff`
file and validates it on a single command:

``` r
library(cffr)

# For in-development packages
cff_write()
#>
#> CITATION.cff generated
#>
#> cff_validate results-----
#> Congratulations! This .cff file is valid
```

However, **cffr** provides also custom print methods and mechanisms that
allows you to customize the `CITATION.cff` and integrate them in your
workflows.

This is a basic example which shows you how to create a `cff` object
(see `?cff` for more info). In this case, we are creating a `cff` object
from the metadata of the **rmarkdown** package:

``` r
library(cffr)

# Example with an installed package
test <- cff_create("knitr")
```

<details>

<summary>

<code>CITATION.cff</code> for <strong>knitr</strong>
</summary>

    cff-version: 1.2.0
    message: 'To cite package "knitr" in publications use:'
    type: software
    license: GPL-1.0-only
    title: 'knitr: A General-Purpose Package for Dynamic Report Generation in R'
    version: '1.51'
    identifiers:
    - type: doi
      value: 10.32614/CRAN.package.knitr
    abstract: Provides a general-purpose tool for dynamic report generation in R using
      Literate Programming techniques.
    authors:
    - family-names: Xie
      given-names: Yihui
      email: xie@yihui.name
      orcid: https://orcid.org/0000-0003-0645-5666
    preferred-citation:
      type: manual
      title: 'knitr: A General-Purpose Package for Dynamic Report Generation in R'
      authors:
      - family-names: Xie
        given-names: Yihui
        orcid: https://orcid.org/0000-0003-0645-5666
        email: xie@yihui.name
      year: '2025'
      notes: R package version 1.51
      url: https://yihui.org/knitr/
    repository: https://CRAN.R-project.org/package=knitr
    repository-code: https://github.com/yihui/knitr
    url: https://yihui.org/knitr/
    date-released: '2025-12-20'
    contact:
    - family-names: Xie
      given-names: Yihui
      email: xie@yihui.name
      orcid: https://orcid.org/0000-0003-0645-5666
    keywords:
    - dynamic-documents
    - knitr
    - literate-programming
    - r
    - r-package
    - rmarkdown
    - sweave
    references:
    - type: book
      title: Dynamic Documents with R and knitr
      authors:
      - family-names: Xie
        given-names: Yihui
      publisher:
        name: Chapman and Hall/CRC
        address: Boca Raton, Florida
      year: '2015'
      edition: 2nd
      notes: ISBN 978-1498716963
      url: https://yihui.org/knitr/
    - type: generic
      title: 'knitr: A Comprehensive Tool for Reproducible Research in R'
      authors:
      - family-names: Xie
        given-names: Yihui
      collection-title: Implementing Reproducible Computational Research
      collection-type: collection
      editors:
      - family-names: Stodden
        given-names: Victoria
      - family-names: Leisch
        given-names: Friedrich
      - family-names: Peng
        given-names: Roger D.
      publisher:
        name: Chapman and Hall/CRC
      year: '2014'
      notes: ISBN 978-1466561595
    - type: software
      title: 'R: A Language and Environment for Statistical Computing'
      notes: Depends
      url: https://www.R-project.org/
      authors:
      - name: R Core Team
      institution:
        name: R Foundation for Statistical Computing
        address: Vienna, Austria
      year: '2026'
      version: '>= 3.6.0'
    - type: software
      title: evaluate
      abstract: 'evaluate: Parsing and Evaluation Tools that Provide More Details than
        the Default'
      notes: Imports
      url: https://evaluate.r-lib.org/
      repository: https://CRAN.R-project.org/package=evaluate
      authors:
      - family-names: Wickham
        given-names: Hadley
        email: hadley@posit.co
      - family-names: Xie
        given-names: Yihui
        orcid: https://orcid.org/0000-0003-0645-5666
      year: '2026'
      doi: 10.32614/CRAN.package.evaluate
      version: '>= 0.15'
    - type: software
      title: highr
      abstract: 'highr: Syntax Highlighting for R Source Code'
      notes: Imports
      url: https://github.com/yihui/highr
      repository: https://CRAN.R-project.org/package=highr
      authors:
      - family-names: Xie
        given-names: Yihui
        email: xie@yihui.name
        orcid: https://orcid.org/0000-0003-0645-5666
      - family-names: Qiu
        given-names: Yixuan
      year: '2026'
      doi: 10.32614/CRAN.package.highr
      version: '>= 0.11'
    - type: software
      title: methods
      abstract: 'R: A Language and Environment for Statistical Computing'
      notes: Imports
      authors:
      - name: R Core Team
      institution:
        name: R Foundation for Statistical Computing
        address: Vienna, Austria
      year: '2026'
    - type: software
      title: tools
      abstract: 'R: A Language and Environment for Statistical Computing'
      notes: Imports
      authors:
      - name: R Core Team
      institution:
        name: R Foundation for Statistical Computing
        address: Vienna, Austria
      year: '2026'
    - type: software
      title: xfun
      abstract: 'xfun: Supporting Functions for Packages Maintained by ''Yihui Xie'''
      notes: Imports
      url: https://github.com/yihui/xfun
      repository: https://CRAN.R-project.org/package=xfun
      authors:
      - family-names: Xie
        given-names: Yihui
        email: xie@yihui.name
        orcid: https://orcid.org/0000-0003-0645-5666
      year: '2026'
      doi: 10.32614/CRAN.package.xfun
      version: '>= 0.52'
    - type: software
      title: yaml
      abstract: 'yaml: Methods to Convert R Data to YAML and Back'
      notes: Imports
      url: https://yaml.r-lib.org
      repository: https://CRAN.R-project.org/package=yaml
      authors:
      - family-names: Stephens
        given-names: Jeremy
      - family-names: Simonov
        given-names: Kirill
      year: '2026'
      doi: 10.32614/CRAN.package.yaml
      version: '>= 2.1.19'
    - type: software
      title: bslib
      abstract: 'bslib: Custom ''Bootstrap'' ''Sass'' Themes for ''shiny'' and ''rmarkdown'''
      notes: Suggests
      url: https://rstudio.github.io/bslib/
      repository: https://CRAN.R-project.org/package=bslib
      authors:
      - family-names: Sievert
        given-names: Carson
        email: carson@posit.co
        orcid: https://orcid.org/0000-0002-4958-2844
      - family-names: Cheng
        given-names: Joe
        email: joe@posit.co
      - family-names: Aden-Buie
        given-names: Garrick
        email: garrick@posit.co
        orcid: https://orcid.org/0000-0002-7111-0077
      year: '2026'
      doi: 10.32614/CRAN.package.bslib
    - type: software
      title: DBI
      abstract: 'DBI: R Database Interface'
      notes: Suggests
      url: https://dbi.r-dbi.org
      repository: https://CRAN.R-project.org/package=DBI
      authors:
      - name: R Special Interest Group on Databases (R-SIG-DB)
      - family-names: Wickham
        given-names: Hadley
      - family-names: Müller
        given-names: Kirill
        email: kirill@cynkra.com
        orcid: https://orcid.org/0000-0002-1416-3412
      year: '2026'
      doi: 10.32614/CRAN.package.DBI
      version: '>= 0.4-1'
    - type: software
      title: digest
      abstract: 'digest: Create Compact Hash Digests of R Objects'
      notes: Suggests
      url: https://eddelbuettel.github.io/digest/
      repository: https://CRAN.R-project.org/package=digest
      authors:
      - family-names: Eddelbuettel
        given-names: Dirk
        email: edd@debian.org
        orcid: https://orcid.org/0000-0001-6419-907X
      year: '2026'
      doi: 10.32614/CRAN.package.digest
    - type: software
      title: gifski
      abstract: 'gifski: Highest Quality GIF Encoder'
      notes: Suggests
      url: https://r-rust.r-universe.dev/gifski
      repository: https://CRAN.R-project.org/package=gifski
      authors:
      - family-names: Ooms
        given-names: Jeroen
        email: jeroenooms@gmail.com
        orcid: https://orcid.org/0000-0002-4035-0289
      - name: Kornel Lesiński
      - name: Authors of the dependency Rust crates
      year: '2026'
      doi: 10.32614/CRAN.package.gifski
    - type: software
      title: htmlwidgets
      abstract: 'htmlwidgets: HTML Widgets for R'
      notes: Suggests
      url: https://github.com/ramnathv/htmlwidgets
      repository: https://CRAN.R-project.org/package=htmlwidgets
      authors:
      - family-names: Vaidyanathan
        given-names: Ramnath
      - family-names: Xie
        given-names: Yihui
      - family-names: Allaire
        given-names: JJ
      - family-names: Cheng
        given-names: Joe
        email: joe@posit.co
      - family-names: Sievert
        given-names: Carson
        email: carson@posit.co
        orcid: https://orcid.org/0000-0002-4958-2844
      - family-names: Russell
        given-names: Kenton
      year: '2026'
      doi: 10.32614/CRAN.package.htmlwidgets
      version: '>= 0.7'
    - type: software
      title: jpeg
      abstract: 'jpeg: Read and write JPEG images'
      notes: Suggests
      url: https://www.rforge.net/jpeg/
      repository: https://CRAN.R-project.org/package=jpeg
      authors:
      - family-names: Urbanek
        given-names: Simon
        email: Simon.Urbanek@r-project.org
        orcid: https://orcid.org/0000-0003-2297-1732
      year: '2026'
      doi: 10.32614/CRAN.package.jpeg
    - type: software
      title: magick
      abstract: 'magick: Advanced Graphics and Image-Processing in R'
      notes: Suggests
      url: https://docs.ropensci.org/magick/
      repository: https://CRAN.R-project.org/package=magick
      authors:
      - family-names: Ooms
        given-names: Jeroen
        email: jeroenooms@gmail.com
        orcid: https://orcid.org/0000-0002-4035-0289
      year: '2026'
      doi: 10.32614/CRAN.package.magick
    - type: software
      title: litedown
      abstract: 'litedown: A Lightweight Version of R Markdown'
      notes: Suggests
      url: https://github.com/yihui/litedown
      repository: https://CRAN.R-project.org/package=litedown
      authors:
      - family-names: Xie
        given-names: Yihui
        email: xie@yihui.name
        orcid: https://orcid.org/0000-0003-0645-5666
      year: '2026'
      doi: 10.32614/CRAN.package.litedown
    - type: software
      title: markdown
      abstract: 'markdown: Render Markdown with ''commonmark'''
      notes: Suggests
      url: https://github.com/rstudio/markdown
      repository: https://CRAN.R-project.org/package=markdown
      authors:
      - family-names: Xie
        given-names: Yihui
        email: xie@yihui.name
        orcid: https://orcid.org/0000-0003-0645-5666
      - family-names: Allaire
        given-names: JJ
      - family-names: Horner
        given-names: Jeffrey
      year: '2026'
      doi: 10.32614/CRAN.package.markdown
      version: '>= 1.3'
    - type: software
      title: otel
      abstract: 'otel: OpenTelemetry R API'
      notes: Suggests
      url: https://otel.r-lib.org
      repository: https://CRAN.R-project.org/package=otel
      authors:
      - family-names: Csárdi
        given-names: Gábor
        email: csardi.gabor@gmail.com
      year: '2026'
      doi: 10.32614/CRAN.package.otel
    - type: software
      title: otelsdk
      abstract: 'otelsdk: ''R'' ''SDK'' and Exporters for ''OpenTelemetry'''
      notes: Suggests
      url: https://otelsdk.r-lib.org
      repository: https://CRAN.R-project.org/package=otelsdk
      authors:
      - family-names: Csárdi
        given-names: Gábor
        email: csardi.gabor@gmail.com
      year: '2026'
      doi: 10.32614/CRAN.package.otelsdk
    - type: software
      title: png
      abstract: 'png: Read and write PNG images'
      notes: Suggests
      url: http://www.rforge.net/png/
      repository: https://CRAN.R-project.org/package=png
      authors:
      - family-names: Urbanek
        given-names: Simon
        email: Simon.Urbanek@r-project.org
      year: '2026'
      doi: 10.32614/CRAN.package.png
    - type: software
      title: ragg
      abstract: 'ragg: Graphic Devices Based on AGG'
      notes: Suggests
      url: https://ragg.r-lib.org
      repository: https://CRAN.R-project.org/package=ragg
      authors:
      - family-names: Pedersen
        given-names: Thomas Lin
        email: thomas.pedersen@posit.co
        orcid: https://orcid.org/0000-0002-5147-4711
      - family-names: Shemanarev
        given-names: Maxim
      year: '2026'
      doi: 10.32614/CRAN.package.ragg
    - type: software
      title: rlang
      abstract: 'rlang: Functions for Base Types and Core R and ''Tidyverse'' Features'
      notes: Suggests
      url: https://rlang.r-lib.org
      repository: https://CRAN.R-project.org/package=rlang
      authors:
      - family-names: Henry
        given-names: Lionel
        email: lionel@posit.co
      - family-names: Wickham
        given-names: Hadley
        email: hadley@posit.co
      year: '2026'
      doi: 10.32614/CRAN.package.rlang
    - type: software
      title: rmarkdown
      abstract: 'rmarkdown: Dynamic Documents for R'
      notes: Suggests
      url: https://pkgs.rstudio.com/rmarkdown/
      repository: https://CRAN.R-project.org/package=rmarkdown
      authors:
      - family-names: Allaire
        given-names: JJ
        email: jj@posit.co
      - family-names: Xie
        given-names: Yihui
        email: xie@yihui.name
        orcid: https://orcid.org/0000-0003-0645-5666
      - family-names: Dervieux
        given-names: Christophe
        email: cderv@posit.co
        orcid: https://orcid.org/0000-0003-4474-2498
      - family-names: McPherson
        given-names: Jonathan
        email: jonathan@posit.co
      - family-names: Luraschi
        given-names: Javier
      - family-names: Ushey
        given-names: Kevin
        email: kevin@posit.co
      - family-names: Atkins
        given-names: Aron
        email: aron@posit.co
      - family-names: Wickham
        given-names: Hadley
        email: hadley@posit.co
      - family-names: Cheng
        given-names: Joe
        email: joe@posit.co
      - family-names: Chang
        given-names: Winston
        email: winston@posit.co
      - family-names: Iannone
        given-names: Richard
        email: rich@posit.co
        orcid: https://orcid.org/0000-0003-3925-190X
      year: '2026'
      doi: 10.32614/CRAN.package.rmarkdown
    - type: software
      title: sass
      abstract: 'sass: Syntactically Awesome Style Sheets (''Sass'')'
      notes: Suggests
      url: https://rstudio.github.io/sass/
      repository: https://CRAN.R-project.org/package=sass
      authors:
      - family-names: Cheng
        given-names: Joe
        email: joe@rstudio.com
      - family-names: Mastny
        given-names: Timothy
        email: tim.mastny@gmail.com
      - family-names: Iannone
        given-names: Richard
        email: rich@rstudio.com
        orcid: https://orcid.org/0000-0003-3925-190X
      - family-names: Schloerke
        given-names: Barret
        email: barret@rstudio.com
        orcid: https://orcid.org/0000-0001-9986-114X
      - family-names: Sievert
        given-names: Carson
        email: carson@rstudio.com
        orcid: https://orcid.org/0000-0002-4958-2844
      year: '2026'
      doi: 10.32614/CRAN.package.sass
    - type: software
      title: showtext
      abstract: 'showtext: Using Fonts More Easily in R Graphs'
      notes: Suggests
      url: https://github.com/yixuan/showtext
      repository: https://CRAN.R-project.org/package=showtext
      authors:
      - family-names: Qiu
        given-names: Yixuan
      - family-names: details.
        given-names: authors/contributors of the included software. See file AUTHORS for
      year: '2026'
      doi: 10.32614/CRAN.package.showtext
    - type: software
      title: styler
      abstract: 'styler: Non-Invasive Pretty Printing of R Code'
      notes: Suggests
      url: https://styler.r-lib.org
      repository: https://CRAN.R-project.org/package=styler
      authors:
      - family-names: Müller
        given-names: Kirill
        email: kirill@cynkra.com
        orcid: https://orcid.org/0000-0002-1416-3412
      - family-names: Walthert
        given-names: Lorenz
        email: lorenz.walthert@icloud.com
      - family-names: Patil
        given-names: Indrajeet
        email: patilindrajeet.science@gmail.com
        orcid: https://orcid.org/0000-0003-1995-6531
      year: '2026'
      doi: 10.32614/CRAN.package.styler
      version: '>= 1.2.0'
    - type: software
      title: tibble
      abstract: 'tibble: Simple Data Frames'
      notes: Suggests
      url: https://tibble.tidyverse.org/
      repository: https://CRAN.R-project.org/package=tibble
      authors:
      - family-names: Müller
        given-names: Kirill
        email: kirill@cynkra.com
        orcid: https://orcid.org/0000-0002-1416-3412
      - family-names: Wickham
        given-names: Hadley
        email: hadley@rstudio.com
      year: '2026'
      doi: 10.32614/CRAN.package.tibble
    - type: software
      title: tinytex
      abstract: 'tinytex: Helper Functions to Install and Maintain TeX Live, and Compile
        LaTeX Documents'
      notes: Suggests
      url: https://github.com/rstudio/tinytex
      repository: https://CRAN.R-project.org/package=tinytex
      authors:
      - family-names: Xie
        given-names: Yihui
        email: xie@yihui.name
        orcid: https://orcid.org/0000-0003-0645-5666
      year: '2026'
      doi: 10.32614/CRAN.package.tinytex
      version: '>= 0.56'
    - type: software
      title: rstudioapi
      abstract: 'rstudioapi: Safely Access the RStudio API'
      notes: Suggests
      url: https://rstudio.github.io/rstudioapi/
      repository: https://CRAN.R-project.org/package=rstudioapi
      authors:
      - family-names: Ushey
        given-names: Kevin
        email: kevin@rstudio.com
      - family-names: Allaire
        given-names: JJ
        email: jj@posit.co
      - family-names: Wickham
        given-names: Hadley
        email: hadley@posit.co
      - family-names: Ritchie
        given-names: Gary
        email: gary@posit.co
      year: '2026'
      doi: 10.32614/CRAN.package.rstudioapi
    - type: software
      title: svglite
      abstract: 'svglite: An ''SVG'' Graphics Device'
      notes: Suggests
      url: https://svglite.r-lib.org
      repository: https://CRAN.R-project.org/package=svglite
      authors:
      - family-names: Wickham
        given-names: Hadley
        email: hadley@posit.co
      - family-names: Henry
        given-names: Lionel
        email: lionel@posit.co
      - family-names: Pedersen
        given-names: Thomas Lin
        email: thomas.pedersen@posit.co
        orcid: https://orcid.org/0000-0002-5147-4711
      - family-names: Luciani
        given-names: T Jake
        email: jake@apache.org
      - family-names: Decorde
        given-names: Matthieu
        email: matthieu.decorde@ens-lyon.fr
      - family-names: Lise
        given-names: Vaudor
        email: lise.vaudor@ens-lyon.fr
      year: '2026'
      doi: 10.32614/CRAN.package.svglite

</details>

We can validate the result using `cff_validate()`:

``` r
cff_validate(test)
#> ══ Validating cff ══════════════════════════════════════════════════════════════
```

Check the [docs](https://docs.ropensci.org/cffr//reference/index.html)
and `vignette("cffr", package = "cffr")` to learn how to work with `cff`
objects.

### Keep your `CITATION.cff` file up-to-date

#### GitHub Actions

The easiest way for keeping you `CITATION.cff` file up-to-date is using
GitHub Actions. Use `cff_gha_update()`function to install a GitHub
Action that would update your `CITATION.cff` file on the following
events:

- When you publish a new release of the package on your GitHub repo.
- Each time that you modify your DESCRIPTION or inst/CITATION files.
- The action can be run also manually.

``` r
cff_gha_update()

#> i Installing update-citation-cff.yaml on './.github/workflows'
#> i Adding .github to .Rbuildignore
```

See the example workflow file
[here](https://github.com/ropensci/cffr/blob/main/.github/workflows/update-citation-cff.yaml).

#### Git pre-commit hook [![Experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

You can also use a [git pre-commit
hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks#_committing_workflow_hooks):

> The `pre-commit` hook is run first, before you even type in a commit
> message. It’s used to inspect the snapshot that’s about to be
> committed, to see if you’ve forgotten something, to make sure tests
> run, or to examine whatever you need to inspect in the code. Exiting
> non-zero from this hook aborts the need to inspect in the code.
> Exiting non-zero from this hook aborts the commit, although you can
> bypass it with `git commit --no-verify`.

A specific pre-commit hook can be installed with
`cff_git_hook_install()`. If you want to use a pre-commit hook, please
make sure you have the **testthat** package installed.

### Learn more

Check the following articles to learn more about **cffr**:

- [cffr: Create a CITATION.cff File for your R
  Package](https://ropensci.org/blog/2021/11/23/cffr/)
- [How I Test cffr on (about) 2,000 Packages using GitHub Actions and
  R-universe](https://ropensci.org/blog/2021/11/23/how-i-test-cffr/)

## Related packages

- **citation** ([Dietrich and Leoncio 2022](#ref-citation22)) includes a
  function `r2cff` that creates a `CITATION.cff` file (v1.1.0) using the
  information of your `DESCRIPTION` file. It also provide minimal
  validity checks.
- **handlr** ([Chamberlain 2022](#ref-handlr)): Tool for converting
  among citation formats, including `*.cff` files.
- **codemeta** ([Boettiger and Salmon 2021a](#ref-codemeta)) /
  **codemetar** ([Boettiger and Salmon 2021b](#ref-codemetar2021))
  provides similar solutions for creating `codemeta.json` file, another
  format for storing and sharing software metadata.

## Code of Conduct

Please note that the cffr project is released with a [Contributor Code
of Conduct](https://docs.ropensci.org/cffr/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.

## Citation

Hernangómez, D., (2021). cffr: Generate Citation File Format Metadata
for R Packages. Journal of Open Source Software, 6(67), 3900,
<https://doi.org/10.21105/joss.03900>

A BibTeX entry for LaTeX users is:

``` bibtex
@article{hernangomez2021,
    title        = {{cffr}: Generate Citation File Format Metadata for {R} Packages},
    author       = {Diego Hernangómez},
    year         = 2021,
    journal      = {Journal of Open Source Software},
    publisher    = {The Open Journal},
    volume       = 6,
    number       = 67,
    pages        = 3900,
    doi          = {10.21105/joss.03900},
    url          = {https://doi.org/10.21105/joss.03900}
}
```

You can also use the [citation provided by
GitHub](https://github.com/ropensci/cffr), that is generated from the
information of a `CITATION.cff` created with **cffr**. See [About
CITATION
files](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files)
for more info.

## References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-codemeta" class="csl-entry">

Boettiger, Carl, and Maëlle Salmon. 2021a.
*<span class="nocase">codemeta</span>: A Smaller
<span class="nocase">codemetar</span> Package*.
<https://CRAN.R-project.org/package=codemeta>.

</div>

<div id="ref-codemetar2021" class="csl-entry">

———. 2021b. *<span class="nocase">codemetar</span>: Generate ’CodeMeta’
Metadata for R Packages*.

</div>

<div id="ref-handlr" class="csl-entry">

Chamberlain, Scott. 2022. *<span class="nocase">handlr</span>: Convert
Among Citation Formats*.

</div>

<div id="ref-citation22" class="csl-entry">

Dietrich, Jan Philipp, and Waldir Leoncio. 2022.
*<span class="nocase">citation</span>: Software Citation Tools*.

</div>

<div id="ref-druskat_stephan_making_2021" class="csl-entry">

Druskat, Stephan. 2021. “Making Software Citation Easi(er) - The
Citation File Format and Its Integrations.”
<https://doi.org/10.5281/zenodo.5529914>.

</div>

<div id="ref-druskat_citation_2021" class="csl-entry">

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, Robert Haines,
James Baker, Spencer Bliven, Egon Willighagen, David Pérez-Suárez, and
Alexander Konovalov. 2021. “Citation File Format.”
<https://doi.org/10.5281/zenodo.5171937>.

</div>

<div id="ref-fenner2021" class="csl-entry">

Fenner, Martin. 2021. “We Need Your Feedback: Aligning the CodeMeta
Vocabulary for Scientific Software with Schema.org.”
<https://doi.org/10.5438/a49j-x692>.

</div>

<div id="ref-jones2017" class="csl-entry">

Jones, Matthew B, Carl Boettiger, Abby Cabunoc Mayes, Arfon Smith, Peter
Slaughter, Kyle Niemeyer, Yolanda Gil, et al. 2017. *CodeMeta: An
Exchange Schema for Software Metadata*. KNB Data Repository.
<https://doi.org/10.5063/SCHEMA/CODEMETA-2.0>.

</div>

<div id="ref-smith2021" class="csl-entry">

Smith, Arfon. 2021. “Enhanced Support for Citations on
GitHub.”[https://github.blog/news-insights/company-news/enhanced-support-citations-github/
](
		https://github.blog/news-insights/company-news/enhanced-support-citations-github/
	).

</div>

</div>
