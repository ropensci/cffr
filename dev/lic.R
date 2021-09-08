# Mapped to License
parse_desc_license <- function(pkg) {
  licenses <- pkg$get_field("License")

  # Clean up and split
  split <- unlist(strsplit(licenses, "\\| | \\+ |\\+"))

  # Clean leading and trailing blanks
  split <- gsub("^ | $", "", split)
  split <- unique(split)

  # Delete chunks with string FILE
  split <- split[-grep("file", split, ignore.case = TRUE)]

  licenses_df <- data.frame(LICENSE = split)

  # Read mapping
  cran_to_spdx <-
    read.csv(system.file("extdata/cran-to-spdx.csv", package = "cffr"))

  # Merge
  licenses_df <- merge(licenses_df, cran_to_spdx)

  # # Clean results
  # licenses_list <- lapply(licenses_df$SPDX, clean_str)
  # licenses_list <- drop_null(licenses_list)
  #
  # license_char <- unlist(licenses_list)
  # license_char
}
