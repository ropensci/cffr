test_that("Errors and messages", {
  a_cff <- cff()
  a_list <- as.list(a_cff)
  expect_true(inherits(a_list, "list"))
  expect_false(is_cff(a_list))
  expect_snapshot(cff_modify(a_list, abstract = "An abstract"),
    error = TRUE
  )

  # Nothing provided
  expect_snapshot(xend <- cff_modify(a_cff))
  expect_identical(xend, a_cff)

  # But silent in cff create
  expect_silent(aa <- cff_create("testthat", keys = NULL))

  # Duplicate args
  expect_snapshot(dup <- cff_modify(a_cff, abstract = "a", abstract = "b"))
  expect_length(dup, length(a_cff) + 1)
  expect_identical(dup$abstract, "a")
  expect_snapshot(cff_modify(a_cff, "a", "b"), error = TRUE)
  expect_snapshot(mod <- cff_modify(a_cff, "a", abstract = "b"))
  expect_length(mod, length(a_cff) + 1)
  expect_identical(mod$abstract, "b")
})

test_that("Can reclass", {
  a_cff <- cff()

  mod <- cff_modify(a_cff, contact = list(list(
    name = "a contact",
    address = "here"
  )))


  expect_true(cff_validate(mod, verbose = FALSE))
  expect_s3_class(mod$contact, c("cff_pers_lst", "cff"), exact = TRUE)
  expect_s3_class(mod$contact[1], c("cff_pers", "cff"), exact = TRUE)
})
