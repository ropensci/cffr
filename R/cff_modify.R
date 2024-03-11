#' Modify a [`cff`] object
#'
#' Add new keys or modify existing ones on a [`cff`] object.
#'
#' @param x A [`cff`] object.
#' @param ... Named arguments to be used for modifying `x`. See also `...`
#'   argument in [cff()].
#'
#' @details
#'
#' Keys provided in `...` would override the corresponding key in `x`.
#'
#' @returns
#'
#' A [`cff`] object.
#'
#' @family core
#' @export
#' @seealso
#' This function is wrapper of [utils::modifyList()].
#'
#' See [cff()] for creating [`cff`] objects from scratch.
#'
#' @details
#'
#' It is possible to add additional keys not detected by [cff_create()] using
#' the `keys` argument. A list of valid keys can be retrieved with
#' [cff_schema_keys()]. Please refer to
#' ```{r, echo=FALSE, results='asis'}
#'
#' cat(paste0("\n", "[Guide to Citation File Format schema version 1.2.0]",
#'            "(https://github.com/citation-file-format/",
#'            "citation-file-format/blob/main/schema-guide.md)."))
#'
#'
#' ```
#' for additional details.
#'
#' @examples
#' x <- cff()
#' x
#'
#' cff_validate(x)
#'
#'
#' x_mod <- cff_modify(x,
#'   contact = as_cff_person("A contact"),
#'   message = "This overwrites fields",
#'   title = "New Title",
#'   abstract = "New abstract",
#'   doi = "10.21105/joss.03900"
#' )
#'
#' x_mod
#'
#' cff_validate(x_mod)
#'
cff_modify <- function(x, ...) {
  if (!inherits(x, "cff")) {
    cli::cli_abort(
      "{.arg x} should be a {.cls cff} object, not {.cls {class(x)}}."
    )
  }
  new_keys <- list(...)
  if (length(new_keys) == 0) {
    cli::cli_alert_info("Args {.arg ...} empty. Returning {.arg x}.")
    return(x)
  }

  modify_cff(x, new_keys, "...")
}

modify_cff <- function(x, keys, argname = "...") {
  # Don't throw message here, these cases are coming from cff_create
  if (all(argname == "keys", length(keys) == 0)) {
    return(x)
  }

  new_keys <- validate_extra_keys(keys, argname)
  new_keys <- fuzzy_keys(new_keys)
  if (any(duplicated(names(new_keys)))) {
    cli::cli_alert_warning("Removing duplicated keys.")
    new_keys <- new_keys[!duplicated(names(new_keys))]
  }

  init_ord <- names(x)

  xmod <- x[setdiff(names(x), names(new_keys))]
  xend <- modifyList(xmod, new_keys, keep.null = FALSE)

  # Name order
  sorted_nm <- unique(c(init_ord, names(xend)))

  # Relist and add classes
  xend <- as.list(xend[sorted_nm])
  as_cff(xend)
}


# Check names
validate_extra_keys <- function(cffobj, argname = "...") {
  has_names <- names(cffobj)
  if (is.null(has_names)) {
    cli::cli_abort(
      "Elements in {.arg {argname}} should be named."
    )
  }

  if (any(has_names == "")) {
    # nolint start
    # For printing only
    index <- as.character(which(has_names %in% ""))
    # nolint end

    cli::cli_alert_warning(
      "Found {length(index)} not-named argument{?s} in position{?s} {index}."
    )
    cli::cli_alert_info("Removing unnamed arguments")
    cffobj <- cffobj[has_names != ""]
  }
  cffobj
}
