## code to prepare `crosswalk_tables.csv`
library(tidyverse)
df <- openxlsx::read.xlsx("data-raw/crosswalk_tables.xlsx")

unlink("/inst/extdata/crosswalk_tables.csv")
lapply(df, trimws) %>%
  bind_rows() %>%
  setNames(names(df)) %>%
  write.csv("./inst/extdata/crosswalk_tables.csv", row.names = FALSE)

cli::cli_alert_success("Excel updated")

#
# lapply(df, trimws) %>%
#   bind_rows() %>%
#   setNames(names(df)) %>%
#   openxlsx::write.xlsx("data-raw/crosswalk_tables.xlsx", overwrite = TRUE)
