library(testthat)

run_lab08_tests <- function(env) {
  test_that("churn_model exists", {
    expect_true(exists("churn_model", envir = env))
    obj <- get("churn_model", envir = env)
    expect_s3_class(obj, "glm")
  })

  test_that("conf_accuracy numeric", {
    expect_true(exists("conf_accuracy", envir = env))
    val <- get("conf_accuracy", envir = env)
    expect_true(is.numeric(val))
    expect_true(val >= 0)
  })
}
