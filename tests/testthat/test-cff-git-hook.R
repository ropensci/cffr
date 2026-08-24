test_that("cff_git_hook_install errors when usethis is unavailable", {
  local_mocked_bindings(cff_has_usethis = function() FALSE)

  expect_snapshot(cff_git_hook_install(), error = TRUE)
})
