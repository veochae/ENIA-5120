library(testthat)

run_lab06_tests <- function(env) {
  test_that("ttest_result exists", {
    expect_true(exists("ttest_result", envir = env))
    obj <- get("ttest_result", envir = env)
    expect_s3_class(obj, "htest")
  })

  test_that("chi_result exists", {
    expect_true(exists("chi_result", envir = env))
    obj <- get("chi_result", envir = env)
    expect_s3_class(obj, "htest")
  })
}
