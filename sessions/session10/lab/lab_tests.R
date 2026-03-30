library(testthat)

run_lab10_tests <- function(env) {
  test_that("story_dashboard exists and is a shiny app", {
    expect_true(exists("story_dashboard", envir = env))
    app <- get("story_dashboard", envir = env)
    expect_s3_class(app, "shiny.appobj")
  })
}
