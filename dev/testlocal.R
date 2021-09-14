# source("C:/Users/diego/Documents/R/Projects/cffr/dev/testlocal.R")


setwd("~/R/Projects/cffr")

# Load package
devtools::load_all()

# Delete first the snaps folder
unlink("./tests/testthat/test_local_installation/_snaps",
       recursive = TRUE
)

# Run the tests
testthat::test_dir("tests/testthat/test_local_installation")

