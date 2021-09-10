# source("C:/Users/diego/Documents/R/Projects/cffr/dev/testlocal.R")

setwd("C:/Users/diego/Documents/R/Projects/cffr")

# Load package
devtools::load_all()

# Write table of packages
installedall <- installed.packages()[, c("Package", "Version")]

rownames(installedall) <- 1:nrow(installedall)


writeLines(knitr::kable(installedall,
                        caption = "Installed packages on this session",
                        row.names = TRUE),
           con = file.path(
             "tests", "testthat", "test_local_installation",
             "allpackages.md")
)

# Delete first the snaps folder
unlink("./tests/testthat/test_local_installation/_snaps",
       recursive = TRUE
)

# Run the tests
testthat::test_dir("tests/testthat/test_local_installation")

