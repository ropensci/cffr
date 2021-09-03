
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cffr <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dieghernan/cffr/workflows/R-CMD-check/badge.svg)](https://github.com/dieghernan/cffr/actions)
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
cff_create(".")
```

That produces this output:

    cff-version: 1.2.0
    message: If you use this software, please cite it using these metadata.
    type: software
    license:
    - GPL-3.0-or-later
    - MIT
    title: 'demodescriptionfile: Demo Description File'
    version: 0.1.0
    abstract: This is demo description file. This file is used on examples and demos of
      the 'ccfr' package.
    authors:
    - family-names: Author
      given-names: First
      email: first.last@example.com
      orcid: https://orcid.org/0000-0001-8457-4658
    - family-names: Author
      given-names: Second
      email: second.last@example.com
      affiliation: An affiliation
      alias: nickname
    - name: I am an entity
      date-end: '2020-01-01'
    repository-code: https://github.com/dieghernan/demo/demo
    url: https://demo.github.io/demo/
    contact:
    - family-names: Author
      given-names: First
      email: first.last@example.com
      orcid: https://orcid.org/0000-0001-8457-4658
    - family-names: Author
      given-names: Second
      email: second.last@example.com
      affiliation: An affiliation
      alias: nickname
    - name: I am an entity
      date-end: '2020-01-01'
    keywords:
    - This
    - is
    - just
    - a
    - demo

We can validate it …
