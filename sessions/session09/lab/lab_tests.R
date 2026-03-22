library(testthat)

run_lab09_tests <- function(env) {
  test_that("Open-Meteo objects exist", {
    expect_true(exists("meteo_url", envir = env))
    expect_true(exists("weather_df", envir = env))

    df <- get("weather_df", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true(all(c("time", "temperature_2m_max", "precipitation_sum") %in% names(df)))
  })

  test_that("NASA objects exist", {
    expect_true(exists("nasa_url", envir = env))
    expect_true(exists("apod_df", envir = env))

    df <- get("apod_df", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true(all(c("date", "title", "media_type", "url") %in% names(df)))
  })

  test_that("Summaries exist", {
    expect_true(exists("weather_summary", envir = env))
    expect_true(exists("apod_counts", envir = env))
  })
}
