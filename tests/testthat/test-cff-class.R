test_that("as data frame complete", {
  path <- system.file("examples/CITATION_complete.cff", package = "cffr")

  the_cff <- cff_read(path)

  # To df
  the_df <- as.data.frame(the_cff)

  expect_s3_class(the_df, "data.frame")
  expect_equal(nrow(the_df), 1)

  # lengths
  allf <- unlist(the_cff, recursive = TRUE, use.names = FALSE)
  expect_identical(length(allf), ncol(the_df))


  expect_identical(ncol(the_df), length(unique(names(the_df))))

  # As vector
  df_as_v <- as.character(as.vector(the_df[1, ]))


  expect_identical(allf, df_as_v)
  expect_snapshot(names(the_df))
})

test_that("as data frame partial", {
  path <- system.file("examples/CITATION_complete.cff", package = "cffr")

  the_cff <- cff_read(path)

  # To df authors only
  subcff <- the_cff$authors[[1]]
  the_df <- as.data.frame(subcff)
  expect_s3_class(the_df, "data.frame")
  expect_equal(nrow(the_df), 1)
  # lengths
  allf <- unlist(subcff, recursive = TRUE, use.names = FALSE)
  expect_identical(length(allf), ncol(the_df))
  expect_identical(ncol(the_df), length(unique(names(the_df))))



  # To df references only
  subcff <- the_cff$references[[1]]
  the_df <- as.data.frame(subcff)
  expect_s3_class(the_df, "data.frame")
  expect_equal(nrow(the_df), 1)
  # lengths
  allf <- unlist(subcff, recursive = TRUE, use.names = FALSE)
  expect_identical(length(allf), ncol(the_df))
  expect_identical(ncol(the_df), length(unique(names(the_df))))
})


test_that("Convert a citation only", {
  path <- system.file("examples/DESCRIPTION_many_persons", package = "cffr")
  a_cit <- cff_to_bibentry(cff_create(path))

  the_cff <- cff_parse_citation(a_cit)

  # To df
  the_df <- as.data.frame(the_cff)

  expect_s3_class(the_df, "data.frame")
  expect_equal(nrow(the_df), 1)

  # lengths
  allf <- unlist(the_cff, recursive = TRUE, use.names = FALSE)
  expect_identical(length(allf), ncol(the_df))


  expect_identical(ncol(the_df), length(unique(names(the_df))))

  # As vector
  df_as_v <- as.character(as.vector(the_df[1, ]))


  expect_identical(allf, df_as_v)
  expect_snapshot(names(the_df))
})


test_that("Convert authors only", {
  a_pers_list <- cff_parse_person_bibtex(
    "A person and {A Entity inc.} and {One person} more"
  )

  the_cff <- a_pers_list[[1]]

  # To df
  the_df <- as.data.frame(the_cff)

  expect_s3_class(the_df, "data.frame")
  expect_equal(nrow(the_df), 1)

  # lengths
  allf <- unlist(the_cff, recursive = TRUE, use.names = FALSE)
  expect_identical(length(allf), ncol(the_df))

  expect_identical(ncol(the_df), length(unique(names(the_df))))

  # As vector
  df_as_v <- as.character(as.vector(the_df[1, ]))


  expect_identical(allf, df_as_v)
  expect_snapshot(names(the_df))
})

test_that("Convert list of authors", {
  path <- system.file("examples/CITATION_complete.cff", package = "cffr")

  the_cff <- cff_read(path)$authors

  # To df
  the_df <- as.data.frame(the_cff)

  expect_s3_class(the_df, "data.frame")
  expect_equal(nrow(the_df), 1)

  # lengths
  allf <- unlist(the_cff, recursive = TRUE, use.names = FALSE)
  expect_identical(length(allf), ncol(the_df))

  expect_identical(ncol(the_df), length(unique(names(the_df))))

  # As vector
  df_as_v <- as.character(as.vector(the_df[1, ]))


  expect_identical(allf, df_as_v)
  expect_snapshot(names(the_df))
})
