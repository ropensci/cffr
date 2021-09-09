# Test on local installation

**This folder is included on `.Rbuildignore`**. 

These tests validates the creation of a `CITATION.cff` file for 
**a random sample of installed packages**. The max size of the sample is 500
and is chosen randomly on each run.

As the local installations differs, the snapshots are expected to fail. However,
they are quite useful for extensive tests and debugging, as well as for 
capturing corner cases.
 

The fail on the `snapshot` is expected, however the snapshot itself is useful
to get a summary of the performance of `cffr` on a extensive suite of packages.

For that reason, these tests are no run in **CRAN**.

Run the tests on this folder with 

```
# Delete first the snaps folder
unlink("./tests/testthat/test_local_installation/_snaps", 
       recursive = TRUE)

# Run the tests
testthat::test_dir("tests/testthat/test_local_installation")

```
