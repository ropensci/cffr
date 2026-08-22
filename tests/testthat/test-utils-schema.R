test_that("schema helpers expose valid cff keys", {
  sorted <- cff_schema_keys(TRUE)
  unsorted <- cff_schema_keys(FALSE)

  expect_length(setdiff(sorted, unsorted), 0)

  expect_false(all(sorted == unsorted))
})

test_that("schema key ordering remains stable", {
  expect_snapshot({
    cff_schema_keys(FALSE)
  })
})

test_that("schema helpers expose SPDX licenses", {
  expect_silent(cff_schema_keys_license())
})
