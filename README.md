
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cffr <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dieghernan/cffr/actions/workflows/check-full.yaml/badge.svg)](https://github.com/dieghernan/cffr/actions/workflows/check-full.yaml)
[![codecov](https://codecov.io/gh/dieghernan/cffr/branch/master/graph/badge.svg)](https://codecov.io/gh/dieghernan/cffr)
[![CITATION-cff](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml/badge.svg)](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml)
[![DOI](https://img.shields.io/badge/DOI-10.5281/zenodo.5509766-blue)](https://doi.org/10.5281/zenodo.5509766)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
![GitHub code size in
bytes](https://img.shields.io/github/languages/code-size/dieghernan/cffr)
[![CodeFactor](https://www.codefactor.io/repository/github/dieghernan/cffr/badge)](https://www.codefactor.io/repository/github/dieghernan/cffr)
[![peer-review](https://badges.ropensci.org/463_status.svg)](https://github.com/ropensci/software-review/issues/463)
<!-- badges: end -->

[Citation File Format (CFF)](https://citation-file-format.github.io/)
(Druskat et al. 2021) (v1.2.0) are plain text files with human- and
machine-readable citation information for software (and datasets). Code
developers can include them in their repositories to let others know how
to correctly cite their software.

When you put a `CITATION.cff` file in the default branch of your GitHub
repository, it is automatically linked from the repository landing page,
and the citation information is rendered on the repository page, and
also provided as BibTeX snippet which users can simply copy.

**cffr** provides utilities to generate, parse, modify and validate
`CITATION.cff` files automatically for **R** packages, as well as tools
and examples for working with .cff more generally.

**cffr** maximizes the data extraction by using both the `DESCRIPTION`
file and the `CITATION` file (if present) of your package. Note that
**cffr** works best if your package pass
`R CMD check/devtools::check()`.

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

By default most often from within your package folder you’ll simply run
`cff_write()`, that creates a `cff` object, write it on a `CITATION.cff`
file and validates it on a single command.

However, **cffr** provides also custom print methods and mechanisms that
allows you to customize the `CITATION.cff` and integrate them in your
workflows.

This is a basic example which shows you how to create a `cff` object
(see `?cff` for more info). In this case, we are creating a `cff` object
from the metadata of the **rmarkdown** package:

``` r
library(cffr)

# Example with an installed package
test <- cff_create("rmarkdown")
```

<details>
<summary>
<code>CITATION.cff</code> for <strong>rmarkdown</strong>
</summary>

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
    repository: https://CRAN.R-project.org/package=rmarkdown
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
<p>
<p>
<p>

We can validate the result using `cff_validate()`:

``` r
cff_validate(test)
#> 
#> cff_validate results-----
#> Congratulations! This cff object is valid
```

Check the [docs](https://dieghernan.github.io/cffr/reference/index.html)
and `vignette(package = "cffr")` to learn how to work with `cff`
objects.

## Related packages

-   [**citation**](https://github.com/pik-piam/citation/): The
    development version (at the time of this writing) includes a new
    function `r2cff` that creates a `CITATION.cff` file (v1.1.0) using
    the information of your `DESCRIPTION` file. It also provide minimal
    validity checks.
-   [**handlr**](https://github.com/ropensci/handlr): Tool for
    converting among citation formats, including `*.cff` files. At the
    time of this writing only CFF v1.1.0 was supported (see
    [\#24](https://github.com/ropensci/handlr/issues/24)).
-   [**codemeta**](https://github.com/cboettig/codemeta)/
    [**codemetar**](https://github.com/ropensci/codemetar) provides
    similar solutions for creating `codemeta.json` file, another format
    for storing and sharing software metadata.

## Citation

To cite the **cffr** package in publications use:

``` r
print(citation("cffr"), bibtex = TRUE)
#> 
#> To cite cffr in publications use:
#> 
#>   Hernangómez, D. (2021). cffr: Generate Citation File Format ('cff')
#>   Metadata for R Packages. R package version 0.0.1.9003.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {cffr: Generate Citation File Format ('cff') Metadata for R Packages},
#>     author = {Diego Hernangómez},
#>     year = {2021},
#>     note = {R package version 0.0.1.9003},
#>     doi = {10.5281/zenodo.5509766},
#>     url = {https://dieghernan.github.io/cffr/},
#>   }
#> 
#> References:
#> 
#> Druskat S, Spaaks J, Chue Hong N, Haines R, Baker J, Bliven S,
#> Willighagen E, Pérez-Suárez D, Konovalov A (2021). "Citation File
#> Format." doi: 10.5281/zenodo.5171937 (URL:
#> https://doi.org/10.5281/zenodo.5171937).
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{,
#>     title = {{Citation File Format}},
#>     year = {2021},
#>     version = {1.2.0},
#>     month = {aug},
#>     author = {Stephan Druskat and Jurriaan H. Spaaks and Neil {Chue Hong} and Robert Haines and James Baker and Spencer Bliven and Egon Willighagen and David Pérez-Suárez and Alexander Konovalov},
#>     doi = {10.5281/zenodo.5171937},
#>     keywords = {citation file format, CFF, citation files, software citation, file format, YAML, software sustainability, research software, credit},
#>     license = {CC-BY-4.0},
#>     date-released = {2021-08-09},
#>   }
#> 
#> Wilson R (2016). "Encouraging citation of software - introducing
#> CITATION files." <URL:
#> https://www.software.ac.uk/blog/2016-10-06-encouraging-citation-software-introducing-citation-files>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{,
#>     author = {Robin Wilson},
#>     title = {Encouraging citation of software - introducing CITATION files.},
#>     year = {2016},
#>     month = {6},
#>     url = {https://www.software.ac.uk/blog/2016-10-06-encouraging-citation-software-introducing-citation-files},
#>   }
```

You can also use the [citation provided by
GitHub](https://github.com/dieghernan/cffr), that is generated from the
information of a `CITATION.cff` created with **cffr**. See [About
CITATION
files](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files)
for more info.

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Druskat_Citation_File_Format_2021" class="csl-entry">

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, Robert Haines,
James Baker, Spencer Bliven, Egon Willighagen, David Pérez-Suárez, and
Alexander Konovalov. 2021. “Citation File Format.”
<https://doi.org/10.5281/zenodo.5171937>.

</div>

</div>
