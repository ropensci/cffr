test_that("as.cff still works", {
  l <- list(
    "cff-version" = "1.2.0",
    title = "Manipulating files"
  )

  expect_silent(l1 <- as_cff(l))
  expect_silent(l2 <- as.cff(l))
  expect_s3_class(l1, "cff", exact = TRUE)

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

  aa <- as_cff_person(pers)
  expect_s3_class(aa, c("cff_pers_lst", "cff"), exact = TRUE)
  expect_s3_class(aa[[1]], c("cff_pers", "cff"), exact = TRUE)
  expect_identical(aa, as_cff_person(pers))
  expect_snapshot(as_cff(pers))

  # Check a single person
  single <- as.list(aa)[[1]]
  expect_false(inherits(single, "cff"))
  single_cff <- as_cff(single)
  expect_s3_class(single_cff, c("cff_pers", "cff"), exact = TRUE)
  expect_snapshot(single_cff)
})

test_that("as_cff.bibentry, toBibtex", {
  b <- bibentry("Misc",
    title = "title", author = "Author",
    editor = "Editor"
  )

  bbb <- as_cff(b)

  expect_s3_class(bbb, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_s3_class(bbb[[1]], c("cff_ref", "cff"), exact = TRUE)
  expect_snapshot(bbb)

  b_bib <- toBibtex(b)
  expect_s3_class(b_bib, "Bibtex")

  bbbb <- as_cff(b_bib)

  expect_identical(bbb, bbbb)

  # Check single
  b_single <- as.list(bbb)[[1]]
  expect_false(inherits(b_single, "cff"))
  b_single_cff <- as_cff(b_single)
  expect_s3_class(b_single_cff, c("cff_ref", "cff"), exact = TRUE)
  expect_snapshot(b_single_cff)

  # Check empty
  s <- bibentry("misc")
  expect_null(as_cff(s))
})


test_that("as_cff.default", {
  b <- c(a = 1)

  expect_identical(as_cff(b), as_cff(as.list(b)))

  expect_snapshot(as_cff(b))
})

test_that("Other convertes", {
  a <- cff()
  expect_s3_class(a, "cff")
  a <- as_cff(a)
  expect_true(is_cff(a))
  expect_s3_class(a, "cff")

  expect_snapshot(noadd <- cff(chocolate = "New York", version = 5))
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

  expect_s3_class(bbb, c("cff_ref_lst", "cff"), exact = TRUE)
  expect_length(bbb, 2)

  b2_reg <- bbb[2]
  expect_length(b2_reg, 1)
  expect_s3_class(b2_reg, c("cff_ref", "cff"), exact = TRUE)
})

test_that("]] cff_pers", {
  b1 <- person("One", "person")
  b2 <- person("ntity")

  b_all <- c(b1, b2)

  expect_s3_class(b_all, "person", exact = TRUE)
  bbb <- as_cff(b_all)

  expect_s3_class(bbb, c("cff_pers_lst", "cff"), exact = TRUE)
  expect_length(bbb, 2)

  b2_reg <- bbb[2]
  expect_length(b2_reg, 1)
  expect_s3_class(b2_reg, c("cff_pers", "cff"), exact = TRUE)
})

# Check full classes with recursion
test_that("Reading full cff", {
  full <- system.file("examples/CITATION_complete.cff", package = "cffr")
  cff_complete <- cff_read(full)

  nm <- names(cff_complete)

  class_v <- vapply(nm, function(x) {
    clean_str(paste0(class(cff_complete[[x]]), collapse = "|"))
  }, character(1))

  df <- data.frame(class = sort(class_v[class_v != "character"]))

  expect_snapshot(df)

  # Assess preferred
  pref <- cff_complete$`preferred-citation`
  nm2 <- names(pref)

  class_v2 <- vapply(nm2, function(x) {
    clean_str(paste0(class(pref[[x]]), collapse = "|"))
  }, character(1))

  df2 <- data.frame(class = sort(class_v2[class_v2 != "character"]))


  expect_snapshot(df2)

  # Relist
  asl <- as.list(cff_complete)

  expect_false(inherits(asl, "cff"))
  expect_identical(cff_complete, as_cff(asl))
})
