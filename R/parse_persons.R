parse_authors <- function(pkg) {
  auth <- pkg$get_authors()
  auth_yaml <- list()
  for (i in seq_len(length(auth))) {
    if ("aut" %in% auth[i]$role || "cre" %in% auth[i]$role) {
      auth_yaml <- c(auth_yaml, list(list(
        "family-names" = auth[i]$family,
        "given-names" = auth[i]$given
      )))
    }
  }
  auth_yaml
}
