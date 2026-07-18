local_mock_package <- function(
  description = "DESCRIPTION_basic",
  rbuildignore = FALSE,
  local_dir = TRUE,
  .local_envir = parent.frame()
) {
  path <- withr::local_tempdir(
    pattern = "mock-pack-",
    .local_envir = .local_envir
  )
  desc_src <- system.file("examples", description, package = "cffr")
  desc_dst <- file.path(path, "DESCRIPTION")

  if (!nzchar(desc_src)) {
    stop("Can't find example DESCRIPTION file: ", description, call. = FALSE)
  }
  if (!file.copy(desc_src, desc_dst) || !file.exists(desc_dst)) {
    stop("Can't create mock package DESCRIPTION.", call. = FALSE)
  }

  if (isTRUE(rbuildignore)) {
    rbuildignore_path <- file.path(path, ".Rbuildignore")
    if (!file.create(rbuildignore_path, showWarnings = FALSE)) {
      stop("Can't create mock package .Rbuildignore.", call. = FALSE)
    }
  }

  if (isTRUE(local_dir)) {
    withr::local_dir(path, .local_envir = .local_envir)
  }

  path
}
