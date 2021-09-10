# Test on local installation

**This folder is included on `.Rbuildignore`**. 

These tests validates the creation of a `CITATION.cff` file for 
**a full set of >200 packages using github actions.**. The results can be checked on  https://github.com/dieghernan/cffr/tree/test/tests/testthat/test_local_installation/_snaps.

As the local installations differs across users and machines, the snapshot testing is expected to fail. However, the snapshots are quite useful for extensive tests and debugging, as well as for 
capturing corner cases.
 

For that reason, these tests are no run in **CRAN**.

Run the tests on this folder with 

```
# Write table of packages
installedall <- installed.packages()[, c("Package", "Version")]

writeLines(knitr::kable(installedall,
  row.names = FALSE,
  caption = "Installed packages on this session"
),
con = file.path(
  "tests", "testthat", "test_local_installation",
  "allpackages.md"
)
)

# Delete first the snaps folder
unlink("./tests/testthat/test_local_installation/_snaps",
  recursive = TRUE
)

# Run the tests
testthat::test_dir("tests/testthat/test_local_installation")

```
