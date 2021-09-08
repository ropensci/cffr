test_that("Error if file not exists", {
  expect_error(
    cff_create("DESCRIPTION_this_doesnt_exists")
  )
})

test_that("Test installed packages", {
  expect_silent(cff_create("jsonlite"))
  expect_silent(cff_create("cffr"))
  expect_silent(cff_create("jsonvalidate"))
})



test_that("Validate all DESCRIPTION files", {
  expect_snapshot_output({
    allfiles <- list.files(system.file("examples",
      package = "cffr"
    ), pattern = "^DESC", full.names = TRUE)

    names <- list.files(system.file("examples",
      package = "cffr"
    ), pattern = "^DESC", full.names = FALSE)

    res <- c()
    for (i in seq_len(length(allfiles))) {
      if (names[i] == "DESCRIPTION_no_encoding") {
        # This throws a warning
        cffobj <- expect_warning(cff_create(allfiles[i]))
      } else {
        cffobj <- cff_create(allfiles[i])
      }


      test <- suppressMessages(cff_validate(cffobj))
      res <- c(res, test)
    }

    df <- data.frame(file = names, result = res)

    print_snapshot("Result of validation: All example DESCRIPTION files", df)
  })
})


test_that("Snapshot all DESCRIPTION files", {
  # This includes cff_description under the hood

  expect_snapshot_output({
    allfiles <- list.files(system.file("examples",
      package = "cffr"
    ), pattern = "^DESC", full.names = TRUE)

    names <- list.files(system.file("examples",
      package = "cffr"
    ), pattern = "^DESC", full.names = FALSE)

    for (i in seq_len(length(allfiles))) {
      if (names[i] == "DESCRIPTION_no_encoding") {
        # This throws a warning
        cffobj <- expect_warning(cff_create(allfiles[i]))
      } else {
        cffobj <- cff_create(allfiles[i])
      }


      print_snapshot(names[i], cffobj)
    }
  })
})
