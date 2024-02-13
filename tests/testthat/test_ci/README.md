# Test on local installation

**This folder is `.Rbuildignored`**.

This test validates the `cff` parsing for \>1500 packages:

-   Core packages of every [CRAN Task
    Views](https://cran.r-project.org/web/views/) and their dependencies.
-   All the packages available in the [rOpenSci
    r-universe](https://ropensci.r-universe.dev/) and their dependencies.
-   All the packages of r-forge, r-lib and r-studio: lists extracted from
    <https://r-universe.dev/organizations/>.

This test is deployed in [GitHub
Actions](https://github.com/ropensci/cffr/actions/workflows/test-ci.yaml) and
the results are uploaded as an report on the action itself. We use here Windows
and MacOS.

The test can be run locally with

``` r
# Load package
devtools::load_all()

# Run the report
source("tests/testthat/test_ci/test-new.R")
```
