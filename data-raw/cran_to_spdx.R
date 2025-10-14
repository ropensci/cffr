## code to prepare `cran_to_spdx` dataset goes here

# Run on 2024-07-23
library(ggplot2)
library(dplyr)

cran_packs <- as.data.frame(table(available.packages()[, "License"])) %>%
  arrange(desc(Freq)) %>%
  select(LICENSE = Var1, n = Freq) %>%
  as_tibble()

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

# Check on validator
validator <- jsonlite::read_json("inst/schema/schema.json")

licenses <- validator$definitions$`license-enum`$enum %>% unlist()

cran_to_spdx %>% filter(!(SPDX %in% licenses))


# Summary CRAN
mymap <- as.character(cran_packs$LICENSE)


devtools::load_all()

themap <- lapply(mymap, function(x) {
  message(x)

  licenses <- as.character(x)

  # The schema only accepts two LiCENSES max

  licenses <- unlist(strsplit(licenses, "\\| "))[1:2]

  # Clean up and split
  split <- unlist(strsplit(licenses, " \\+ |\\+"))

  # Clean leading and trailing blanks
  split <- unique(trimws(split))

  licenses_df <- data.frame(LICENSE = split)

  # Read mapping

  # Merge
  licenses_df <- merge(licenses_df, cran_to_spdx)

  # Clean results
  licenses_list <- lapply(licenses_df$SPDX, clean_str)
  licenses_list <- drop_null(licenses_list)

  license_char <- unlist(licenses_list)

  !is.null(license_char)
}) %>% unlist()


mapped_end <- cran_packs
mapped_end$captured <- themap

mapped_end %>%
  group_by(captured) %>%
  summarise(n = sum(n)) %>%
  mutate(porc = n / sum(n))

# Which packages I can't capture?

cran_db <- as.data.frame(available.packages()) %>%
  as_tibble() %>%
  mutate(LICENSE = License) %>%
  inner_join(mapped_end %>% filter(!captured))


cran_db[, c("Package", "License")] %>% as.data.frame()


usethis::use_data(cran_to_spdx, overwrite = TRUE)
