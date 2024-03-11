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

  the_cff <- as_cff(a_cit)

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
  a_pers_lst <- as_cff_person(
    "A person and {A Entity inc.} and {One person} more"
  )

  the_cff <- a_pers_lst[[1]]

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

  # Malformed
  malf <- getref$authors
  malf[[1]] <- list(a = "list")
  expect_s3_class(malf, "cff_pers_lst")

  expect_snapshot(end <- as.person(malf))
  expect_s3_class(end, "person")
  expect_length(end, 1)

  # Duplicates
  aa <- getref$authors
  aa[[3]] <- aa[[1]]
  expect_s3_class(aa, "cff_pers_lst")

  expect_snapshot(aa2 <- as.person(aa))
  expect_s3_class(aa2, "person")
  expect_length(aa2, 2)
})

test_that("as.person method names and particles", {
  str <- "von Wicksteed, III, P. H. and {The translator factory}"

  cf <- as_cff_person(str)
  expect_snapshot(cf)

  pers_bib <- toBibtex(as.person(cf))
  again <- as_cff_person(pers_bib)
  expect_identical(cf, again)
})

test_that("Errors on other as.person methods", {
  path <- system.file("examples/CITATION_complete.cff", package = "cffr")
  the_cff <- cff_read(path)
  expect_s3_class(the_cff, "cff", exact = TRUE)
  expect_snapshot(as.person(the_cff), error = TRUE)

  # identifiers
  key <- the_cff$identifiers
  expect_s3_class(key, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_snapshot(as.person(key), error = TRUE)

  # preferred
  key <- the_cff$`preferred-citation`
  expect_s3_class(key, c("cff_ref", "cff"), exact = TRUE)
  expect_snapshot(as.person(key), error = TRUE)
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

  froml <- toBibtex(cff_read_bib_text(string))
  expect_equal(sum(names(froml) == "title"), 1)


  # Persons

  sev_auth <- as_cff_person(
    "{The Big Bopper} and Frank Sinatra and Dean Martin and Davis, Jr., Sammy"
  )

  expect_length(sev_auth, 4)
  expect_s3_class(sev_auth, "cff_pers_lst")
  expect_snapshot(toBibtex(sev_auth))


  # Single person
  single <- as_cff_person(person("A", "person", email = "a@b.d"))[[1]]
  expect_s3_class(single, "cff_pers")
  expect_snapshot(toBibtex(single))

  # Single entity
  single <- as_cff_person(person("{A and B co}", email = "a@b.d"))[[1]]
  expect_s3_class(single, "cff_pers")
  expect_snapshot(toBibtex(single))
})


test_that("as.list", {
  f <- system.file("examples/CITATION_complete.cff", package = "cffr")

  full_cff <- cff_read_cff_citation(f)

  # Capture dput and search
  dput_cff <- capture.output(dput(full_cff))

  ntot_class <- sum(grepl("\"cff\"", dput_cff))

  expect_gt(ntot_class, 30)

  # Unlist
  unl <- as.list(full_cff)

  # Capture dput and search
  dput_unl <- capture.output(dput(unl))

  ntot_class_unl <- sum(grepl("\"cff\"", unl))

  expect_identical(ntot_class_unl, 0L)

  # Reclass
  regen_cff <- as_cff(unl)

  expect_identical(full_cff, regen_cff)

  expect_true(cff_validate(regen_cff, verbose = FALSE))
})
