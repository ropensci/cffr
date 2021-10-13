## code to prepare `cran_to_spdx` dataset goes here

# Run on 2021-10-13
library(ggplot2)
library(dplyr)

cran_packs <- as.data.frame(table(available.packages()[, "License"])) %>%
  arrange(desc(Freq)) %>%
  select(LICENSE = Var1, n = Freq)

# Add %
cran_packs$perc <- 100 * round(cran_packs$n / sum(cran_packs$n), 6)
cran_packs$cum <- 100 * cumsum(cran_packs$n) / sum(cran_packs$n)

# Write raw
write.csv(cran_packs,
  "inst/extdata/cran_licenses.csv",
  na = ""
)

# Top10
cran_packs[10, "cum"]

# Top20
cran_packs[20, "cum"]
sum(cran_packs[1:20, "n"])
paste0(cran_packs[1:20, ]$LICENSE, collapse = " | ")



# Extract all types of LICENSE

lic_string <- as.character(cran_packs$LICENSE)



# Split if needed
split <- unlist(strsplit(lic_string, "\\| | \\+ |\\+"))

# Clean leading and trailing blanks
split <- trimws(split)
split <- sort(unique(split))

split
# Delete chunks with string FILE
split <- split[-grep("file", split, ignore.case = TRUE)]


all_licenses <- data.frame(LICENSE = split)

write.csv2(all_licenses,
  "data-raw/cran_licenses.csv",
  row.names = FALSE
)

# Map manually on csv

# Once it is done, write to inst/extdata

cran_to_spdx <- read.csv2("data-raw/cran_licenses_mapped.csv")

# Check
cran_to_spdx %>% filter(!(LICENSE %in% all_licenses$LICENSE))





usethis::use_data(cran_to_spdx, overwrite = TRUE)
