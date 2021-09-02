## code to prepare `cran-to-spdx.csv`
# Run on 2021-09-02
library(ggplot2)
library(forcats)
library(dplyr)

cran_packs <- as.data.frame(table(available.packages()[, "License"])) %>%
  arrange(desc(Freq)) %>%
  select(LICENSE = Var1, n = Freq)


# Add %
cran_packs$porc <- round(cran_packs$n / sum(cran_packs$n), 6)
cran_packs$cum <- cumsum(cran_packs$n) / sum(cran_packs$n)

# Top10
cran_packs[10, "cum"]

# Top20
cran_packs[20, "cum"]
sum(cran_packs[1:20, "n"])
paste0(cran_packs[1:20, ]$LICENSE, collapse = " | ")



# Extract all types of LICENSE

lic_string <- as.character(cran_packs$LICENSE)

# Split if needed
split <- strsplit(lic_string, "\\| | \\+ |\\+")

# Clean leading and trailing blanks
split <- gsub("^ | $", "", split)
split <- unique(split)

# Delete chunks with string FILE
split <- split[-grep("file", split, ignore.case = TRUE)]
split <- split[order(split)]

all_licenses <- data.frame(LICENSE = split) %>%
  write.csv2("data-raw/cran_licenses.csv", row.names = FALSE)

# Map manually on csv

# Once it is done, write to inst/extdata

mapping <- readr::read_csv2("data-raw/cran_licenses_mapped.csv")

readr::write_csv(mapping, "inst/extdata/cran-to-spdx.csv", na = "")
