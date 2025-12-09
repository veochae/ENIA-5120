library(testthat)

run_lab09_tests <- function(env) {
  test_that("kmeans_model exists", {
    expect_true(exists("kmeans_model", envir = env))
    obj <- get("kmeans_model", envir = env)
    expect_s3_class(obj, "kmeans")
  })

  test_that("cust_clustered has cluster column", {
    expect_true(exists("cust_clustered", envir = env))
    df <- get("cust_clustered", envir = env)
    expect_true("cluster" %in% names(df))
  })
}
