test_that("as.cff still works", {
  l <- list(
    "cff-version" = "1.2.0",
    title = "Manipulating files"
  )

  expect_silent(l1 <- as_cff(l))
  expect_silent(l2 <- as.cff(l))
  expect_s3_class(l1, c("cff", "list"))

  expect_snapshot(l2)
})


test_that("as_cff.person", {
  pers <- person("A", "person",
    email = "fake@gmail.com",
    comment = c(
      ORCID = "0000-0000-0000-0000",
      affiliation = "Real Madrid",
      website = "https://www.google.com/"
    )
  )

  expect_identical(as_cff(pers), as_cff_person(pers))
  expect_snapshot(as_cff(pers))
})

test_that("as_cff.bibentry, toBibtex", {
  b <- bibentry("Misc",
    title = "title", author = "Author",
    editor = "Editor"
  )

  bbb <- as_cff(b)

  expect_s3_class(bbb, c("cff_ref_list", "cff", "list"), exact = TRUE)
  expect_s3_class(bbb[[1]], c("cff_ref", "cff", "list"), exact = TRUE)
  expect_snapshot(bbb)

  b_bib <- toBibtex(b)
  expect_s3_class(b_bib, "Bibtex")

  bbbb <- as_cff(b_bib)

  expect_identical(bbb, bbbb)
})


test_that("as_cff.default", {
  b <- c(a = 1)

  expect_identical(as_cff(b), as_cff(as.list(b)))

  expect_snapshot(as_cff(b))
})

test_that("Other convertes", {
  a <- cff()
  expect_s3_class(a, "cff")
  a <- cff(a)
  expect_s3_class(a, "cff")
  a <- as_cff(a)
  expect_true(is_cff(a))
  expect_s3_class(a, "cff")

  expect_message(noadd <- cff(address = "New York", version = 5))
  expect_true(is_cff(noadd))
  expect_false(is_cff(list(a = 1, b = 2)))
  expect_true(is_cff(as_cff(list(a = 1, b = 2))))
})


test_that("]] cff_ref", {
  b1 <- bibentry("Misc",
    title = "title", author = "Author",
    editor = "Editor"
  )
  b2 <- bibentry("Manual", author = "Another", title = "another title")

  b_all <- c(b1, b2)

  expect_s3_class(b_all, "bibentry", exact = TRUE)
  bbb <- as_cff(b_all)

  expect_s3_class(bbb, c("cff_ref_list", "cff", "list"), exact = TRUE)
  expect_length(bbb, 2)

  b2_reg <- bbb[2]
  expect_length(b2_reg, 1)
  expect_s3_class(b2_reg, c("cff_ref", "cff", "list"), exact = TRUE)
})
