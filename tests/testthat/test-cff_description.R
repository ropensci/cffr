test_that("Parse date", {
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_false(is.null(parsed$`date-released`))

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})

test_that("Parse date in another format", {
  desc_path <- system.file("examples/DESCRIPTION_basicdate", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_false(is.null(parsed$`date-released`))

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})


test_that("No date parsed in DESCRIPTION without it", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_true(is.null(parsed$`date-released`))

  expect_s3_class(parsed, "cff")
  expect_true(cff_validate(parsed))
})

test_that("Parsing many urls", {
  desc_path <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_length(parsed$`repository-code`, 1)
  expect_length(parsed$url, 1)
  expect_length(parsed$identifiers, 3)
  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})


test_that("Parsing Gitlab", {
  desc_path <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")

  parsed <- cff_create(desc_path)

  parsed

  expect_length(parsed$`repository-code`, 1)
  expect_length(parsed$url, 1)
  expect_length(parsed$identifiers, 0)
  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})

test_that("Parsing many persons", {
  desc_path <- system.file("examples/DESCRIPTION_many_persons",
    package = "cffr"
  )

  parsed <- cff_create(desc_path)


  expect_length(parsed$authors, 4)


  authors <- unlist(parsed$authors)


  expect_length(grep("erro", authors), 0)
  names <- unlist(lapply(parsed$authors, names))

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})


test_that("Parsing wrong urls", {
  desc_path <- system.file("examples/DESCRIPTION_wrong_urls", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_null(parsed$`repository-code`)
  expect_length(parsed$url, 1)
  expect_length(parsed$identifiers, 2)

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})



test_that("Parsing two maintainers", {
  desc_path <- system.file("examples/DESCRIPTION_twomaintainers",
    package = "cffr"
  )

  parsed <- cff_create(desc_path)

  expect_length(parsed$authors, 3)
  expect_length(parsed$contact, 2)

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})

test_that("Parsing r-universe", {
  desc_path <- system.file("examples/DESCRIPTION_r_universe",
    package = "cffr"
  )

  parsed <- cff_create(desc_path)

  expect_length(parsed$repository, 1)

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed))
})
