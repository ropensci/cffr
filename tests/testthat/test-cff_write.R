test_that("Validate packages", {
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
    authors = list(list(
      "family-names" = "Doe",
      "given-names" = "John"
    )),
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
    list(list(
      "family-names" = "new author",
      "given-names" = "I am a",
      alias = "Hello!"
    ))
  )



  cff_write(demo_file,
    outfile = tmp,
    keys = list("authors" = new_aut)
  )
  expect_true(cff_validate(tmp))
})
