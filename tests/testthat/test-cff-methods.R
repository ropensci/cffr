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
  a_cit <- as_bibentry(cff_create(path))

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


test_that("as.person method", {
  path <- system.file("examples/CITATION_complete.cff", package = "cffr")

  the_cff <- cff_read(path)

  getref <- the_cff$references[[1]]

  # Single entity
  pub <- as.person(getref$publisher)
  expect_s3_class(pub, "person")

  expect_snapshot(dput(pub))
  expect_snapshot(
    format(pub, include = c("given", "family", "email", "role", "comment"))
  )

  # Single person
  aut <- as.person(getref$authors[[1]])
  expect_s3_class(aut, "person")
  expect_snapshot(dput(aut))
  expect_snapshot(
    format(aut, include = c("given", "family", "email", "role", "comment"))
  )

  # List of authors
  aut2 <- as.person(getref$authors)

  expect_s3_class(aut2, "person")
  expect_s3_class(aut2[1], "person")
  expect_s3_class(aut2[2], "person")
  expect_snapshot(dput(aut2))
  expect_snapshot(
    format(aut2, include = c("given", "family", "email", "role", "comment"))
  )
})

test_that("as person with another cff", {
  path <- system.file("examples/CITATION_complete.cff", package = "cffr")
  the_cff <- cff_read(path)
  expect_s3_class(the_cff, "cff")
  expect_identical(as.person(the_cff), person())

  # identifiers
  key <- the_cff$identifiers
  expect_s3_class(key, "cff")
  expect_identical(as.person(key), person())

  # preferred
  key <- the_cff$`preferred-citation`
  expect_s3_class(key, "cff")
  expect_identical(as.person(key), person())
})

test_that("head and tail", {
  a_cff <- cff()
  expect_snapshot(a_cff)
  expect_snapshot(head(a_cff, 2))
  expect_s3_class(head(a_cff, 2), "cff")

  expect_snapshot(tail(a_cff, 2))
  expect_s3_class(tail(a_cff, 2), "cff")
})

test_that("toBibtex", {
  # Create several alternatives
  descobj <- cff_read_description(system.file("examples/DESCRIPTION_basic",
    package = "cffr"
  ))

  citobj <- cff_read_citation(system.file("examples/CITATION_basic",
    package = "cffr"
  ))
  newbib <- cff_read_bib(system.file("examples/example.bib",
    package = "cffr"
  ))

  full_cff <- merge_desc_cit(descobj, c(newbib, citobj))
  full_cff <- new_cff(full_cff)
  expect_true(cff_validate(full_cff, verbose = FALSE))

  # A. validate extractions
  expect_snapshot(toBibtex(full_cff))
  expect_snapshot(toBibtex(full_cff, what = "references"))
  expect_snapshot(toBibtex(full_cff, what = "all"))

  # single entries
  single <- toBibtex(full_cff$`preferred-citation`)
  expect_s3_class(single, "Bibtex")
  expect_equal(sum(names(single) == "title"), 1)

  # Several entries
  several <- toBibtex(full_cff$references)
  expect_s3_class(several, "Bibtex")
  expect_equal(sum(names(several) == "title"), 3)


  # One entry
  oneent <- toBibtex(full_cff$references[[1]])
  expect_s3_class(single, "Bibtex")
  expect_equal(sum(names(oneent) == "title"), 1)

  fromfile <- toBibtex(newbib)
  expect_s3_class(fromfile, "Bibtex")
  expect_equal(sum(names(fromfile) == "title"), 2)

  # From lines
  string <- "@book{einstein1921,
    title        = {Relativity: The Special and the General Theory},
    author       = {Einstein, A.},
    year         = 1920,
    publisher    = {Henry Holt and Company},
    address      = {London, United Kingdom},
    isbn         = 9781587340925}"

  froml <- toBibtex(cff_create_bib_text(string))
  expect_equal(sum(names(froml) == "title"), 1)
})
