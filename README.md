
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cffr <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dieghernan/cffR/workflows/R-CMD-check/badge.svg)](https://github.com/dieghernan/cffR/actions)
[![codecov](https://codecov.io/gh/dieghernan/cffr/branch/master/graph/badge.svg)](https://codecov.io/gh/dieghernan/cffr)
[![CITATION-cff](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml/badge.svg)](https://github.com/dieghernan/cffr/actions/workflows/cff-validator.yml)
<!-- badges: end -->

The goal of cffr is to …

## Installation

You can install the released version of cffr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("cffr")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dieghernan/cffR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(cffr)
## basic example code
create_cff(find.package("jsonlite"))
```

That produces this output:

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    type: software
    title: 'jsonlite: A Simple and Robust JSON Parser and Generator for R'
    version: 1.7.2
    abstract: A reasonably fast JSON parser and generator, optimized for statistical data
      and the web. Offers simple, flexible tools for working with JSON in R, and is particularly
      powerful for building pipelines and interacting with a web API. The implementation
      is based on the mapping described in the vignette (Ooms, 2014). In addition to converting
      JSON data from/to R objects, 'jsonlite' contains functions to stream, validate,
      and prettify JSON data. The unit tests included with the package verify that all
      edge cases are encoded and decoded consistently for use with dynamic data in systems
      and applications.
    authors:
    - family-names: Ooms
      given-names: Jeroen
      email: jeroen@berkeley.edu
      orcid: https://orcid.org/0000-0002-4035-0289
    repository-code: https://github.com/jeroen/jsonlite
    url: https://arxiv.org/abs/1403.2805
    date-released: '2020-12-09'
    contact:
    - family-names: Ooms
      given-names: Jeroen
      email: jeroen@berkeley.edu
      orcid: https://orcid.org/0000-0002-4035-0289
