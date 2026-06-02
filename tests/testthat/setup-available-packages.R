test_available_packages <- data.frame(
  Package = c(
    "bibtex",
    "cli",
    "codemetar",
    "desc",
    "ggplot2",
    "jsonlite",
    "jsonvalidate",
    "knitr",
    "lifecycle",
    "MomTrunc",
    "options",
    "quarto",
    "quint",
    "resmush",
    "rmarkdown",
    "surveillance",
    "testthat",
    "usethis",
    "yaml"
  ),
  Repository = "https://cloud.r-project.org/src/contrib"
)

local_test_available_packages <- function(env = parent.frame()) {
  testthat::local_mocked_bindings(
    get_avail_on_init = function() test_available_packages,
    .package = "cffr",
    .env = env
  )
}

local_test_available_packages(testthat::teardown_env())
