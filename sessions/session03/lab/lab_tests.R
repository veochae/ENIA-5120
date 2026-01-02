library(testthat)

run_lab03_tests <- function(env) {
  test_that("players data exists", {
    expect_true(exists("players", envir = env))
    expect_s3_class(get("players", envir = env), "data.frame")
  })

  test_that("league average reflex exists", {
    expect_true(exists("league_avg_reflex", envir = env))
    avg_reflex <- get("league_avg_reflex", envir = env)
    expect_true(is.numeric(avg_reflex))
    expect_true(length(avg_reflex) == 1)
  })
}
