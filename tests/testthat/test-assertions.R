test_that("Check is_email", {
  # Examples from https://www.nicebread.de/validating-email-adresses-in-r/

  # Valid addresses
  expect_true(
    all(
      is_email("felix@nicebread.de"),
      is_email("felix.123.honeyBunny@nicebread.lmu.de"),
      is_email("felix@nicebread.de  "),
      is_email("    felix@nicebread.de"),
      is_email("felix+batman@nicebread.de"),
      is_email("felix@nicebread.office")
    )
  )
  # invalid addresses
  expect_false(
    any(
      is_email("felix@nicebread"),
      is_email("felix@nicebread@de"),
      is_email("felixnicebread.de"),
      is_email("@felixnicebread"),
      is_email("a @felixnicebread.co"),
      is_email("a@fe lixnicebread.de"),
      is_email(NULL),
      is_email(NA)
    )
  )
})


test_that("Check is_url", {
  # Valid urls
  expect_true(
    all(
      is_url("https://github.com/dieghernan"),
      is_url("http://github.com/dieghernan"),
      is_url("ftp://github.com/dieghernan"),
      is_url("sftp://github.com/dieghernan")
    )
  )
  # invalid addresses
  expect_false(
    any(
      is_url(NULL),
      is_url(NA),
      is_url(""),
      is_url("https:/github.com/dieghernan"),
      is_url("http:/github.com/dieghernan"),
      is_url("ftp:/github.com/dieghernan"),
      is_url("sftp:/github.com/dieghernan"),
      is_url("www.github.com/dieghernan")
    )
  )
})


test_that("Check is_substring", {
  expect_true(
    all(
      is_substring("amanda", "a"),
      is_substring("amanda erele", "e")
    )
  )
  # invalid addresses
  expect_false(
    any(
      is_substring(NULL, "a"),
      is_substring("amanda", "e"),
      is_substring("amanda", "A")
    )
  )
})

test_that("Check cff", {
  a_pers <- as_cff_person("Barnes and Noble")
  sing <- a_pers[[1]]
  expect_s3_class(sing, "cff_pers")

  a_bib <- as_cff(c(
    bibentry("misc", title = "a"),
    bibentry("misc", title = "b")
  ))
  sing2 <- a_bib[[1]]
  expect_s3_class(sing2, "cff_ref")
  expect_true(
    all(
      is_cff(cff()),
      is_cff(a_bib),
      is_cff(a_pers),
      is_cff(sing),
      is_cff(sing2)
    )
  )
  # invalid
  expect_false(
    any(
      is_cff("amanda"),
      is_cff(list(a = 1))
    )
  )
})


test_that("Check is cff file", {
  expect_true(is_cff_file("CIt_aT.cff"))
  expect_false(is_cff_file("CIt_aT_cff"))
})

test_that("is named", {
  a_n <- c("a" = 1, b = "2")
  expect_true(is_named(a_n))
  expect_true(is_named(as.list(a_n)))

  expect_false(is_named(LETTERS))
  expect_false(is_named(as.list(LETTERS)))
})

test_that("is github", {
  x <- list("repository-code" = "https://github.com/")
  x2 <- x
  x2$`repository-code` <- "gogle.com"
  expect_true(is_github(x))
  expect_false(is_github(x2))
})
