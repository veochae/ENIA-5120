library(testthat)
run_lab01_tests <- function(env) {
  test_that("league_df exists", {
    expect_true(exists("league_df", envir = env))
    df <- get("league_df", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true("wellbeing_index" %in% names(df))
  })

  test_that("summary_tbl looks right", {
    expect_true(exists("summary_tbl", envir = env))
    tbl <- get("summary_tbl", envir = env)
    expect_true(all(c("home_arena", "avg_wellbeing", "avg_matches") %in% names(tbl)))
    expect_true(is.numeric(tbl$avg_matches))
  })
}
