installed <- installed.packages()[,"Package"]

res <- c()
pkg <- c()
exists <- c()
for (i in 1:length(installed)){
  desc_path <- file.path(find.package(installed[i]), "DESCRIPTION")
  cit_path <- file.path(find.package(installed[i]), "CITATION")

  exist_cit <- ifelse(file.exists(cit_path), TRUE, FALSE)
  exists <- c(exists, exist_cit)
  if (file.exists(cit_path)){
    f <- parse_r_citation(desc_path, cit_path)
    res <- c(res, !is.null(f))


  } else {
    res <- c(res, TRUE)
  }
  pkg <- c(pkg, installed[i])

}

df <- data.frame(pkg = pkg, exists = exists, res = res)


rcmdcheck::rcmdcheck(args=c("--as-cran"))
