test_that("Parse date", {
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_false(is.null(parsed$`date-released`))

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed, verbose = FALSE))
})

test_that("Parse date in another format", {
  desc_path <- system.file("examples/DESCRIPTION_basicdate", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_false(is.null(parsed$`date-released`))

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed, verbose = FALSE))
})


test_that("No date parsed in DESCRIPTION without it", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_true(is.null(parsed$`date-released`))

  expect_s3_class(parsed, "cff")
  expect_true(cff_validate(parsed, verbose = FALSE))
})

test_that("Parsing many urls", {
  desc_path <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_length(parsed$`repository-code`, 1)
  expect_length(parsed$url, 1)
  expect_length(parsed$identifiers, 3)
  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed, verbose = FALSE))
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
  expect_true(cff_validate(parsed, verbose = FALSE))
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
  expect_true(cff_validate(parsed, verbose = FALSE))
})


test_that("Parsing wrong urls", {
  desc_path <- system.file("examples/DESCRIPTION_wrong_urls", package = "cffr")

  parsed <- cff_create(desc_path)

  expect_null(parsed$`repository-code`)
  expect_length(parsed$url, 1)
  expect_length(parsed$identifiers, 2)

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed, verbose = FALSE))
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
  expect_true(cff_validate(parsed, verbose = FALSE))
})

test_that("Parsing r-universe", {
  desc_path <- system.file("examples/DESCRIPTION_r_universe",
    package = "cffr"
  )

  parsed <- cff_create(desc_path)

  expect_length(parsed$repository, 1)

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed, verbose = FALSE))
})


test_that("Parsing Bioconductor", {
  desc_path <- system.file("examples/DESCRIPTION_bioconductor",
    package = "cffr"
  )

  parsed <- cff_create(desc_path)

  expect_length(parsed$repository, 1)
  expect_equal(
    parsed$contact[[1]]$name,
    "Bioconductor Package Maintainer"
  )

  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed, verbose = FALSE))
})

test_that("Search package on CRAN", {
  basic_path <- system.file("examples/DESCRIPTION_basic",
    package = "cffr"
  )

  tmp <- tempfile("DESCRIPTION_basic")
  # Create a temporary file
  file.copy(basic_path, tmp)

  newfile <- desc::desc_set("Package", "ggplot2", file = tmp)

  parsed <- cff_create(tmp)
  expect_length(parsed$repository, 1)
  expect_equal(clean_str(newfile$get("Package")), "ggplot2")
  expect_equal(parsed$repository, "https://CRAN.R-project.org/package=ggplot2")



  expect_s3_class(parsed, "cff")
  expect_snapshot_output(parsed)
  expect_true(cff_validate(parsed, verbose = FALSE))
})


test_that("Search package on r-universe", {
  skip_on_cran()
  skip_if_offline()

  basic_path <- system.file("examples/DESCRIPTION_basic",
    package = "cffr"
  )

  tmp <- tempfile("DESCRIPTION_basic")
  # Create a temporary file
  file.copy(basic_path, tmp)


  # Get packages from my r-universe
  dhh <- unlist(jsonlite::read_json(
    "https://dieghernan.r-universe.dev/packages"
  ))[1]


  newpack <- desc::desc(tmp)

  oldtitle <- clean_str(newpack$get("Package"))

  newtitle <- desc::desc_set("Package", dhh, file = tmp)

  expect_false(oldtitle == clean_str(newtitle$get("Package")))


  # Configure to search on r-universe
  newrepos <- c(
    dieghernan = "https://dieghernan.r-universe.dev",
    CRAN = "https://cloud.r-project.org"
  )

  runiverse <- as.data.frame(available.packages(
    repos = newrepos
  ))

  expect_equal(
    search_on_repos(dhh, runiverse),
    "https://dieghernan.r-universe.dev/"
  )


  # Search now ggplot2, should be canonical url

  expect_equal(
    search_on_repos("ggplot2", runiverse, newrepos),
    "https://CRAN.R-project.org/package=ggplot2"
  )
})


test_that("Validate keywords", {
  desc_path <- system.file("examples/DESCRIPTION_basic",
    package = "cffr"
  )

  tmp <- tempfile("DESCRIPTION_keyword")

  copy <- file.copy(desc_path, tmp)

  cffobj <- cff_create(tmp)
  expect_null(cffobj$keywords)

  expect_true(cff_validate(cffobj, verbose = FALSE))

  # Add keywords
  silent <- desc::desc_set("X-schema.org-keywords",
    "keyword1, keyword1, keyword3",
    file = tmp
  )
  cffobj2 <- cff_create(tmp)
  expect_length(cffobj2$keywords, 2)
  expect_equal(cffobj2$keywords, c("keyword1", "keyword3"))
  expect_true(cff_validate(cffobj2, verbose = FALSE))

  # Single keyword
  silent <- desc::desc_set("X-schema.org-keywords",
    "keyword1, keyword1",
    file = tmp
  )
  cffobj3 <- cff_create(tmp)
  expect_length(cffobj3$keywords, 2)
  expect_equal(cffobj3$keywords, c("keyword1", "r-package"))
  expect_true(cff_validate(cffobj3, verbose = FALSE))

  # NULL case keyword
  silent <- desc::desc_set("X-schema.org-keywords",
    "r-package",
    file = tmp
  )
  cffobj4 <- cff_create(tmp)
  expect_null(cffobj4$keywords)
  expect_true(cff_validate(cffobj4, verbose = FALSE))
})
