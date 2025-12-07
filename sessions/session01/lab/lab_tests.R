library(testthat)

run_lab01_tests <- function(env) {
  test_that("sales_df exists", {
    expect_true(exists("sales_df", envir = env))
    df <- get("sales_df", envir = env)
    expect_s3_class(df, "data.frame")
  })

  test_that("summary_tbl looks right", {
    expect_true(exists("summary_tbl", envir = env))
    tbl <- get("summary_tbl", envir = env)
    expect_true(all(c("category", "mean_price") %in% names(tbl)))
    expect_true(is.numeric(tbl$mean_price))
  })
}
