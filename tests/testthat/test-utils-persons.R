# Based on https://maverick.inria.fr/~Xavier.Decoret/resources/xdkbibtex/bibtex_summary.html

test_that("Test first von last", {
  x <- "AA BB"

  res <- as_person_bibtex(x)
  expect_true(is.list(res))

  expect_snapshot_output(unlist(res))

  x <- "AA"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "AA bb"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "aa"
  expect_snapshot_output(unlist(as_person_bibtex(x)))


  x <- "AA bb CC"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "AA bb CC dd EE"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "AA {b}B cc dd"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "AA \\BB{b} cc dd"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "AA {bb} cc DD"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "AA bb {cc} DD"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "AA {bb} CC"
  expect_snapshot_output(unlist(as_person_bibtex(x)))
})

test_that("Testing with random names First von Last", {
  x <- "Jean de La Fontaine"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Diego {Hernandez Sanz}"

  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Juan Manuel Miramontes"

  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Juan Manuel {Miramontes Garcia}"

  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Juan Manuel van Halen"

  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Bosco {de la Cruz y Ochoa}"

  expect_snapshot_output(unlist(as_person_bibtex(x)))
})

test_that("Test von Last, First", {
  x <- "bb CC, AA"

  res <- as_person_bibtex(x)
  expect_true(is.list(res))

  expect_snapshot_output(unlist(res))

  x <- "bb CC, aa"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "bb CC dd EE, AA"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "bb, AA"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "BB,"
  expect_snapshot_output(unlist(as_person_bibtex(x)))
})

test_that("Test von Last, First with brackets, etc", {
  x <- "de Armas, Ana"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "{de Armas}, Ana"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "{de Armas, Aguero}, Ana"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "{de Armas, Aguero}, Ana Maria"
  expect_snapshot_output(unlist(as_person_bibtex(x)))
})

test_that("Test von Last, Jr,  First", {
  x <- "bb CC,XX, AA"

  res <- as_person_bibtex(x)
  expect_true(is.list(res))

  expect_snapshot_output(unlist(res))

  x <- "BB,, AA"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "BB, AA,"
  expect_snapshot_output(unlist(as_person_bibtex(x)))
})

test_that("Test von Last, Jr,  First with masking", {
  x <- "Davis, Jr, Sammy"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "{Davis, and}, {Jr, another}, Sammy"
  expect_snapshot_output(unlist(as_person_bibtex(x)))
})

test_that("Rest of cases", {
  x <- "David, and, Jr, another, Sammy"

  res <- as_person_bibtex(x)
  expect_true(is.list(res))
  expect_length(res, 1)

  expect_snapshot_output(unlist(res))
})


test_that("tames da beast", {
  # http://tug.ctan.org/info/bibtex/tamethebeast/ttb_en.pdf

  x <- "jean de la fontaine"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Jean de la fontaine "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Jean {de} la fontaine "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "jean {de} {la} fontaine "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Jean {de} {la} fontaine "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Jean De La Fontaine "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "jean De la Fontaine "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "Jean    de La Fontaine "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "jean de la fontaine,"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "de la fontaine, Jean "
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "De La Fontaine, Jean"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "De la Fontaine, Jean"
  expect_snapshot_output(unlist(as_person_bibtex(x)))

  x <- "de La Fontaine, Jean"
  expect_snapshot_output(unlist(as_person_bibtex(x)))
})
