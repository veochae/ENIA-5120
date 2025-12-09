library(testthat)

run_lab12_tests <- function(env) {
  test_that("metric_table exists", {
    expect_true(exists("metric_table", envir = env))
    df <- get("metric_table", envir = env)
    expect_s3_class(df, "data.frame")
  })

  test_that("key_takeaways vector", {
    expect_true(exists("key_takeaways", envir = env))
    val <- get("key_takeaways", envir = env)
    expect_true(is.vector(val))
    expect_true(length(val) >= 3)
  })
}
