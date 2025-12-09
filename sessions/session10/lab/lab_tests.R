library(testthat)

run_lab10_tests <- function(env) {
  test_that("rmse_value exists", {
    expect_true(exists("rmse_value", envir = env))
    val <- get("rmse_value", envir = env)
    expect_true(is.numeric(val))
  })

  test_that("precision/recall exist", {
    for (name in c("precision_val", "recall_val")) {
      expect_true(exists(name, envir = env))
      val <- get(name, envir = env)
      expect_true(is.numeric(val))
    }
  })
}
