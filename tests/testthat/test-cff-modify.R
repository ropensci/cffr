test_that("cff_modify rejects objects that are not cff", {
  a_cff <- cff()
  a_list <- as.list(a_cff)
  expect_type(a_list, "list")
  expect_false(is_cff(a_list))
  expect_snapshot(cff_modify(a_list, abstract = "An abstract"), error = TRUE)
})

test_that("cff_modify returns unchanged cff when no fields are supplied", {
  a_cff <- cff()
  expect_snapshot(xend <- cff_modify(a_cff))
  expect_identical(xend, a_cff)
})

test_that("cff_create applies NULL keys silently", {
  expect_silent(aa <- cff_create("testthat", keys = NULL))
  expect_s3_class(aa, "cff")
})

test_that("cff_modify keeps the first duplicate named field", {
  a_cff <- cff()
  # jarl-ignore-start duplicated_arguments: Testing edge case.
  expect_snapshot(dup <- cff_modify(a_cff, abstract = "a", abstract = "b"))
  # jarl-ignore-end duplicated_arguments

  expect_length(dup, length(a_cff) + 1)
  expect_identical(dup$abstract, "a")
})

test_that("cff_modify rejects multiple unnamed fields", {
  a_cff <- cff()
  expect_snapshot(cff_modify(a_cff, "a", "b"), error = TRUE)
})

test_that("cff_modify discards unnamed fields", {
  a_cff <- cff()
  expect_snapshot(mod <- cff_modify(a_cff, "a", abstract = "b"))
  expect_length(mod, length(a_cff) + 1)
  expect_identical(mod$abstract, "b")
})

test_that("cff_modify preserves valid cff classes", {
  a_cff <- cff()

  mod <- cff_modify(
    a_cff,
    contact = list(list(name = "a contact", address = "here"))
  )

  expect_true(cff_validate(mod, verbose = FALSE))
  expect_s3_class(mod$contact, c("cff_pers_lst", "cff"), exact = TRUE)
  expect_s3_class(mod$contact[1], c("cff_pers", "cff"), exact = TRUE)
})
