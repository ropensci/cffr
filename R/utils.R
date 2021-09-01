# Utils functions used on the package

# Clean strings
clean_str <- function(str) {
  clean <- gsub("[\n\r]", " ", str)
  clean <- gsub("\\s+", " ", clean)

  if (is.na(clean) || clean == "") {
    return(NULL)
  }

  clean
}

# Drop nulls from list
# From https://github.com/cboettig/codemeta/blob/master/R/utils.R
drop_null <- function(x) {
  x[lengths(x) != 0]
}
