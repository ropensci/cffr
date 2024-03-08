#' @export
#' @rdname cff_class
#' @usage NULL
print.cff <- function(x, ...) {
  cat(yaml::as.yaml(x))
}

#' @export
#' @rdname cff_class
#' @usage NULL
c.cff <- function(..., recursive = FALSE) {
  args <- list(...)
  args <- lapply(args, unclass)
  rval <- do.call("c", args)
  class(rval) <- "cff"
  rval
}


# nolint start
#' @export
#' @rdname cff_class
#' @usage NULL
as.data.frame.cff <- function(x, row.names = NULL, optional = FALSE, ...) {
  # For better dispatching
  x <- as_cff(as.list(x))

  len <- length(x)
  key_len <- seq_len(len)
  ref_n <- names(x)

  df_l <- lapply(key_len, function(y) {
    el <- x[[y]]
    nm <- ref_n[y]
    nm <- gsub("-", "_", nm)

    if (nm == "preferred_citation") {
      return(as.data.frame(el, prefix = nm))
    }

    if (any(inherits(el, "cffpers"), inherits(el, "cffperslist"))) {
      return(as.data.frame(el, prefix = nm))
    }

    if (inherits(el, "cffreflist")) {
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

  the_df <- do.call(cbind, df_l)

  as.data.frame(the_df, row.names = row.names, optional = optional, ...)
}

#' @export
#' @rdname cff_class
#' @usage NULL
as.data.frame.cffperslist <- function(x, row.names = NULL, optional = FALSE,
                                      ..., prefix = "person") {
  # For better dispatching
  x <- as_cff(as.list(x))

  len <- length(x)
  key_len <- seq_len(len)

  df_l <- lapply(key_len, function(y) {
    prefix <- paste0(prefix, ".", sprintf("%02d", y - 1))
    el <- x[[y]]
    df <- as.data.frame(el, prefix = prefix)
    df
  })

  the_df <- do.call(cbind, df_l)

  as.data.frame(the_df, row.names = row.names, optional = optional, ...)
}

#' @export
#' @rdname cff_class
#' @usage NULL
as.data.frame.cffpers <- function(x, row.names = NULL, optional = FALSE,
                                  ..., prefix = NULL) {
  # For better dispatching
  x <- as_cff(as.list(x))

  vals <- unlist(x)
  nm <- names(vals)
  nm <- gsub("-", "_", nm)
  amat <- matrix(vals, nrow = 1, ncol = length(vals))
  m <- as.data.frame(amat)

  if (!is.null(clean_str(prefix))) nm <- paste0(prefix, ".", nm)

  names(m) <- nm
  m

  as.data.frame(m, row.names = row.names, optional = optional, ...)
}


#' @export
#' @rdname cff_class
#' @usage NULL
as.data.frame.cffreflist <- function(x, row.names = NULL, optional = FALSE,
                                     ..., prefix = "references") {
  # For better dispatching
  x <- as_cff(as.list(x))

  len <- length(x)
  key_len <- seq_len(len)

  df_l <- lapply(key_len, function(y) {
    prefix <- paste0(prefix, ".", sprintf("%02d", y - 1))
    el <- x[[y]]
    df <- as.data.frame(el,
      row.names = row.names, optional = optional,
      ..., prefix = prefix
    )
    df
  })

  the_df <- do.call(cbind, df_l)

  as.data.frame(the_df, row.names = row.names, optional = optional, ...)
}


#' @export
#' @rdname cff_class
#' @usage NULL
as.data.frame.cffref <- function(x, row.names = NULL, optional = FALSE,
                                 ..., prefix = NULL) {
  # For better dispatching
  # cffref is similar to cff, so we add only cff class
  x <- as_cff(as.list(x))
  class(x) <- "cff"

  the_df <- as.data.frame(x)

  if (!is.null(clean_str(prefix))) {
    names(the_df) <- paste0(prefix, ".", names(the_df))
  }

  the_df
}
# nolint end

#' @export
#' @rdname cff_class
#' @usage NULL
head.cff <- function(x, n = 6L, ...) {
  as_cff(NextMethod())
}

#' @export
#' @rdname cff_class
#' @usage NULL
tail.cff <- function(x, n = 6L, ...) {
  as_cff(NextMethod())
}


#' @export
#' @rdname cff_class
#' @usage NULL
as.list.cff <- function(x, ...) {
  xl <- rapply(x, function(x) {
    if (is.list(x) || length(x) > 1) {
      return(unclass(x))
    }
    return(unclass(x))
  },
  how = "list"
  )

  as.list(xl)
}

#' @export
#' @rdname cff_class
#' @usage NULL
toBibtex.cff <- function(object, ...,
                         what = c("preferred", "references", "all")) {
  toBibtex(as_bibentry(object, what = what), ...)
}

#' @export
#' @rdname cff_class
#' @usage NULL
toBibtex.cffreflist <- function(object, ...) {
  toBibtex(as_bibentry(object), ...)
}

#' @export
#' @rdname cff_class
#' @usage NULL
toBibtex.cffref <- function(object, ...) {
  toBibtex(as_bibentry(object), ...)
}

#' @export
#' @rdname cff_class
#' @usage NULL
toBibtex.cffperslist <- function(object, ...) {
  toBibtex(as.person(object), ...)
}

#' @export
#' @rdname cff_class
#' @usage NULL
toBibtex.cffpers <- function(object, ...) {
  toBibtex(as.person(object), ...)
}

#' @export
#' @rdname cff_class
#' @usage NULL
as.person.cffpers <- function(x) {
  # Enlist to dispatch to Next method
  x_l <- list(as.list(x))
  as.person(as_cff(x_l))
}

#' @export
#' @rdname cff_class
#' @usage NULL
as.person.cffperslist <- function(x) {
  pers <- lapply(x, make_r_person)

  # If not all extracted inform
  if (!all(lengths(pers) > 0)) {
    cli::cli_alert_info(
      "Can't create {.cls person} for some elements of {.arg x}."
    )
  }
  end <- do.call(c, pers)
  if (any(duplicated(end))) {
    cli::cli_alert_info("Removing duplicate {.cls person} objects.")
    end <- end[!duplicated(end)]
  }
  end
}


#  as.person methods not implemented ----

#' @export
#' @rdname cff_class
#' @usage NULL
as.person.cff <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cff} method not implemented yet."
  )
}

#' @export
#' @rdname cff_class
#' @usage NULL
as.person.cffref <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cffref} method not implemented yet."
  )
}

#' @export
#' @rdname cff_class
#' @usage NULL
as.person.cffreflist <- function(x) {
  cli::cli_abort(
    "({.pkg cffr}) {.fn as.person.cffreflist} method not implemented yet."
  )
}
