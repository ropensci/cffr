# Test on local installation

**This folder is included on `.Rbuildignore`.

These tests validates `cffr` objects created for **all the packages installed**.

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
