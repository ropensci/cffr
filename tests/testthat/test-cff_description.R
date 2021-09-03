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
      print(cff_description(allfiles[i]))
      message("End----- \n\n")
    }
  })
})
