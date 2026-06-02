#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
c.cff <- function(..., recursive = FALSE) {
  args <- list(...)
  args <- lapply(args, unclass)
  rval <- do.call("c", args)

  rval <- as.list(rval)
  # Reclass.
  as_cff(rval)
}

# Used for prettier printing when extracting elements.

# Based on the `person` method.
# https://github.com/wch/r-source/blob/trunk/src/library/utils/R/citation.R

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
`[.cff_ref_lst` <- function(x, i) {
  rval <- unclass(x)[i]
  class(rval) <- class(x[[i]])
  rval
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
`[.cff_pers_lst` <- function(x, i) {
  rval <- unclass(x)[i]
  class(rval) <- class(x[[i]])
  rval
}

# nolint start
#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.data.frame.cff <- function(x, row.names = NULL, optional = FALSE, ...) {
  # For better dispatching.
  x <- as_cff(as.list(x))

  ref_n <- names(x)

  df_l <- lapply(seq_along(x), function(y) {
    el <- x[[y]]
    nm <- cff_df_name(ref_n[y])

    if (nm == "preferred_citation") {
      return(as.data.frame(el, prefix = nm))
    }

    if (any(inherits(el, "cff_pers"), inherits(el, "cff_pers_lst"))) {
      return(as.data.frame(el, prefix = nm))
    }

    if (inherits(el, "cff_ref_lst")) {
      return(as.data.frame(el, prefix = nm))
    }

    if (length(el) > 1) {
      ltot <- length(el)
      df <- as.data.frame(matrix(el, nrow = 1))
      nm2 <- paste0(nm, ".", sprintf("%02d", seq_len(ltot) - 1))

      names(df) <- nm2
      return(df)
    }

    df <- as.data.frame(x[y])
    names(df) <- nm
    df
  })

  cff_df_bind(df_l, row.names = row.names, optional = optional, ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.data.frame.cff_pers_lst <- function(
  x,
  row.names = NULL,
  optional = FALSE,
  ...,
  prefix = "person"
) {
  cff_df_indexed(x, prefix, row.names, optional, ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.data.frame.cff_pers <- function(
  x,
  row.names = NULL,
  optional = FALSE,
  ...,
  prefix = NULL
) {
  # For better dispatching.
  x <- as_cff(as.list(x))

  vals <- unlist(x)
  nm <- cff_df_name(names(vals))
  amat <- matrix(vals, nrow = 1, ncol = length(vals))
  m <- as.data.frame(amat)

  nm <- cff_df_prefix(nm, prefix)

  names(m) <- nm
  m

  as.data.frame(m, row.names = row.names, optional = optional, ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.data.frame.cff_ref_lst <- function(
  x,
  row.names = NULL,
  optional = FALSE,
  ...,
  prefix = "references"
) {
  cff_df_indexed(
    x,
    prefix,
    row.names,
    optional,
    ...,
    element_args = list(row.names = row.names, optional = optional),
    element_dots = TRUE
  )
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.data.frame.cff_ref <- function(
  x,
  row.names = NULL,
  optional = FALSE,
  ...,
  prefix = NULL
) {
  # For better dispatching.
  # cff_ref is similar to cff, so add only the cff class.
  x <- as_cff(as.list(x))
  class(x) <- "cff"

  the_df <- as.data.frame(x)

  if (!is.null(clean_str(prefix))) {
    names(the_df) <- paste0(prefix, ".", names(the_df))
  }

  the_df
}

cff_df_indexed <- function(
  x,
  prefix,
  row.names,
  optional,
  ...,
  element_args = list(),
  element_dots = FALSE
) {
  # For better dispatching.
  x <- as_cff(as.list(x))
  dots <- list(...)

  df_l <- lapply(seq_along(x), function(y) {
    element_prefix <- cff_df_index_prefix(prefix, y)
    args <- c(list(x[[y]], prefix = element_prefix), element_args)
    if (element_dots) {
      args <- c(args, dots)
    }
    do.call(as.data.frame, args)
  })

  args <- c(
    list(df_l = df_l, row.names = row.names, optional = optional),
    dots
  )
  do.call(cff_df_bind, args)
}

cff_df_bind <- function(df_l, row.names = NULL, optional = FALSE, ...) {
  the_df <- do.call(cbind, df_l)
  as.data.frame(the_df, row.names = row.names, optional = optional, ...)
}

cff_df_index_prefix <- function(prefix, index) {
  paste0(prefix, ".", sprintf("%02d", index - 1))
}

cff_df_prefix <- function(nm, prefix) {
  if (!is.null(clean_str(prefix))) {
    return(paste0(prefix, ".", nm))
  }

  nm
}

cff_df_name <- function(nm) {
  gsub("-", "_", nm, fixed = TRUE)
}
# nolint end

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
head.cff <- function(x, n = 6L, ...) {
  as_cff(NextMethod())
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
tail.cff <- function(x, n = 6L, ...) {
  as_cff(NextMethod())
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.list.cff <- function(x, ...) {
  xl <- rapply(
    x,
    function(x) {
      if (is.list(x) || length(x) > 1) {
        return(unclass(x))
      }
      unclass(x)
    },
    how = "list"
  )

  as.list(xl)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
toBibtex.cff <- function(
  object,
  ...,
  what = c("preferred", "references", "all")
) {
  toBibtex(as_bibentry(object, what = what), ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
toBibtex.cff_ref_lst <- function(object, ...) {
  toBibtex(as_bibentry(object), ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
toBibtex.cff_ref <- function(object, ...) {
  toBibtex(as_bibentry(object), ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
toBibtex.cff_pers_lst <- function(object, ...) {
  toBibtex(as.person(object), ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
toBibtex.cff_pers <- function(object, ...) {
  toBibtex(as.person(object), ...)
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.person.cff_pers <- function(x) {
  # Enlist to dispatch to the next method.
  x_l <- list(as.list(x))
  as.person(as_cff(x_l))
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.person.cff_pers_lst <- function(x) {
  pers <- lapply(x, make_r_person)

  # Inform if not all were extracted.
  if (!all(lengths(pers) > 0)) {
    cli::cli_alert_info(
      "Cannot create {.cls person} for some elements of {.arg x}."
    )
  }
  end <- do.call(c, pers)
  if (anyDuplicated(end) > 0) {
    cli::cli_alert_info("Removing duplicate {.cls person} objects.")
    end <- end[!duplicated(end)]
  }
  end
}

# as.person methods not implemented ----

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.person.cff <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cff} method not implemented yet."
  )
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.person.cff_ref <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cff_ref} method not implemented yet."
  )
}

#' @export
#' @encoding UTF-8
#' @rdname cff_class
#' @usage NULL
as.person.cff_ref_lst <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cff_ref_lst} method not implemented yet."
  )
}
