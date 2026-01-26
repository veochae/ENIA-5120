library(testthat)

run_lab02_tests <- function(env) {
  required <- c(
    "df",
    "numeric_summary",
    "missing_totals",
    "flag_counts",
    "geartype_counts",
    "flag_bar_plot",
    "gear_bar_plot",
    "df_noflag",
    "df_deleted",
    "df_mean_imp",
    "df_median_imp",
    "comparison",
    "mode_flag",
    "df_mode_imp",
    "df_imputed",
    "hours_mean",
    "hours_sd",
    "hours_outliers",
    "df_trim",
    "box_overall",
    "box_trim",
    "catch_long",
    "corr_mat",
    "corr_long",
    "corr_plot",
    "scatter_plot",
    "lm_fit",
    "eq_text",
    "box_plot"
  )

  for (obj in required) {
    test_that(paste(obj, "exists"), {
      expect_true(exists(obj, envir = env), info = paste(obj, "is missing"))
    })
  }

  test_that("df data frame has expected columns", {
    df <- get("df", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true(all(c("flag", "geartype", "apparent_fishing_hours") %in% names(df)))
  })

  test_that("crew_size imputations exist", {
    expect_true(all(c("crew_size") %in% names(get("df_deleted", envir = env))))
    expect_true(all(c("crew_size") %in% names(get("df_mean_imp", envir = env))))
    expect_true(all(c("crew_size") %in% names(get("df_median_imp", envir = env))))
  })

  test_that("flag_counts columns present", {
    tbl <- get("flag_counts", envir = env)
    expect_true(all(c("flag", "n") %in% names(tbl)))
  })

  test_that("comparison table exists", {
    comp <- get("comparison", envir = env)
    expect_true(all(c("Strategy", "Resulting_Mean", "Resulting_SD") %in% names(comp)))
  })

  test_that("flag imputed in df_mode_imp", {
    df <- get("df_mode_imp", envir = env)
    expect_false(any(is.na(df$flag)))
  })
}
