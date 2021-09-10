test_that("Test citations with installed packages", {
  installed <- as.character(installed.packages()[, 1])
  inst <- c(
    "base", "utils", "jsonlite", "jsonvalidate", "rmarkdown",
    "rgeos", "urltools", "thisisanerrorpackage"
  )
  for (i in seq_len(length(inst))) {
    if (inst[i] %in% installed) {
      print(paste("Testing", inst[i]))
      desc <- file.path(find.package(inst[i]))
      desc_cff <- cff_description(file.path(desc, "DESCRIPTION"))
      cit <- cff_parse_citation(citation(inst[i]))
      full <- as.cff(c(desc_cff, list("preferred-citation" = cit)))
      expect_true(cff_validate(full))
    }
  }
})

test_that("Add wrong field to citation", {
  bib <- bibentry(
    bibtype = "InProceedings",
    booktitle = "Some Title",
    title = "Bootstrap Methods and Their Applications",
    author = as.person("Anthony C. Davison [aut], David V. Hinkley [aut]"),
    year = "1997",
    publisher = person(given = "Cambridge University Press", comment = c("address" = "Madrid")),
    # translators = "Juan Tenorio",
    address = "Cambridge",
    url = "http://statwww.epfl.ch/davison/BMA/",
    key = "boot-book",
    type = "errortype",
    favorite_food = "bananas"
  )

  cffobj <- cff_create("jsonlite", keys = list(references = list(cff_parse_citation(
    bib
  ))))


  expect_true(cff_validate(cffobj))
})
