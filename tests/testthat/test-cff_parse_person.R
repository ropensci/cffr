test_that("Parse one person", {
  p <- person("one", "person")
  expect_snapshot(cff_parse_person(p))
})

test_that("Parse several persons", {
  p <- c(
    person("one", "person"), person("another", "human"),
    person("and one", "more")
  )
  expect_snapshot(cff_parse_person(p))
})


test_that("Parse bibtex persons", {
  s <- "Wright, III, Frank Edwin"

  expect_snapshot(cff_parse_person_bibtex(s))

  s <- "A person and another and Another one"

  expect_snapshot(cff_parse_person_bibtex(s))
})

test_that("Parse bibtex persons with masks", {
  s <- "Elephant and Castle"

  expect_snapshot(cff_parse_person_bibtex(s))

  s <- "{Elephant and Castle}"

  expect_snapshot(cff_parse_person_bibtex(s))

  s <- "{Elephant and Castle} and this AND Ltd."

  expect_snapshot(cff_parse_person_bibtex(s))

  s <- "{Elephant and Castle} and {this AND Ltd.}"

  expect_snapshot(cff_parse_person_bibtex(s))
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

test_that("Bioconductor", {
  # Several tastes of Bioconductor
  bio <- person("Bioconductor Package Maintainer",
    role = "cre",
    email = "maintainer@bioconductor.org"
  )
  p <- cff_parse_person(bio)

  expect_equal(p$name, "Bioconductor Package Maintainer")

  p <- cff_parse_person("Bioconductor Package Maintainer")

  expect_equal(p$name, "Bioconductor Package Maintainer")

  p <- cff_parse_person(person("The Bioconductor", "Package Maintainer"))
  expect_equal(p$name, "The Bioconductor Package Maintainer")
})

test_that("Several emails, select first", {
  pp <- person(
    given = "John",
    family = "Doe",
    role = c("aut", "cre", "trl"),
    email = c("first_mail@gmail.com", "second_mail@espol.edu.ec")
  )

  p <- cff_parse_person(pp)

  expect_equal(p$email, "first_mail@gmail.com")
})


test_that("Several emails, select second if first no valid", {
  pp <- person(
    given = "John",
    family = "Doe",
    role = c("aut", "cre", "trl"),
    email = c("first_mail_gmail.com", "second_mail@espol.edu.ec")
  )

  p <- cff_parse_person(pp)

  expect_equal(p$email, "second_mail@espol.edu.ec")
})



test_that("No valid emails", {
  pp <- person(
    given = "John",
    family = "Doe",
    role = c("aut", "cre", "trl"),
    email = c("first_mail_gmail.com", "second_mail__espol.edu.ec")
  )

  p <- cff_parse_person(pp)

  expect_equal(p, cff_parse_person(person(
    given = "John",
    family = "Doe"
  )))

  pp2 <- person(
    given = "John",
    family = "Doe"
  )

  p2 <- cff_parse_person(pp2)

  expect_equal(p, cff_parse_person(person(
    given = "John",
    family = "Doe"
  )))
})
