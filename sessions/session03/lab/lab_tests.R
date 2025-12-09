library(testthat)
run_lab03_tests <- function(env) {
  test_that("league_clean exists", {
    expect_true(exists("league_clean", envir = env))
    df <- get("league_clean", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true("squad_id" %in% names(df))
  })

  test_that("score_imputed filled", {
    expect_true(exists("score_imputed", envir = env))
    df <- get("score_imputed", envir = env)
    expect_true("season_score" %in% names(df))
    expect_false(any(is.na(df$season_score)))
  })

  test_that("arena_summary has expected columns", {
    expect_true(exists("arena_summary", envir = env))
    tbl <- get("arena_summary", envir = env)
    expect_true(all(c("home_arena", "players", "avg_accuracy") %in% names(tbl)))
  })
}
