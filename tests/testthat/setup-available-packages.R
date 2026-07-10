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
  withr::local_options(
    cffr.available_packages = test_available_packages,
    .local_envir = env
  )
}

local_test_available_packages(testthat::teardown_env())
