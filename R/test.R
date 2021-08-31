rm(list = ls())

pkg <- system.file("DESCRIPTION", package = "dplyr")
msg <- "If you use this software, please cite it using these metadata."


abstract <- desc::desc_get("Description", file = pkg)

# Helper
clean_str <- function(str) {
  clean <- gsub("[\n\r]", " ", str)
  clean <- gsub("\\s+", " ", clean)

  clean
}
abstract <- clean_str(abstract)
abstract <- unname(abstract)


# End abstract


# Title
title <- paste0(desc::desc_get("Package", file = pkg),
                ": ",
                desc::desc_get("Title", file = pkg))

title <- clean_str(title)


# End title

# Author

auth <- desc::desc_get_author(role = c("aut"), file=pkg)

auth_yaml <- list()
for (i in seq_len(length(auth))){
 auth_yaml <- c(auth_yaml, list(list("family-names" = auth[i]$family,
                                "given-names" = auth[i]$given)))


}



# to yaml

citat <- yaml::as.yaml(
  list(
    "cff-version" = "1.2.0",
    message = msg,
    title = title,
    version = desc::desc_get("Version", pkg),
    authors = auth_yaml,
    abstract = abstract
  )
)

# Write CITATION
yaml::write_yaml(citat,"CITATION.cff")



# Now read it and modify it

valid <- readLines("CITATION.cff")
valid <- valid[-1]
valid <- gsub("^  ","", valid)
valid

writeLines(valid, "CITATION.cff")

