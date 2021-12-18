test_that("Parse one person", {
  p <- person("one", "person")
  expect_snapshot_output(cff_parse_person(p))
})

test_that("Parse several persons", {
  p <- c(
    person("one", "person"), person("another", "human"),
    person("and one", "more")
  )
  expect_snapshot_output(cff_parse_person(p))
})


test_that("Parse bibtex persons", {
  s <- "Wright, III, Frank Edwin"

  expect_snapshot_output(cff_parse_person_bibtex(s))

  s <- "A person and another and Another one"

  expect_snapshot_output(cff_parse_person_bibtex(s))
})

test_that("Parse bibtex persons with masks", {
  s <- "Elephant and Castle"

  expect_snapshot_output(cff_parse_person_bibtex(s))

  s <- "{Elephant and Castle}"

  expect_snapshot_output(cff_parse_person_bibtex(s))

  s <- "{Elephant and Castle} and this AND Ltd."

  expect_snapshot_output(cff_parse_person_bibtex(s))

  s <- "{Elephant and Castle} and {this AND Ltd.}"

  expect_snapshot_output(cff_parse_person_bibtex(s))
})


test_that("Get same results with both", {
  s <- "John Foo"

  r <- cff_parse_person(s)
  b <- cff_parse_person_bibtex(s)

  expect_identical(r, b)

  ex2 <- "John Foo and Mary Li"
  s2 <- cff_parse_person(ex2)

  b2 <- cff_parse_person_bibtex(ex2)

  expect_identical(s2, b2)

  s3 <- cff_parse_person(
    c(person(family = "Entity"), person("A", "person"))
  )

  b3 <- cff_parse_person_bibtex("Entity and A person")

  expect_identical(s3, b3)

  s4 <- cff_parse_person(person(family = "A big fat company"))
  b4 <- cff_parse_person_bibtex("{A big fat company}")

  expect_identical(s4, b4)
})

test_that("R Core Team", {
  p <- cff_parse_person(person("R Core", "Team"))

  expect_equal(p$name, "R Core Team")

  p <- cff_parse_person("R Core Team")

  expect_equal(p$name, "R Core Team")
})
