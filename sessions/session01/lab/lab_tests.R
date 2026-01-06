library(testthat)

run_lab01_tests <- function(env) {
  required <- c(
    "players",
    "ENIA_ROOT",
    "league_path"
  )

  for (obj in required) {
    test_that(paste(obj, "exists"), {
      expect_true(exists(obj, envir = env), info = paste(obj, "is missing"))
    })
  }

  test_that("players dataframe looks correct", {
    df <- get("players", envir = env)
    expect_s3_class(df, "data.frame")
    expect_gt(nrow(df), 0)
    expect_true(all(c("home_arena", "season_score") %in% names(df)))
  })

  test_that("paths are strings", {
    expect_true(is.character(get("ENIA_ROOT", envir = env)))
    expect_true(is.character(get("league_path", envir = env)))
  })
}
