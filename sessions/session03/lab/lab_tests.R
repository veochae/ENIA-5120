library(testthat)

run_lab03_tests <- function(env) {
  test_that("ev_pop and ev_stations exist", {
    expect_true(exists("ev_pop", envir = env))
    expect_true(exists("ev_stations", envir = env))
  })

  test_that("city demand/supply exist", {
    expect_true(exists("city_demand", envir = env))
    expect_true(exists("city_supply", envir = env))
  })

  test_that("city audit exists", {
    expect_true(exists("city_audit", envir = env))
  })

  test_that("county_data exists", {
    expect_true(exists("county_data", envir = env))
  })

  test_that("tech_long exists", {
    expect_true(exists("tech_long", envir = env))
  })

  test_that("map_stats exists", {
    expect_true(exists("map_stats", envir = env))
  })
}
