rm(list = ls())

root <- "inst/examples/DESCRIPTION_plainauthors"
#desc::desc_coerce_authors_at_r()

#root <- system.file("DESCRIPTION", package="dplyr")
msg <- "If you use this software, please cite it using these metadata."

pkg <- desc::desc(root)

pkg$coerce_authors_at_r()



abstract <- pkg$get("Description")

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
title <- paste0(pkg$get("Package"),
                ": ",
                pkg$get("Title"))

title <- clean_str(title)


# End title

# Author

auth <- pkg$get_authors()
# Fix this

# desc::desc_get_authors(file=pkg)
# a <- citation("dplyr")
# b <- print(a, style = "R")
# f <- as.list(unclass(a[1]))[[1]]
#
# attributes(f)$bibtype


auth_yaml <- list()
for (i in seq_len(length(auth))){
  if ("aut" %in% auth[i]$role || "cre" %in% auth[i]$role){

 auth_yaml <- c(auth_yaml, list(list("family-names" = auth[i]$family,
                                "given-names" = auth[i]$given)))

}
}
auth_yaml


# to yaml

citat <- yaml::as.yaml(
  list(
    "cff-version" = "1.2.0",
    message = msg,
    title = title,
    version = pkg$get("Version"),
    authors = auth_yaml,
    abstract = abstract
  )
)

citat
# Write CITATION
yaml::write_yaml(citat,"CITATION.cff")



# Now read it and modify it

valid <- readLines("CITATION.cff")
valid <- valid[-1]
valid <- gsub("^  ","", valid)
valid

writeLines(valid, "CITATION.cff")


# Validation

f <- yaml::read_yaml("CITATION.cff")

jsonlite::write_json(f, "test.json", pretty = TRUE)
download.file("https://raw.githubusercontent.com/citation-file-format/citation-file-format/main/schema.json",
              "schema.json", mode="wb", quiet = TRUE)

a <- readLines("test.json")
a <- gsub('["','"', a, fixed = TRUE)
a <- gsub('"]','"', a, fixed = TRUE)
writeLines(a, "test.json")
jsonvalidate::json_validate("test.json", "schema.json", verbose = TRUE)

rm(list = ls())

