#' Coerce lists, `person` and `bibentry` objects to [`cff`]
#'
#' @description
#' `as_cff()` turns an existing list-like **R** object into a so-called
#' [`cff`], a list with class `cff`, with the corresponding
#' [sub-class][cff_class] if applicable, .
#'
#' `as_cff` is an S3 generic, with methods for:
#' - `person` objects as produced by [utils::person()].
#' - `bibentry` objects as produced by [utils::bibentry()].
#' - `Bibtex` object as produced by [toBibtex()].
#' -  Default: Other inputs are first coerced with [as.list()].
#'
#' @param x A `person`, `bibentry` or other object that could be coerced to a
#'   list.
#' @param ... Additional arguments to be passed on to other methods.
#'
#' @rdname as_cff
#'
#' @returns
#'
#' - `as_cff.person()` returns an object with classes
#'   [`cff_pers_lst, cff`][cff_pers_lst].
#' - `as_cff.bibentry()` and `as_cff.Bibtex()` returns an object with classes
#'   [`cff_ref_lst, cff`][cff_ref_lst].
#' * The rest of methods returns usually an object of class `cff`. However if
#'   `x` have an structure compatible with `definitions.person`,
#'   `definitions.entity` or `definitions.reference` the object would have the
#'   corresponding subclass.
#'
#' Learn more about the \CRANpkg{cffr} class system in [cff_class].
#'
#' @family s3method
#'
#' @details
#' For `as_cff.bibentry()` / `as_cff.Bibtex()` see
#' `vignette("bibtex_cff", "cffr")` to understand how the mapping is performed.
#'
#' [as_cff_person()] is preferred over `as_cff.person()`, since it can handle
#' `character` person such as `"Davis, Jr., Sammy"`. For `person` objects both
#' functions are similar.
#'
#' @seealso
#' - [cff()]: Create a full `cff` object from scratch.
#' - [cff_modify()]: Modify a `cff` object.
#' - [cff_create()]: Create a `cff` object of a **R** package.
#' - [cff_read()]: Create a `cff` object from a external file.
#' - [as_cff_person()]: Recommended way for creating persons in CFF format.
#'
#' Learn more about the \CRANpkg{cffr} class system in [cff_class].
#'
#' @export
#'
#' @examples
#'
#' # Convert a list to "cff" object
#' cffobj <- as_cff(list(
#'   "cff-version" = "1.2.0",
#'   title = "Manipulating files"
#' ))
#'
#' class(cffobj)
#'
#' # Nice display thanks to yaml package
#' cffobj
#'
#' # bibentry method
#' a_cit <- citation("cffr")[[1]]
#'
#' a_cit
#'
#' as_cff(a_cit)
#'
#' # Bibtex method
#' a_bib <- toBibtex(a_cit)
#'
#' a_bib
#'
#' as_cff(a_cit)
#'
as_cff <- function(x, ...) {
  UseMethod("as_cff")
}

#' @rdname as_cff
#' @export
as_cff.default <- function(x, ...) {
  as_cff(as.list(x), ...)
}


#' @rdname as_cff
#' @export
as_cff.list <- function(x, ...) {
  # Clean up empty values on top
  clean_up <- vapply(x, is.null, FUN.VALUE = logical(1))
  x_clean <- x[!clean_up]
  new_cff(x_clean)
}

#' @rdname as_cff
#' @export
as_cff.person <- function(x, ...) {
  as_cff_person(x)
}


#' @rdname as_cff
#' @export
as_cff.bibentry <- function(x, ...) {
  cff_ref <- as_cff_reference(x)
  clean_up <- vapply(cff_ref, is.null, FUN.VALUE = logical(1))
  if (all(clean_up)) {
    return(NULL)
  }

  cff_refs <- as_cff(cff_ref, ...)

  # Add clases
  cff_refs_class <- lapply(cff_refs, function(x) {
    class(x) <- c("cff_ref", "cff")
    x
  })

  class(cff_refs_class) <- c("cff_ref_lst", "cff")
  cff_refs_class
}

#' @rdname as_cff
#' @export
as_cff.Bibtex <- function(x, ...) {
  tmp <- tempfile(fileext = ".bib")
  writeLines(x, tmp)
  abib <- cff_read_bib(tmp)
  cff_refs <- as_cff(abib, ...)

  # Add clases
  cff_refs_class <- lapply(cff_refs, function(x) {
    class(x) <- c("cff_ref", "cff")
    x
  })

  class(cff_refs_class) <- c("cff_ref_lst", "cff")
  cff_refs_class
}

# nolint start
#' @export
#' @rdname as_cff
#' @usage NULL
as.cff <- function(x) {
  as_cff(x)
}
# nolint end

# Helper----

#' Recursively clean lists
#'
#'
#' @noRd
rapply_drop_null <- function(x) {
  if (is.list(x) && length(x) > 0) {
    x <- drop_null(x)
    x <- lapply(x, rapply_drop_null)
    return(x)
  } else {
    return(x)
  }
}


rapply_class <- function(x) {
  if (is_named(x)) x <- x[!duplicated(names(x))]

  xend <- lapply(x, function(el) {
    xelement <- el
    guess <- guess_cff_part(xelement)

    if (guess %in% c("unclear", "cff_full")) {
      return(xelement)
    }

    if (guess == "cff_pers_lst") {
      xelement <- lapply(xelement, function(j) {
        j_in <- j
        class(j_in) <- c("cff_pers", "cff")
        j_in
      })
      class(xelement) <- c("cff_pers_lst", "cff")
    }

    if (guess == "cff_ref_lst") {
      xelement <- lapply(xelement, function(j) {
        j_in <- rapply_class(j)
        class(j_in) <- c("cff_ref", "cff")
        j_in
      })
      class(xelement) <- c("cff_ref_lst", "cff")
    }

    if (guess %in% c("cff_ref", "cff_pers")) {
      xin <- rapply_class(xelement)
      class(xin) <- c(guess, "cff")
      xelement <- xin
    }
    return(xelement)
  })
  xend
}

# https://adv-r.hadley.nz/s3.html#s3-constructor
# Constructor
new_cff <- function(x) {
  # Clean all strings recursively

  x <- rapply(x, function(x) {
    if (is.list(x) || length(x) > 1) {
      return(x)
    }
    return(clean_str(x))
  },
  how = "list"
  )

  # Remove NULLs
  x <- drop_null(x)

  # Remove duplicated names if named
  if (is_named(x)) x <- x[!duplicated(names(x))]

  # Now apply drop null to nested lists
  x <- lapply(x, rapply_drop_null)

  # Reclass nested
  guess_x <- guess_cff_part(x)
  if (guess_x == "cff_ref_lst") {
    x2 <- lapply(x, function(j) {
      j2 <- rapply_class(j)
      class(j2) <- c("cff_ref", "cff")
      j2
    })
    class(x2) <- c(guess_x, "cff")
    return(x2)
  }

  xend <- rapply_class(x)

  final_class <- switch(guess_x,
    "cff_full" = "cff",
    "unclear" = "cff",
    c(guess_x, "cff")
  )

  if (!is.null(final_class)) {
    class(xend) <- final_class
  }

  xend
}
