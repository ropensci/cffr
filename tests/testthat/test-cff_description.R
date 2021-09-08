test_that("Test DESCRIPTION of installed packages", {
  path <- file.path(find.package("jsonlite"), "DESCRIPTION")
  cffobj <- cff_description(path)

  expect_s3_class(cffobj, "cff")

  path <- file.path(find.package("jsonvalidate"), "DESCRIPTION")
  cffobj <- cff_description(path)

  expect_s3_class(cffobj, "cff")
})


# For all the example DESCRIPTION files the test is part of test-cff_create
