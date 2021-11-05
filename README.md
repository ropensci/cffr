
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cffr <a href='https://docs.ropensci.org/cffr/'><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

[![CRAN-status](https://www.r-pkg.org/badges/version/cffr)](https://CRAN.R-project.org/package=cffr)
[![CRAN-results](https://cranchecks.info/badges/worst/cffr)](https://cran.r-project.org/web/checks/check_results_cffr.html)
[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/cffr?color=blue)](https://cran.r-project.org/package=cffr)
[![R-CMD-check](https://github.com/ropensci/cffr/actions/workflows/check-full.yaml/badge.svg)](https://github.com/ropensci/cffr/actions/workflows/check-full.yaml)
[![codecov](https://codecov.io/gh/ropensci/cffr/branch/main/graph/badge.svg?token=YRO3XL8RWK)](https://app.codecov.io/gh/ropensci/cffr)
[![r-universe](https://ropensci.r-universe.dev/badges/cffr)](https://ropensci.r-universe.dev/)
[![CITATION-cff](https://github.com/ropensci/cffr/actions/workflows/cff-validator.yml/badge.svg)](https://github.com/ropensci/cffr/actions/workflows/cff-validator.yml)
[![DOI](https://img.shields.io/badge/DOI-10.5281/zenodo.5509765-blue)](https://doi.org/10.5281/zenodo.5509765)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
![GitHub code size in
bytes](https://img.shields.io/github/languages/code-size/ropensci/cffr)
[![peer-review](https://badges.ropensci.org/463_status.svg)](https://github.com/ropensci/software-review/issues/463)

<!-- badges: end -->

## What is a `CITATION.cff` file?

[Citation File Format (CFF)](https://citation-file-format.github.io/)
(Druskat et al. 2021) (v1.2.0) are plain text files with human- and
machine-readable citation information for software (and datasets). Code
developers can include them in their repositories to let others know how
to correctly cite their software.

This format is becoming popular within the software citation ecosystem.
Recently
[GitHub](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files),
[Zenodo](https://twitter.com/ZENODO_ORG/status/1420357001490706442) and
[Zotero](https://twitter.com/zotero/status/1420515377390530560) have
included full support of this citation format (Druskat 2021). GitHub
support is of special interest:

*See [Customize your repository/About CITATION
files](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files)*

> When you add a CITATION.cff file to the default branch of your
> repository, it is automatically linked from the repository landing
> page. This makes it easy for other users to cite your software
> project, using the information you’ve provided.

<img src="vignettes/citation-link.png" title="citation-link" alt="citation-link" width="80%" style="display: block; margin: auto;" />

### Related projects

[The CodeMeta Project](https://codemeta.github.io/) (Jones et al. 2017)
creates a concept vocabulary that can be used to standardize the
exchange of software metadata across repositories and organizations. One
of the many uses of a `codemeta.json` file (created following the
standards defined on The CodeMeta Project) is to provide citation
metadata such as title, authors, publication year, and venue (Fenner
2021). The packages
[**codemeta**](https://github.com/cboettig/codemeta)/
[**codemetar**](https://github.com/ropensci/codemetar) allows to
generate `codemeta.json` files from R packages metadata.

## The cffr package

**cffr** provides utilities to generate, parse, modify and validate
`CITATION.cff` files automatically for **R** packages, as well as tools
and examples for working with .cff more generally.

**cffr** maximizes the data extraction by using both the `DESCRIPTION`
file and the `CITATION` file (if present) of your package. Note that
**cffr** works best if your package pass
`R CMD check/devtools::check()`.

### Installation

Install **cffr** from [CRAN](https://CRAN.R-project.org/package=cffr):

``` r
install.packages("cffr")
```

You can install the developing version of **cffr** with:

``` r
devtools::install_github("ropensci/cffr")
```

Alternatively, you can install **cffr** using the
[r-universe](https://ropensci.r-universe.dev/ui#builds):

``` r
# Enable this universe
options(repos = c(
  ropensci = "https://ropensci.r-universe.dev",
  CRAN = "https://cloud.r-project.org"
))

# Install some packages
install.packages("cffr")
```

### Example

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

Check the [docs](https://docs.ropensci.org/cffr/reference/index.html)
and `vignette(package = "cffr")` to learn how to work with `cff`
objects.

### Keep your `CITATION.cff` file up-to-date

The easiest way for keeping you `CITATION.cff` file up-tp-date is using
GitHub Actions. Use `cff_gha_update()`function to install a GitHub
Action that would update your `CITATION.cff` file on the following
events:

-   When you publish a new release of the package on your GitHub repo.
-   Each time that you modify your DESCRIPTION or inst/CITATION files.
-   The action can be run also manually.

``` r
cff_gha_update()

#> Installing update-citation-cff.yaml on './.github/workflows'
#> Adding .github to .Rbuildignore
```

See the example workflow file
[here](https://github.com/ropensci/cffr/blob/main/.github/workflows/update-citation-cff.yaml).

## Related packages

-   [**citation**](https://github.com/pik-piam/citation/): The
    development version (at the time of this writing) includes a new
    function `r2cff` that creates a `CITATION.cff` file (v1.1.0) using
    the information of your `DESCRIPTION` file. It also provide minimal
    validity checks.
-   [**handlr**](https://github.com/ropensci/handlr): Tool for
    converting among citation formats, including `*.cff` files. At the
    time of this writing only CFF v1.1.0 was supported (see
    [#24](https://github.com/ropensci/handlr/issues/24)).
-   [**codemeta**](https://github.com/cboettig/codemeta)/
    [**codemetar**](https://github.com/ropensci/codemetar) provides
    similar solutions for creating `codemeta.json` file, another format
    for storing and sharing software metadata.

## Citation

To cite the ‘cffr’ package in publications use:

Hernangómez D (2021). *cffr: Generate Citation File Format (‘cff’)
Metadata for R Packages*. doi: 10.5281/zenodo.5509765 (URL:
<https://doi.org/10.5281/zenodo.5509765>), R package version 0.1.0,
\<URL: <https://docs.ropensci.org/cffr/>\>.

A BibTeX entry for LaTeX users is

    #> @Manual{,
    #>   title = {cffr: Generate Citation File Format ('cff') Metadata for R Packages},
    #>   year = {2021},
    #>   note = {R package version 0.1.0},
    #>   version = {0.1.0},
    #>   author = {Diego Hernangómez},
    #>   doi = {10.5281/zenodo.5509765},
    #>   url = {https://docs.ropensci.org/cffr/},
    #> }

You can also use the [citation provided by
GitHub](https://github.com/ropensci/cffr), that is generated from the
information of a `CITATION.cff` created with **cffr**. See [About
CITATION
files](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files)
for more info.

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-making_software" class="csl-entry">

Druskat, Stephan. 2021. “<span class="nocase">Making software citation
easi(er) - The Citation File Format and its integrations</span>.”
Zenodo. <https://doi.org/10.5281/zenodo.5529914>.

</div>

<div id="ref-Druskat_Citation_File_Format_2021" class="csl-entry">

Druskat, Stephan, Jurriaan H. Spaaks, Neil Chue Hong, Robert Haines,
James Baker, Spencer Bliven, Egon Willighagen, David Pérez-Suárez, and
Alexander Konovalov. 2021. “Citation File Format.”
<https://doi.org/10.5281/zenodo.5171937>.

</div>

<div id="ref-aligning_codemeta" class="csl-entry">

Fenner, Martin. 2021. “Aligning the CodeMeta Vocabulary for Scientific
Software with <span class="nocase">schema.org</span>.”
<https://doi.org/10.5438/a49j-x692>.

</div>

<div id="ref-codemeta_2_0" class="csl-entry">

Jones, Matthew B., Carl Boettiger, Abby Cabunoc Mayes, Arfon Smith,
Peter Slaughter, Kyle Niemeyer, Yolanda Gil, et al. 2017. “CodeMeta: An
Exchange Schema for Software Metadata.”
<https://doi.org/10.5063/schema/codemeta-2.0>.

</div>

</div>
