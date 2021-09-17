# Test on local installation

**This folder is `.Rbuildignored`**.

This test validates the creation of a `CITATION.cff` file for \>1000 packages:

-   All the core packages of the [CRAN Task
    Views](https://cran.r-project.org/web/views/) and their dependencies.
-   All the packages available in the [rOpenSci
    r-universe](https://ropensci.r-universe.dev/) and their dependencies.
-   All the packages of r-forge, r-lib and r-studio: lists extracted from
    https://r-universe.dev/organizations/.

This test is deployed in [GitHub
Actions](https://github.com/dieghernan/cffr/actions/workflows/test-ci.yaml) and
the results are uploaded as an artifact. We use here Windows and MacOS binaries
for speeding up the process.

As the installations differs across users and machines, the snapshot testing is
expected to fail on a normal run. However, the snapshots are quite useful for
extensive tests and debugging, as well as for capturing corner cases. For that
reason, these tests are no run in **CRAN** or in the regular package development
workflow.

However, the test can be run locally with

``` r
# Load package
devtools::load_all()

# Run the tests
testthat::test_dir("tests/testthat/test_ci")
```
