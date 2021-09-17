test_that("Parse one person", {
  p <- person("one", "person")
  expect_snapshot_output(cff_parse_person(p))
})

test_that("Parse several persons", {
  p <- c(
    person("one", "person"), person("another", "human"),
    person("and one", "more")
  )
  expect_snapshot_output(cff_parse_person(p))
})
