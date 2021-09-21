# nocov start


# Detect repos onLoad
.onLoad <- function(libname, pkgname) {
  avail_on_init <- as.data.frame(
    available.packages(
      repos = detect_repos(),
    )
  )[, c("Package", "Repository")]


  assign("avail_on_init", avail_on_init, envir = parent.env(environment()))
}

# nocov end
