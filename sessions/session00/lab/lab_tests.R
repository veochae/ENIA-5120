# Lab 00 tests – simple smoke checks

library(testthat)

run_lab00_tests <- function(env) {
  test_that("sessionInfo was run", {
    expect_true(exists("sessionInfo", envir = env))
  })

  test_that("reflection exists", {
    expect_true(exists("reflection_text", envir = env))
    text <- get("reflection_text", envir = env)
    expect_true(is.character(text))
    expect_true(nchar(text) > 20)
  })
}
