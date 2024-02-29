# Based on
# https://maverick.inria.fr/~Xavier.Decoret/resources/xdkbibtex/ >>
# bibtex_summary.html

test_that("Test first von last", {
  x <- "AA BB"

  res <- create_person_from_txt(x)
  expect_true(is.list(res))

  expect_snapshot(unlist(res))

  x <- "AA"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "AA bb"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "aa"
  expect_snapshot(unlist(create_person_from_txt(x)))


  x <- "AA bb CC"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "AA bb CC dd EE"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "AA {b}B cc dd"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "AA \\BB{b} cc dd"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "AA {bb} cc DD"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "AA bb {cc} DD"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "AA {bb} CC"
  expect_snapshot(unlist(create_person_from_txt(x)))
})

test_that("Testing with random names First von Last", {
  x <- "Jean de La Fontaine"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Diego {Hernandez Sanz}"

  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Juan Manuel Miramontes"

  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Juan Manuel {Miramontes Garcia}"

  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Juan Manuel van Halen"

  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Bosco {de la Cruz y Ochoa}"

  expect_snapshot(unlist(create_person_from_txt(x)))
})

test_that("Test von Last, First", {
  x <- "bb CC, AA"

  res <- create_person_from_txt(x)
  expect_true(is.list(res))

  expect_snapshot(unlist(res))

  x <- "bb CC, aa"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "bb CC dd EE, AA"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "bb, AA"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "BB,"
  expect_snapshot(unlist(create_person_from_txt(x)))
})

test_that("Test von Last, First with brackets, etc", {
  x <- "de Armas, Ana"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "{de Armas}, Ana"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "{de Armas, Aguero}, Ana"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "{de Armas, Aguero}, Ana Maria"
  expect_snapshot(unlist(create_person_from_txt(x)))
})

test_that("Test von Last, Jr,  First", {
  x <- "bb CC,XX, AA"

  res <- create_person_from_txt(x)
  expect_true(is.list(res))

  expect_snapshot(unlist(res))

  x <- "BB,, AA"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "BB, AA,"
  expect_snapshot(unlist(create_person_from_txt(x)))
})

test_that("Test von Last, Jr,  First with masking", {
  x <- "Davis, Jr, Sammy"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "{Davis, and}, {Jr, another}, Sammy"
  expect_snapshot(unlist(create_person_from_txt(x)))
})

test_that("Rest of cases", {
  x <- "David, and, Jr, another, Sammy"

  res <- create_person_from_txt(x)
  expect_true(is.list(res))
  expect_length(res, 1)

  expect_snapshot(unlist(res))
})


test_that("tames da beast", {
  # http://tug.ctan.org/info/bibtex/tamethebeast/ttb_en.pdf

  x <- "jean de la fontaine"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Jean de la fontaine "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Jean {de} la fontaine "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "jean {de} {la} fontaine "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Jean {de} {la} fontaine "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Jean De La Fontaine "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "jean De la Fontaine "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "Jean    de La Fontaine "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "jean de la fontaine,"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "de la fontaine, Jean "
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "De La Fontaine, Jean"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "De la Fontaine, Jean"
  expect_snapshot(unlist(create_person_from_txt(x)))

  x <- "de La Fontaine, Jean"
  expect_snapshot(unlist(create_person_from_txt(x)))
})
