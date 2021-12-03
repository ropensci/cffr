test_that("Error if file not exists", {
  expect_error(
    cff_create("DESCRIPTION_not_exists")
  )
})

test_that("Test installed packages", {
  expect_silent(cff_create("jsonlite"))
  expect_silent(cff_create("yaml"))
})

test_that("Test error formats on inputs", {
  df <- data.frame(x = 1, b = "c")
  expect_error(cff_create(df))
  l <- list(a = 1, b = 3)
  expect_error(cff_create(l))

  expect_error(cff_create("uanuanua"))
})

test_that("Validate all DESCRIPTION files", {
  allfiles <- list.files(system.file("examples",
    package = "cffr"
  ), pattern = "^DESC", full.names = TRUE)

  for (i in seq_len(length(allfiles))) {
    cffobj <- cff_create(allfiles[i], gh_keywords = FALSE)
    # Check that all have preferred citation
    expect_false(is.null(cffobj$`preferred-citation`))

    # Check year
    if (is.null(cffobj$`date-released`)) {
      expect_true(cffobj$`preferred-citation`$year == format(Sys.Date(), "%Y"))
    } else {
      dat <- format(as.Date(cffobj$`date-released`), "%Y")
      expect_true(cffobj$`preferred-citation`$year == dat)
    }

    expect_true(cff_validate(cffobj, verbose = FALSE))
  }
})

test_that("Auto generate preferred citations", {
  rgeos <- system.file("examples/DESCRIPTION_rgeos",
    package = "cffr"
  )
  expect_snapshot_output(cff_create(rgeos, gh_keywords = FALSE))

  basicdate <- system.file("examples/DESCRIPTION_basicdate",
    package = "cffr"
  )
  expect_snapshot_output(cff_create(basicdate, gh_keywords = FALSE))
})

test_that("Fuzzy match on cff_create", {
  newobject <- cff_create(cff())
  newkeys <- list(
    "url" = "https://ropensci.org/",
    "version" = "0.0.1",
    "repository" = "https://github.com/user/repo",
    # If the field is already present, it would be overridden
    tittle = "Modifying a 'cff' object"
  )
  modobject <- cff_create(newobject, keys = newkeys)
  expect_snapshot_output(print_snapshot(
    "Fuzzy match on cff_create",
    modobject
  ))
})

test_that("Test enhanced author: person", {

  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_many_persons", package = "cffr")
  cit_path <- system.file("examples/CITATION_many_persons", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)
  expect_s3_class(parsed, "bibentry")

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    "preferred-citation" = cff_parse_citation(parsed)
  ))

  expect_s3_class(cffobj, "cff")
  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Test enhanced author: entity", {

  # Needs an installed package
  desc_path <- system.file("examples/DESCRIPTION_entity", package = "cffr")
  cit_path <- system.file("examples/CITATION_entity", package = "cffr")
  parsed <- parse_r_citation(desc_path, cit_path)
  expect_s3_class(parsed, "bibentry")

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    "preferred-citation" = cff_parse_citation(parsed)
  ))

  expect_s3_class(cffobj, "cff")
  expect_snapshot_output(cffobj)
  expect_true(cff_validate(cffobj, verbose = FALSE))
})

test_that("Test overrides on list", {

  # Test
  desc_path <- system.file("examples/DESCRIPTION_entity", package = "cffr")
  keys <- bibentry("Misc",
    title = "An",
    author = "override"
  )
  keys <- cff_parse_citation(keys)

  # Create cff
  cffobj <- cff_create(desc_path, keys = list(
    "preferred-citation" = keys
  ))

  expect_s3_class(cffobj, "cff")
  expect_true(cff_validate(cffobj, verbose = FALSE))
})
