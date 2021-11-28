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


test_that("Deparse entity", {
  cff_authors <- cff_parse_person(person(
    given = "R Consortium",
    comment = c(
      address = "R worldwide"
    )
  ))
  expect_snapshot_output(cff_authors_to_person(cff_authors))
})

test_that("Deparse mixed", {
  mix <- c(
    person("Julio", "Iglesias"),
    person("R Consortium",
      comment = c(
        address = "R worldwide"
      )
    )
  )
  cff_mix <- cff_parse_person(mix)

  expect_snapshot_output(cff_authors_to_person(cff_mix))
})
