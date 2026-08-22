is_snapshot_env <- function() {
  grepl("^4.6", getRversion()) && isTRUE(l10n_info()[["UTF-8"]])
}

skip_if_not_snapshot_env <- function() {
  skip_if(!grepl("^4.6", getRversion()), "Snapshot created with R 4.6.*")
  skip_if(!isTRUE(l10n_info()[["UTF-8"]]), "Snapshot created with UTF-8 locale")
}
