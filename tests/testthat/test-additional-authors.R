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
  expect_silent(
    cf2 <- cff_write(p,
      authors_roles = c("aut", "cre"), dependencies = FALSE,
      outfile = tmp, verbose = FALSE, validate = FALSE
    )
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
