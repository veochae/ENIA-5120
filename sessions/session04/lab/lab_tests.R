library(testthat)
run_lab04_tests <- function(env) {
  test_that("squad_events exists", {
    expect_true(exists("squad_events", envir = env))
    df <- get("squad_events", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true("program_name" %in% names(df))
  })

  test_that("program_long tidy", {
    expect_true(exists("program_long", envir = env))
    tbl <- get("program_long", envir = env)
    expect_true(all(c("squad_id", "program_name", "times_joined") %in% names(tbl)))
  })

  test_that("program_comparison summarises scores", {
    expect_true(exists("program_comparison", envir = env))
    comp <- get("program_comparison", envir = env)
    expect_true(all(c("avg_score", "avg_accuracy") %in% names(comp)))
  })
}
