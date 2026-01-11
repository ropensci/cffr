#' Error if it is not a `cff` file or object
#' @param x file to be evaluated
#' @noRd
abort_if_not_cff <- function(x) {
  if (is_cff(x)) {
    return(invisible())
  }

  # x should be character at least
  if (!inherits(x, "character")) {
    cli::cli_abort(
      "{.var x} is an object of class {.cls {class(x)}}, not {.cls cff}."
    )
  }

  guess <- detect_x_source(x)

  if (guess != "cff_citation") {
    cli::cli_abort(
      "{.var x} is not a {.file *.cff} file."
    )
  }
}

#' Error if file doesn't exists
#' @param x file to be evaluated
#' @param abort Throw an error if does not exist
#' @noRd
file_exist_abort <- function(x, abort = FALSE) {
  res <- file.exists(x)

  if (all(abort, isFALSE(res))) {
    cli::cli_abort(
      "{.file {x}} doesn't exist. Check the {.file {dirname(x)}} directory"
    )
  }
  invisible(res)
}

match_cff_arg <- function(arg, valid, for_msg, call = environment()) {
  arg <- as.character(arg)[1]
  valid <- as.character(valid)

  if (!arg %in% valid) {
    cli::cli_abort(
      "{.arg {for_msg}} should be {.or  {.val {valid}}}, not {.val {arg}}.",
      call = call
    )
  }

  arg
}

write_lines_msg <- function(lines, file, verbose, append) {
  # Check that the directory exists, if not create
  dir <- dirname(path.expand(file))
  if (!dir.exists(dir)) {
    if (verbose) {
      cli::cli_alert_info("Creating directory {.path {dir}}")
    }
    dir.create(dir, recursive = TRUE)
  }

  # If exists creates a backup
  if (file_exist_abort(file)) {
    for (i in seq(1, 100)) {
      f <- paste0(file, ".bk", i)
      if (!file_exist_abort(f)) break
    }

    if (verbose) {
      cli::cli_alert_info(
        "Creating a backup of {.file {file}} in {.file {f}}"
      )
    }
    file.copy(file, f)
  }

  fh <- file(file, encoding = "UTF-8", open = ifelse(append, "a+", "w+"))
  on.exit(if (isOpen(fh)) close(fh))
  if (verbose) {
    cli::cli_alert_info("Writing {length(lines[lines != ''])} entr{?y/ies} ...")
  }

  writeLines(lines, fh)
  if (verbose) {
    cli::cli_alert_success("Results written to {.file {file}}")
  }
}
