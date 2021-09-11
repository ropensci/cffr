# Test on local installation

**This folder is included on `.Rbuildignore`**. 

These tests validates the creation of a `CITATION.cff` file for 
**a full set of tests for all my installed packages (>800).**.

As the local installations differs across users and machines, the snapshot testing is expected to fail. 
However, the snapshots are quite useful for extensive tests and debugging, as well as for 
capturing corner cases. For that reason, these tests are no run in **CRAN**.

- Full list of packages: <https://github.com/dieghernan/cffr/blob/main/tests/testthat/test_local_installation/allpackages.csv>.
- Results: <https://github.com/dieghernan/cffr/tree/main/tests/testthat/test_local_installation/_snaps>
 


Run the tests on this folder with 

```

# Delete first the snaps folder
unlink("./tests/testthat/test_local_installation/_snaps",
       recursive = TRUE
)

# Run the tests
testthat::test_dir("tests/testthat/test_local_installation")

```
