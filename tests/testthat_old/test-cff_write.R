test_that("Write from packages", {
  allfiles <- list.files(system.file("examples",
    package = "cffr"
  ), pattern = "^DESC", full.names = TRUE)

  names <- list.files(system.file("examples",
    package = "cffr"
  ), pattern = "^DESC", full.names = FALSE)


  for (i in seq_len(length(allfiles))) {
    tmp <- tempfile(pattern = names[i], fileext = ".cff")

    message("----\nValidating ", names[i], "\n----")
    if (names[i] == "DESCRIPTION_no_encoding") {
      expect_warning(cff_write(allfiles[i], outfile = tmp))
    } else {
      cff_write(allfiles[i], outfile = tmp)
    }
    expect_true(cff_validate(tmp))
  }
})

test_that("Add new keys", {
  # Demo file
  demo_file <- system.file("examples/DESCRIPTION_demo", package = "cffr")

  tmp <- tempfile(fileext = ".cff")

  # Add additional keys
  newkeys <- list(
    message = "This overwrites fields",
    abstract = "New abstract",
    keywords = c("A", "new", "list", "of", "keywords"),
    authors = list(cff_parse_person("Don Nadie")),
    "date-released" = "1900-01-01",
    "error" = "This is an error"
  )

  cff_write(demo_file,
    outfile = tmp,
    keys = newkeys
  )
  expect_true(cff_validate(tmp))
})


test_that("Append keys", {
  # Demo file
  demo_file <- system.file("examples/DESCRIPTION_demo", package = "cffr")

  tmp <- tempfile(fileext = ".cff")

  old <- cff_create(demo_file)

  old_aut <- old$authors

  # It should be a list
  new_aut <- append(
    old_aut,
    list(cff_parse_person(
      person("New", "author", comment = c(
        "error" = 123,
        country = "IT"
      ))
    ))
  )


  cff_write(demo_file,
    outfile = tmp,
    keys = list("authors" = new_aut)
  )
  expect_true(cff_validate(tmp))
})

test_that("Write from a cff object", {
  # Demo file
  demo_file <- system.file("examples/DESCRIPTION_demo", package = "cffr")

  tmp <- tempfile(fileext = ".cff")

  cffobj <- cff_create(demo_file)
  expect_true(is.cff(cffobj))

  cff_write(cffobj,
    outfile = tmp
  )

  expect_true(file.exists(tmp))
  expect_true(cff_validate(tmp))
})

test_that("Fix extension of the file", {
  complete <- system.file("examples/CITATION_complete.cff",
    package = "cffr"
  )
  cffobj <- cff(complete)

  tmp <- tempfile()
  tmp2 <- tempfile(fileext = ".cff")
  cff_write(cffobj, tmp, validate = FALSE)
  cff_write(cffobj, tmp2, validate = FALSE)

  expect_true(cff_validate(paste0(tmp, ".cff")))
  expect_true(cff_validate(tmp2))
})
