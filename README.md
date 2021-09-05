
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cffr <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dieghernan/cffr/workflows/R-CMD-check/badge.svg)](https://github.com/dieghernan/cffr/actions)
[![codecov](https://codecov.io/gh/dieghernan/cffr/branch/master/graph/badge.svg)](https://codecov.io/gh/dieghernan/cffr)
[![CITATION-cff](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml/badge.svg)](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml)

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
also provided as BibTeX snippet which users can simply copy

## Installation

You can install the developing version of **cff** with:

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

This is a basic example which shows you how to create an `cffr` object:

``` r
library(cffr)

# Example with an installed package
test <- cff_create("ggplot2")
```

<details>

<summary> <strong>cffr object</strong></summary>

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    type: software
    license: MIT
    title: 'ggplot2: Create Elegant Data Visualisations Using the Grammar of Graphics'
    version: 3.3.5
    abstract: A system for 'declaratively' creating graphics, based on "The Grammar of
      Graphics". You provide the data, tell 'ggplot2' how to map variables to aesthetics,
      what graphical primitives to use, and it takes care of the details.
    authors:
    - family-names: Wickham
      given-names: Hadley
      email: hadley@rstudio.com
      orcid: https://orcid.org/0000-0003-4757-117X
    - family-names: Chang
      given-names: Winston
      orcid: https://orcid.org/0000-0002-1576-2126
    - family-names: Henry
      given-names: Lionel
    - family-names: Pedersen
      given-names: Thomas Lin
      email: thomas.pedersen@rstudio.com
      orcid: https://orcid.org/0000-0002-5147-4711
    - family-names: Takahashi
      given-names: Kohske
    - family-names: Wilke
      given-names: Claus
      orcid: https://orcid.org/0000-0002-7470-9261
    - family-names: Woo
      given-names: Kara
      orcid: https://orcid.org/0000-0002-5125-4188
    - family-names: Yutani
      given-names: Hiroaki
      orcid: https://orcid.org/0000-0002-3385-7233
    - family-names: Dunnington
      given-names: Dewey
      orcid: https://orcid.org/0000-0002-9415-4582
    repository-code: https://github.com/tidyverse/ggplot2
    url: https://ggplot2.tidyverse.org
    date-released: '2021-06-25'
    contact:
    - family-names: Pedersen
      given-names: Thomas Lin
      email: thomas.pedersen@rstudio.com
      orcid: https://orcid.org/0000-0002-5147-4711

</details>

We can validate the result using `cff_validate()`:

``` r

cff_validate(test)
#> 
#> cff_validate results-----
#> Congratulations! This cffr object is valid
```

By default most often from within your package folder you’ll simply run
`cffr::cff_write()`, that creates a `cffr` object, write it on a
`CITATION.cff` file and validates it on a single command.

Check the [docs](https://dieghernan.github.io/cffr/reference/index.html)
to learn how to work with `cffr` objects.

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
files](https://docs.github.com/es/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/about-citation-files)
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
