test_that("Check schema keys", {
  sorted <- cff_schema_keys(TRUE)
  unsorted <- cff_schema_keys(FALSE)

  expect_equal(length(setdiff(sorted, unsorted)), 0)

  expect_false(all(sorted == unsorted))
})

test_that("Keys snapshot", {
  expect_snapshot({
    cff_schema_keys(FALSE)
  })
})

test_that("License run", {
  expect_silent(
    cff_schema_keys_license()
  )
})
