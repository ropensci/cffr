test_that("Error if file not exists", {
  expect_error(
    cff_create("DESCRIPTION_not_exists")
  )
})

test_that("Test installed packages", {
  skip_on_cran()
  expect_silent(cff_create("jsonlite"))
  expect_silent(cff_create("yaml"))
})

test_that("Test indev", {
  skip_on_cran()
  current_dir <- getwd()

  name <- paste0("mock-pack", runif(1) * 10)
  new_dir <- file.path(tempdir(), name)

  dir.create(new_dir, recursive = TRUE)

  expect_true(dir.exists(new_dir))

  setwd(new_dir)

  # Move files
  file.copy(system.file("examples/DESCRIPTION_basic", package = "cffr"),
    to = "DESCRIPTION"
  )

  a_cff <- cff_create()

  expect_true(cff_validate(a_cff, verbose = FALSE))
  # Revert to initial wd
  setwd(current_dir)

  expect_snapshot(a_cff)

  unlink(new_dir, recursive = TRUE, force = TRUE)
})

test_that("Test dependencies extraction", {
  yes <- cff_create("jsonlite")
  no <- cff_create("jsonlite", dependencies = FALSE)

  expect_true(length(yes$references) > length(no$references))
})

test_that("Test error formats on inputs", {
  df <- data.frame(x = 1, b = "c")
  expect_error(cff_create(df))
  l <- list(a = 1, b = 3)
  expect_error(cff_create(l))

  expect_error(cff_create("uanuanua"))
})

test_that("Validate all DESCRIPTION files", {
  allfiles <- list.files(
    system.file("examples", package = "cffr"),
    pattern = "^DESC", full.names = TRUE
  )

  for (i in seq_len(length(allfiles))) {
    cffobj <- cff_create(allfiles[i], gh_keywords = FALSE)
    # Check that no preferred citation is created
    expect_null(cffobj$`preferred-citation`)

    expect_true(cff_validate(cffobj, verbose = FALSE))
  }
})

test_that("No auto generate preferred citations", {
  rgeos <- system.file("examples/DESCRIPTION_rgeos",
    package = "cffr"
  )

  expect_snapshot(cff_create(rgeos,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  ))

  basicdate <- system.file("examples/DESCRIPTION_basicdate",
    package = "cffr"
  )
  expect_snapshot(cff_create(basicdate,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  ))
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
  expect_message(
    modobject <- cff_create(newobject, keys = newkeys),
    "tittle: title"
  )
  expect_snapshot(print_snapshot(
    "Fuzzy match on cff_create",
    modobject
  ))
})

test_that("Test installed packages vs call to file", {
  skip_on_cran()
  call1 <- cff_create("jsonlite")
  call2 <- cff_create(system.file("DESCRIPTION", package = "jsonlite"))

  expect_identical(call1, call2)
})

# Additional authors ----

test_that("Default roles", {
  p <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  cf <- cff_create(p, dependencies = FALSE)

  # Same as
  cf2 <- cff_create(p, authors_roles = c("aut", "cre"), dependencies = FALSE)
  expect_identical(cf, cf2)
})

test_that("Add new roles", {
  p <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  cf <- cff_create(p, dependencies = FALSE)
  cf2 <- cff_create(p,
    authors_roles = c("aut", "cre", "ctb"),
    dependencies = FALSE
  )

  expect_gt(length(cf2$authors), length(cf$authors))
  expect_true(cff_validate(cf2, verbose = FALSE))
})


test_that("Default roles on write", {
  p <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  cf <- cff_create(p, dependencies = FALSE)

  # Same as
  tmp <- tempfile(fileext = ".cff")
  cf2 <- cff_write(p,
    authors_roles = c("aut", "cre"), dependencies = FALSE,
    outfile = tmp, verbose = FALSE, validate = FALSE
  )

  expect_identical(cf, cf2)
})

test_that("Add new roles", {
  p <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  cf <- cff_create(p, dependencies = FALSE)
  cf2 <- cff_create(p,
    authors_roles = c("aut", "cre", "ctb"),
    dependencies = FALSE
  )

  expect_gt(length(cf2$authors), length(cf$authors))
  expect_true(cff_validate(cf2, verbose = FALSE))
})

test_that("Add new roles on write", {
  p <- system.file("examples/DESCRIPTION_no_URL", package = "cffr")

  cf_def <- cff_create(p)
  cf <- cff_create(p, authors_roles = "ctb")

  expect_gt(length(cf$authors), length(cf_def$authors))

  # Same as
  tmp <- tempfile(fileext = ".cff")
  expect_message(
    cf2 <- cff_write(p,
      authors_roles = "ctb", outfile = tmp,
      validate = FALSE
    ),
    "generated"
  )

  expect_identical(cf, cf2)
})

# Check DESCRIPTION ----
test_that("Coerce date", {
  desc_path <- system.file("examples/DESCRIPTION_rgeos", package = "cffr")

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_false(is.null(a_cff$`date-released`))

  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})

test_that("Coerce date in another format", {
  desc_path <- system.file("examples/DESCRIPTION_basicdate", package = "cffr")

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_false(is.null(a_cff$`date-released`))

  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})


test_that("No date coerced in DESCRIPTION without it", {
  desc_path <- system.file("examples/DESCRIPTION_basic", package = "cffr")

  a_cff <- cff_create(desc_path,
    keys = list(references = NULL)
  )

  expect_true(is.null(a_cff$`date-released`))

  expect_s3_class(a_cff, "cff")
  expect_true(cff_validate(a_cff, verbose = FALSE))
})

test_that("Parsing many urls", {
  desc_path <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_length(a_cff$`repository-code`, 1)
  expect_length(a_cff$url, 1)
  expect_length(a_cff$identifiers, 3)
  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})


test_that("Parsing Gitlab", {
  desc_path <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")

  a_cff <- cff_create(desc_path,
    keys = list(references = NULL)
  )

  expect_length(a_cff$`repository-code`, 1)
  expect_length(a_cff$url, 1)
  expect_length(a_cff$identifiers, 0)
  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})

test_that("Parsing many persons", {
  desc_path <- system.file("examples/DESCRIPTION_many_persons",
    package = "cffr"
  )

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )


  expect_length(a_cff$authors, 4)


  authors <- unlist(a_cff$authors)


  expect_length(grep("erro", authors), 0)
  names <- unlist(lapply(a_cff$authors, names))

  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})


test_that("Parsing wrong urls", {
  desc_path <- system.file("examples/DESCRIPTION_wrong_urls", package = "cffr")

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_null(a_cff$`repository-code`)
  expect_length(a_cff$url, 1)
  expect_length(a_cff$identifiers, 2)

  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})



test_that("Parsing two maintainers", {
  desc_path <- system.file("examples/DESCRIPTION_twomaintainers",
    package = "cffr"
  )

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_length(a_cff$authors, 3)
  expect_length(a_cff$contact, 2)

  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})

test_that("Parsing r-universe", {
  desc_path <- system.file("examples/DESCRIPTION_r_universe",
    package = "cffr"
  )

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_length(a_cff$repository, 1)

  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})


test_that("Parsing Bioconductor", {
  desc_path <- system.file("examples/DESCRIPTION_bioconductor",
    package = "cffr"
  )

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_length(a_cff$repository, 1)

  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})

test_that("Parsing Posit Package Manager", {
  desc_path <- system.file("examples/DESCRIPTION_posit_package_manager",
    package = "cffr"
  )

  a_cff <- cff_create(desc_path,
    gh_keywords = FALSE,
    keys = list(references = NULL)
  )

  expect_length(a_cff$repository, 1)
  expect_identical(
    a_cff$repository,
    "https://CRAN.R-project.org/package=resmush"
  )
  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
})

test_that("Search package on CRAN", {
  basic_path <- system.file("examples/DESCRIPTION_basic",
    package = "cffr"
  )

  tmp <- tempfile("DESCRIPTION_basic")
  # Create a temporary file
  file.copy(basic_path, tmp)

  newfile <- desc::desc_set("Package", "ggplot2", file = tmp)

  a_cff <- cff_create(tmp, gh_keywords = FALSE)
  expect_length(a_cff$repository, 1)
  expect_equal(clean_str(newfile$get("Package")), "ggplot2")
  expect_equal(a_cff$repository, "https://CRAN.R-project.org/package=ggplot2")



  expect_s3_class(a_cff, "cff")
  expect_snapshot(a_cff)
  expect_true(cff_validate(a_cff, verbose = FALSE))
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
  dhh <- "tidyterra"


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


test_that("Coerce keywords from GH", {
  skip_on_cran()
  skip_if_offline()
  skip_if(
    nchar(Sys.getenv("GITHUB_TOKEN")) == 0,
    "No GITHUB_TOKEN environment variable found"
  )

  desc_path <- system.file("examples/DESCRIPTION_basic",
    package = "cffr"
  )

  tmp <- tempfile("DESCRIPTION_keyword_gh")

  copy <- file.copy(desc_path, tmp)

  cffobj <- cff_create(tmp)
  expect_null(cffobj$keywords)

  expect_true(cff_validate(cffobj, verbose = FALSE))

  # A site with no topics
  silent <- desc::desc_set("BugReports",
    "https://github.com/dieghernan/cfftest/issues",
    file = tmp
  )

  cffobjnokeys <- cff_create(tmp)
  expect_true(cff_validate(cffobjnokeys, verbose = FALSE))
  expect_null(cffobjnokeys$keywords)

  # Add keywords from url
  silent <- desc::desc_set("URL",
    "https://github.com/ropensci/cffr",
    file = tmp
  )

  silent <- desc::desc_set("BugReports",
    "https://github.com/ropensci/cffr/issues",
    file = tmp
  )

  cffobj1 <- cff_create(tmp)
  expect_true(cff_validate(cffobj1, verbose = FALSE))
  expect_false(is.null(cffobj1$keywords))

  # Concatenate keywords of both sources

  # Add keywords
  silent <- desc::desc_set("X-schema.org-keywords",
    "keyword1",
    file = tmp
  )

  cffobj2 <- cff_create(tmp)
  expect_true(cff_validate(cffobj2, verbose = FALSE))

  expect_true(length(cffobj2$keywords) > length(cffobj1$keywords))
})
