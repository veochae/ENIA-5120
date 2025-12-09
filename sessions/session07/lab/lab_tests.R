library(testthat)

run_lab07_tests <- function(env) {
  test_that("model_lm exists", {
    expect_true(exists("model_lm", envir = env))
    obj <- get("model_lm", envir = env)
    expect_s3_class(obj, "lm")
  })

  test_that("coef_table has estimates", {
    expect_true(exists("coef_table", envir = env))
    tbl <- get("coef_table", envir = env)
    expect_true(all(c("term", "estimate", "p.value") %in% names(tbl)))
  })
}
