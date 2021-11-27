test_that("Deparse error", {
  expect_error(cff_authors_to_person("Example"))
})

test_that("Deparse one person", {
  cff_aut <- cff_parse_person("Julio Iglesias <fake@email.com>")
  expect_snapshot_output(cff_authors_to_person(cff_aut))
})

test_that("Deparse several persons", {
  skip_if_not_installed("rmarkdown")

  all <- cff_create("rmarkdown")

  expect_snapshot_output(cff_authors_to_person(all$authors))
})
