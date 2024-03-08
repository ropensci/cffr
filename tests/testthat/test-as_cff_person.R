test_that("NULL gives NULL", {
  expect_null(as_cff_person(NULL))
  expect_null(as_cff_person(NA))
  expect_null(as_cff_person(person()))
  expect_null(as_cff_person(list()))
  expect_null(as_cff_person(""))
})

test_that("default", {
  p <- list("One", "person")
  expect_identical(as_cff_person(p), as_cff_person("One person"))

  expect_identical(as_cff_person(1), as_cff_person("1"))
})

test_that("Coerce one person", {
  p <- person("one", "person")
  expect_snapshot(as_cff_person(p))
})

test_that("Coerce several persons", {
  p <- c(
    person("one", "person"), person("another", "human"),
    person("and one", "more")
  )
  expect_snapshot(as_cff_person(p))
})


test_that("Coerce bibtex persons", {
  s <- "Wright, III, Frank Edwin"

  expect_snapshot(as_cff_person(s))

  s <- "A person and another and Another one"

  expect_snapshot(as_cff_person(s))

  # As vector
  s2 <- c("A person", "another", "Another one")
  expect_identical(as_cff_person(s), as_cff_person(s2))
})

test_that("Coerce bibtex persons with masks", {
  s <- "Elephant and Castle"

  expect_snapshot(as_cff_person(s))

  s <- "{Elephant and Castle}"

  expect_snapshot(as_cff_person(s))

  s <- "{Elephant and Castle} and this AND Ltd."

  expect_snapshot(as_cff_person(s))

  s <- "{Elephant and Castle} and {this AND Ltd.}"

  expect_snapshot(as_cff_person(s))
})


test_that("Get same results with both", {
  s3 <- as_cff_person(
    c(person(family = "Entity"), person("A", "person"))
  )

  b3 <- as_cff_person("Entity and A person")

  expect_identical(s3, b3)

  s4 <- as_cff_person(person(family = "A big fat company"))
  b4 <- as_cff_person("{A big fat company}")

  expect_identical(s4, b4)
})

test_that("R Core Team", {
  p <- as_cff_person(person("R Core", "Team"))

  expect_equal(p[[1]]$name, "R Core Team")

  p <- as_cff_person("R Core Team")

  expect_equal(p[[1]]$name, "R Core Team")
})

test_that("Bioconductor", {
  # Several tastes of Bioconductor
  bio <- person("Bioconductor Package Maintainer",
    role = "cre",
    email = "maintainer@bioconductor.org"
  )
  p <- as_cff_person(bio)

  expect_equal(p[[1]]$name, "Bioconductor Package Maintainer")

  p <- as_cff_person("Bioconductor Package Maintainer")

  expect_equal(p[[1]]$name, "Bioconductor Package Maintainer")

  p <- as_cff_person(person("The Bioconductor", "Package Maintainer"))
  expect_equal(p[[1]]$name, "The Bioconductor Package Maintainer")
})

test_that("Several emails, select first", {
  pp <- person(
    given = "John",
    family = "Doe",
    role = c("aut", "cre", "trl"),
    email = c("first_mail@gmail.com", "second_mail@espol.edu.ec")
  )

  p <- as_cff_person(pp)

  expect_equal(p[[1]]$email, "first_mail@gmail.com")
})


test_that("Several emails, select second if first no valid", {
  pp <- person(
    given = "John",
    family = "Doe",
    role = c("aut", "cre", "trl"),
    email = c("first_mail_gmail.com", "second_mail@espol.edu.ec")
  )

  p <- as_cff_person(pp)

  expect_equal(p[[1]]$email, "second_mail@espol.edu.ec")
})



test_that("No valid emails", {
  pp <- person(
    given = "John",
    family = "Doe",
    role = c("aut", "cre", "trl"),
    email = c("first_mail_gmail.com", "second_mail__espol.edu.ec")
  )

  p <- as_cff_person(pp)

  expect_equal(p, as_cff_person(person(
    given = "John",
    family = "Doe"
  )))

  pp2 <- person(
    given = "John",
    family = "Doe"
  )

  p2 <- as_cff_person(pp2)

  expect_equal(p, as_cff_person(person(
    given = "John",
    family = "Doe"
  )))
})

test_that("Can extract comments from format", {
  pp <- person(
    given = "John",
    family = "Doe",
    email = "first_mail@gmail.com",
    comment = c(
      ORCID = "https://orcid.org/0000-0001-8457-4658",
      website = "https://www.google.com/"
    )
  )

  pp1 <- as_cff_person(pp)
  txt <- format(pp)
  pp2 <- as_cff_person(txt)
  expect_identical(pp1, pp2)

  expect_snapshot(pp2)
})
