# Based on
# https://maverick.inria.fr/~Xavier.Decoret/resources/xdkbibtex/ >>
# bibtex_summary.html

test_that("person parser handles First von Last names", {
  inputs <- c(
    "AA BB",
    "AA",
    "AA bb",
    "aa",
    "AA bb CC",
    "AA bb CC dd EE",
    "AA {b}B cc dd",
    "AA \\BB{b} cc dd",
    "AA {bb} cc DD",
    "AA bb {cc} DD",
    "AA {bb} CC"
  )
  results <- lapply(inputs, \(x) unlist(create_person_from_txt(x)))
  names(results) <- inputs

  expect_type(create_person_from_txt(inputs[[1]]), "list")
  expect_snapshot(results)
})

test_that("person parser handles varied First von Last names", {
  inputs <- c(
    "Jean de La Fontaine",
    "Diego {Hernandez Sanz}",
    "Juan Manuel Miramontes",
    "Juan Manuel {Miramontes Garcia}",
    "Juan Manuel van Halen",
    "Bosco {de la Cruz y Ochoa}"
  )
  results <- lapply(inputs, \(x) unlist(create_person_from_txt(x)))
  names(results) <- inputs

  expect_snapshot(results)
})

test_that("person parser handles von Last, First names", {
  inputs <- c("bb CC, AA", "bb CC, aa", "bb CC dd EE, AA", "bb, AA", "BB,")
  results <- lapply(inputs, \(x) unlist(create_person_from_txt(x)))
  names(results) <- inputs

  expect_type(create_person_from_txt(inputs[[1]]), "list")
  expect_snapshot(results)
})

test_that("person parser preserves masking in von Last, First names", {
  inputs <- c(
    "de Armas, Ana",
    "{de Armas}, Ana",
    "{de Armas, Aguero}, Ana",
    "{de Armas, Aguero}, Ana Maria"
  )
  results <- lapply(inputs, \(x) unlist(create_person_from_txt(x)))
  names(results) <- inputs

  expect_snapshot(results)
})

test_that("person parser handles von Last, Jr, First names", {
  inputs <- c("bb CC,XX, AA", "BB,, AA", "BB, AA,")
  results <- lapply(inputs, \(x) unlist(create_person_from_txt(x)))
  names(results) <- inputs

  expect_type(create_person_from_txt(inputs[[1]]), "list")
  expect_snapshot(results)
})

test_that("person parser preserves masking with suffixes", {
  inputs <- c("Davis, Jr, Sammy", "{Davis, and}, {Jr, another}, Sammy")
  results <- lapply(inputs, \(x) unlist(create_person_from_txt(x)))
  names(results) <- inputs

  expect_snapshot(results)
})

test_that("person parser handles organizations and edge cases", {
  result <- create_person_from_txt("David, and, Jr, another, Sammy")

  expect_type(result, "list")
  expect_length(result, 1)
  expect_snapshot(unlist(result))
})

test_that("person parser handles canonical BibTeX name examples", {
  # http://tug.ctan.org/info/bibtex/tamethebeast/ttb_en.pdf
  inputs <- c(
    "jean de la fontaine",
    "Jean de la fontaine ",
    "Jean {de} la fontaine ",
    "jean {de} {la} fontaine ",
    "Jean {de} {la} fontaine ",
    "Jean De La Fontaine ",
    "jean De la Fontaine ",
    "Jean de La Fontaine ",
    "jean de la fontaine,",
    "de la fontaine, Jean ",
    "De La Fontaine, Jean",
    "De la Fontaine, Jean",
    "de La Fontaine, Jean"
  )
  results <- lapply(inputs, \(x) unlist(create_person_from_txt(x)))
  names(results) <- inputs

  expect_snapshot(results)
})
