#' Error if it is not a `cff` file or object
#'
#' @param x A file to evaluate.
#' @noRd
abort_if_not_cff <- function(x, call = environment()) {
  if (is_cff(x)) {
    return(invisible())
  }

  # `x` should at least be a character vector.
  if (!inherits(x, "character")) {
    cli::cli_abort(
      paste(
        "{.arg x} must be a {.cls cff} object or a {.code *.cff} file path,",
        "not {.obj_type_friendly {x}}."
      ),
      call = call
    )
  }

  guess <- detect_x_source(x)

  if (guess != "cff_citation") {
    cli::cli_abort(
      c(
        "{.arg x} is not a {.code *.cff} file.",
        "i" = "Supply a {.cls cff} object or a {.code *.cff} file path."
      ),
      call = call
    )
  }
}

#' Throw an error if a file does not exist
#'
#' @param x A file to evaluate.
#' @param abort A logical value. If `TRUE`, throw an error when the file does
#'   not exist.
#' @noRd
file_exist_abort <- function(x, abort = FALSE, call = environment()) {
  res <- file.exists(x)

  if (all(abort, isFALSE(res))) {
    cli::cli_abort(
      c(
        "{.file {x}} does not exist.",
        "i" = "Check the {.path {dirname(x)}} directory."
      ),
      call = call
    )
  }
  invisible(res)
}

match_cff_arg <- function(arg, valid, for_msg, call = environment()) {
  arg <- as.character(arg)[1]
  valid <- as.character(valid)

  if (!arg %in% valid) {
    cli::cli_abort(
      "{.arg {for_msg}} must be {.or {.val {valid}}}, not {.val {arg}}.",
      call = call
    )
  }

  arg
}

write_lines_msg <- function(lines, file, verbose, append) {
  # Create the directory if it does not exist.
  dir <- dirname(path.expand(file))
  if (!dir.exists(dir)) {
    if (verbose) {
      cli::cli_alert_info("Creating directory {.path {dir}}.")
    }
    dir.create(dir, recursive = TRUE)
  }

  # Create a backup if the file already exists.
  if (file_exist_abort(file)) {
    backup <- cff_backup_path(file)
    copied <- cff_copy_backup(file, backup)
    if (!isTRUE(copied)) {
      cli::cli_abort(
        c(
          "Cannot back up {.file {file}}.",
          "i" = "The original file has not been modified."
        ),
        class = "cffr_error_backup"
      )
    }

    if (verbose) {
      cli::cli_alert_info(
        "Saved a backup of {.file {file}} as {.file {backup}}."
      )
    }
  }

  fh <- file(file, encoding = "UTF-8", open = ifelse(append, "a+", "w+"))
  on.exit(if (isOpen(fh)) close(fh))
  if (verbose) {
    cli::cli_alert_info("Writing {length(lines)} line{?s}.")
  }

  writeLines(lines, fh)
  if (verbose) {
    cli::cli_alert_success("Results written to {.file {file}}.")
  }
}

cff_backup_path <- function(file) {
  index <- 1L
  repeat {
    backup <- paste0(file, ".bk", index)
    if (!file.exists(backup)) {
      return(backup)
    }
    index <- index + 1L
  }
}

cff_copy_backup <- function(from, to) {
  file.copy(from, to, overwrite = FALSE)
}
