# Test a local installation

**This folder is `.Rbuildignored`**.

This test validates CFF parsing for more than 1,500 packages:

- Core packages of every [**CRAN** Task
  View](https://cran.r-project.org/web/views/) and their dependencies.
- All the packages available in the [**rOpenSci**
  **r-universe**](https://ropensci.r-universe.dev/) and their dependencies.
- All packages from **R-Forge**, **r-lib** and **RStudio**, using lists extracted
  from <https://r-universe.dev/organizations/>.

This test is deployed in [**GitHub
Actions**](https://github.com/ropensci/cffr/actions/workflows/test-ci.yaml) and
the results are uploaded as a workflow report. We use **Windows**
and **macOS** here.

The test can be run locally with:

``` r
# Load the package.
devtools::load_all()

# Run the report.
source("tests/testthat/test_ci/test-new.R")
```
