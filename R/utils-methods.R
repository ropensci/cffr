# Utils for df ----
unnamed_to_df <- function(key, nm) {
  key_l <- as.integer(lengths(key))
  m <- matrix(unlist(key), nrow = 1)
  df <- as.data.frame(m)
  names(df) <- paste0(nm, ".", sprintf("%02d", seq_len(key_l) - 1))
  return(df)
}

named_to_df <- function(key, nm) {
  key_un <- unlist(key)


  m <- matrix(as.character(key_un), nrow = 1)
  df <- as.data.frame(m)
  names(df) <- names(key_un)
  return(df)
}

nested_named_to_df <- function(key, nm) {
  key_unlist <- key[[1]]
  key_len <- seq_len(length(key_unlist))

  df_l_type3 <- lapply(key_len, function(z) {
    df <- cff_to_df(key_unlist[[z]])

    # Prepend names
    names(df) <- paste0(nm, ".", sprintf("%02d", z - 1), ".", names(df))
    return(df)
  })

  df_list_to_df(df_l_type3)
}

prefcit_to_df <- function(key, nm = "preferred_citation.") {
  key_df <- cff_to_df(key[[1]])
  names(key_df) <- paste0(nm, names(key_df))
  return(key_df)
}

reflist_to_df <- function(key, nm) {
  key_unlist <- key[[1]]
  key_len <- seq_len(length(key_unlist))

  prefix_key <- paste0(nm, ".", sprintf("%02d", key_len - 1), ".")

  df_l <- lapply(key_len, function(y) {
    key_l <- key_unlist[y]
    nm_pref <- prefix_key[y]

    dff <- prefcit_to_df(key_l, nm_pref)

    dff
  })

  final_df <- df_list_to_df(df_l)

  final_df
}

df_list_to_df <- function(x) {
  # Clean NULL
  df_l_clean <- x[!vapply(x, is.null, logical(1))]

  final_df <- do.call(cbind, df_l_clean)
  return(final_df)
}
cff_to_df <- function(x) {
  # CFF has different models
  # type 1: unnamed arrays
  unnamed_array <- c("keywords", "languages", "patent-states")


  # type 2: named arrays
  named_array <- c(
    "conference", "database-provider", "institution",
    "location", "publisher"
  )


  # type 3: nested named arrays
  nested_named_array <- c(
    "authors", "contact", "editors", "editors-series",
    "recipients", "senders", "translators", "identifiers"
  )

  nms <- names(x)
  x_len <- seq_len(length(x))


  df_l <- lapply(x_len, function(y) {
    nm <- nms[y]

    if (nm %in% unnamed_array) {
      return(unnamed_to_df(x[y], nm))
    }
    if (nm %in% named_array) {
      return(named_to_df(x[y], nm))
    }
    if (nm %in% nested_named_array) {
      return(nested_named_to_df(x[y], nm))
    }
    if (nm == "preferred-citation") {
      return(prefcit_to_df(x[y]))
    }

    if (nm == "references") {
      return(reflist_to_df(x[y], nm))
    }

    the_df <- as.data.frame(x[[y]])
    names(the_df) <- gsub("-", "_", nm)
    return(the_df)
  })

  final_df <- df_list_to_df(df_l)

  return(final_df)
}

cff_list_to_df <- function(x) {
  # Applicable to lists of persons or references
  # Guess type
  if (!"type" %in% names(x[[1]])) {
    guess <- "person"
  } else {
    guess <- "reference"
  }


  x_len <- seq_len(length(x))
  df_l <- lapply(x_len, function(y) {
    df <- as.data.frame(x[y])
    newnames <- paste0(guess, ".", sprintf("%02d", y - 1), ".", names(df))
    names(df) <- newnames

    df
  })

  df_end <- df_list_to_df(df_l)
  df_end
}
