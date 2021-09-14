
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cffr <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dieghernan/cffr/actions/workflows/check-full.yaml/badge.svg)](https://github.com/dieghernan/cffr/actions/workflows/check-full.yaml)
[![codecov](https://codecov.io/gh/dieghernan/cffr/branch/master/graph/badge.svg)](https://codecov.io/gh/dieghernan/cffr)
[![CITATION-cff](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml/badge.svg)](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
![GitHub code size in
bytes](https://img.shields.io/github/languages/code-size/dieghernan/cffr)
[![CodeFactor](https://www.codefactor.io/repository/github/dieghernan/cffr/badge)](https://www.codefactor.io/repository/github/dieghernan/cffr)

<!-- badges: end -->

[Citation File Format (CFF)](https://citation-file-format.github.io/)
(Druskat et al. 2021) are plain text files with human- and
machine-readable citation information for software (and datasets). Code
developers can include them in their repositories to let others know how
to correctly cite their software.

**cffr** provides utilities to generate, parse, modify and validate
`CITATION.cff` files automatically for R packages, as well as tools and
examples for working with .cff more generally.

When you put a `CITATION.cff` file in the default branch of your GitHub
repository, it is automatically linked from the repository landing page,
and the citation information is rendered on the repository page, and
also provided as BibTeX snippet which users can simply copy.

## Installation

You can install the developing version of **cffr** with:

``` r
devtools::install_github("dieghernan/cffr")
```

Alternatively, you can install **cffr** using the
[r-universe](https://dieghernan.r-universe.dev/ui#builds):

``` r
# Enable this universe
options(repos = c(
  dieghernan = "https://dieghernan.r-universe.dev",
  CRAN = "https://cloud.r-project.org"
))
install.packages("cffr")
```

## Example

This is a basic example which shows you how to create a `cff` object
(see `?cff` for more info):

``` r
library(cffr)

# Example with an installed package
test <- cff_create("rmarkdown")
```

<details>

<summary> <code>CITATION.cff</code> for
<strong>rmarkdown</strong></summary>

    cff-version: 1.2.0
    message: 'To cite package "rmarkdown" in publications use:'
    type: software
    license: GPL-3.0-only
    title: 'rmarkdown: Dynamic Documents for R'
    version: '2.11'
    abstract: Convert R Markdown documents into a variety of formats.
    authors:
    - family-names: Allaire
      given-names: JJ
      email: jj@rstudio.com
    - family-names: Xie
      given-names: Yihui
      email: xie@yihui.name
      orcid: https://orcid.org/0000-0003-0645-5666
    - family-names: McPherson
      given-names: Jonathan
      email: jonathan@rstudio.com
    - family-names: Luraschi
      given-names: Javier
      email: javier@rstudio.com
    - family-names: Ushey
      given-names: Kevin
      email: kevin@rstudio.com
    - family-names: Atkins
      given-names: Aron
      email: aron@rstudio.com
    - family-names: Wickham
      given-names: Hadley
      email: hadley@rstudio.com
    - family-names: Cheng
      given-names: Joe
      email: joe@rstudio.com
    - family-names: Chang
      given-names: Winston
      email: winston@rstudio.com
    - family-names: Iannone
      given-names: Richard
      email: rich@rstudio.com
      orcid: https://orcid.org/0000-0003-3925-190X
    preferred-citation:
      type: manual
      title: 'rmarkdown: Dynamic Documents for R'
      authors:
      - family-names: Allaire
        given-names: JJ
      - family-names: Xie
        given-names: Yihui
      - family-names: McPherson
        given-names: Jonathan
      - family-names: Luraschi
        given-names: Javier
      - family-names: Ushey
        given-names: Kevin
      - family-names: Atkins
        given-names: Aron
      - family-names: Wickham
        given-names: Hadley
      - family-names: Cheng
        given-names: Joe
      - family-names: Chang
        given-names: Winston
      - family-names: Iannone
        given-names: Richard
      year: '2021'
      url: https://github.com/rstudio/rmarkdown
    repository-code: https://github.com/rstudio/rmarkdown
    url: https://pkgs.rstudio.com/rmarkdown/
    date-released: '2021-09-14'
    contact:
    - family-names: Xie
      given-names: Yihui
      email: xie@yihui.name
      orcid: https://orcid.org/0000-0003-0645-5666
    references:
    - type: book
      title: 'R Markdown: The Definitive Guide'
      authors:
      - family-names: Xie
        given-names: Yihui
      - family-names: Allaire
        given-names: J.J.
      - family-names: Grolemund
        given-names: Garrett
      publisher:
        name: Chapman and Hall/CRC
      year: '2018'
      url: https://bookdown.org/yihui/rmarkdown
    - type: book
      title: R Markdown Cookbook
      authors:
      - family-names: Xie
        given-names: Yihui
      - family-names: Dervieux
        given-names: Christophe
      - family-names: Riederer
        given-names: Emily
      publisher:
        name: Chapman and Hall/CRC
      year: '2020'
      url: https://bookdown.org/yihui/rmarkdown-cookbook

</details>

We can validate the result using `cff_validate()`:

``` r
cff_validate(test)
#> 
#> cff_validate results-----
#> Congratulations! This cff object is valid
```

By default most often from within your package folder you’ll simply run
`cffr::cff_write()`, that creates a `cff` object, write it on a
`CITATION.cff` file and validates it on a single command.

Check the [docs](https://dieghernan.github.io/cffr/reference/index.html)
to learn how to work with `cff` objects.

## Citation

To cite the **cffr** package in publications use:

``` r
citation("cffr")
#> 
#> To cite cffr in publications use:
#> 
#>   Hernangómez, D. (2021). cffr: Generate Citation File Format ('cff')
#>   Metadata for R Packages. R package version 0.0.0.9000.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {cffr: Generate Citation File Format ('cff') Metadata for R Packages},
#>     author = {Diego Hernangómez},
#>     year = {2021},
#>     note = {R package version 0.0.0.9000},
#>     url = {https://dieghernan.github.io/cffr/},
#>   }
```

You can also use the [citation provided by
GitHub](https://github.com/dieghernan/cffr), that is generated from the
information of a `CITATION.cff` created with **cffr**. See [About
CITATION
files](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files)
for more info.

# References

<div id="refs" class="references">

<div id="ref-Druskat_Citation_File_Format_2021">

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, Robert Haines,
James Baker, Spencer Bliven, Egon Willighagen, David Pérez-Suárez, and
Alexander Konovalov. 2021. “Citation File Format.”
<https://doi.org/10.5281/zenodo.5171937>.

</div>

</div>
