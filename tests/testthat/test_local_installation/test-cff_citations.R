test_that("Test CITATION parsing of all installed packages", {
  expect_snapshot_output({
  
    installed <- installed.packages()[, "Package"]
    vers <- installed.packages()[, "Version"]

    

res <- c()
exists <- c()

for (i in 1:length(installed)){
  desc_path <- file.path(find.package(installed[i]), "DESCRIPTION")
  cit_path <- file.path(find.package(installed[i]), "CITATION")

  exist_cit <- ifelse(file.exists(cit_path), TRUE, FALSE)
  exists <- c(exists, exist_cit)
  
  if (exist_cit) {
        citmeta <- parse_r_citation(desc_path, cit_path)
        
        citobj <- lapply(citmeta, cff_parse_citation)
        cffobj <- cff_description(desc_path
    
    # Add cffobj

cffobj$doi <- clean_str(citobj[[1]]$doi)
  cffobjend <- c(cffobj,
    "preferred-citation" = citobj[1],
    references = list(citobj[-1])
  )



  # Add DOI to identifiers
  if (!is.null(cffobjend$doi)) {
    oldids <- cffobjend$identifiers
    cffobjend$identifiers <- c(
      list(list(type = "doi", value = cffobjend$doi)),
      oldids
    )
  }
  
  single <- suppressMessages(
  cff_validate(cffobjend))
  
    
    res <- c(res, single)
    

  } else {
    res <- c(res, NA)
  }
  pkg <- c(pkg, installed[i])

}

df <- data.frame(
      package = installed,
      version = vers,
      has_CITATION = exists,
      res = res
    )
    
    print_snapshot("Summary of installed packages", df)
    
    
  })
})
