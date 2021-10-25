test_that("Check is.email", {
  # Examples from https://www.nicebread.de/validating-email-adresses-in-r/

  # Valid addresses
  expect_true(
    all(
      is.email("felix@nicebread.de"),
      is.email("felix.123.honeyBunny@nicebread.lmu.de"),
      is.email("felix@nicebread.de  "),
      is.email("    felix@nicebread.de"),
      is.email("felix+batman@nicebread.de"),
      is.email("felix@nicebread.office")
    )
  )
  # invalid addresses
  expect_false(
    any(
      is.email("felix@nicebread"),
      is.email("felix@nicebread@de"),
      is.email("felixnicebread.de"),
      is.email("@felixnicebread")
    )
  )
})


test_that("Check is.url", {

  # Valid urls
  expect_true(
    all(
      is.url("https://github.com/dieghernan"),
      is.url("http://github.com/dieghernan"),
      is.url("ftp://github.com/dieghernan"),
      is.url("sftp://github.com/dieghernan")
    )
  )
  # invalid addresses
  expect_false(
    any(
      is.url("https:/github.com/dieghernan"),
      is.url("http:/github.com/dieghernan"),
      is.url("ftp:/github.com/dieghernan"),
      is.url("sftp:/github.com/dieghernan"),
      is.url("www.github.com/dieghernan")
    )
  )
})
