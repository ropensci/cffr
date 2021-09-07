test_that("Error if file not exists", {
  expect_error(
    cff_create("DESCRIPTION_this_doesnt_exists")
  )
})

test_that("Test installed packages", {
  expect_silent(cff_create("jsonlite"))
  expect_silent(cff_create("cffr"))
  expect_silent(cff_create(cff()))
})


test_that("Test file description", {
  expect_snapshot({
    allfiles <- list.files(system.file("examples",
      package = "cffr"
    ), pattern = "^DESC", full.names = TRUE)

    names <- list.files(system.file("examples",
      package = "cffr"
    ), pattern = "^DESC", full.names = FALSE)

    for (i in seq_len(length(allfiles))) {
      message("File ", names[i])
      print(cff_create(allfiles[i]))
      message("End----- \n\n")
    }
  })
})
