library(testthat)

run_lab05_tests <- function(env) {
  required_objs <- c(
    "ag_raw", "ag_clean", "train_df", "test_df",
    "model_v1", "model_v2", "model_v3", "model_performance"
  )

  for (obj in required_objs) {
    test_that(paste(obj, "exists"), {
      expect_true(exists(obj, envir = env), info = paste0(obj, " not found"))
    })
  }

  test_that("cleaned data has required columns", {
    df <- get("ag_clean", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true(all(c(
      "soil_quality", "seed_variety", "fertilizer_amount_kg_per_hectare",
      "sunny_days", "rainfall_mm", "irrigation_schedule",
      "soil_ph", "farm_size_hectares", "pest_management_score", "harvest_delay_days",
      "yield_kg_per_hectare"
    ) %in% names(df)))
  })

  test_that("seed_variety is categorical-like", {
    df <- get("ag_clean", envir = env)
    expect_true(is.factor(df$seed_variety) || is.character(df$seed_variety))
  })

  test_that("70/30 split is approximately correct", {
    train_df <- get("train_df", envir = env)
    test_df <- get("test_df", envir = env)
    ratio <- nrow(train_df) / (nrow(train_df) + nrow(test_df))
    expect_true(ratio > 0.65 && ratio < 0.75)
  })

  test_that("models are lm objects", {
    expect_s3_class(get("model_v1", envir = env), "lm")
    expect_s3_class(get("model_v2", envir = env), "lm")
    expect_s3_class(get("model_v3", envir = env), "lm")
  })

  test_that("V1 uses one predictor and V2 includes seed_variety", {
    v1_terms <- attr(terms(get("model_v1", envir = env)), "term.labels")
    v2_terms <- attr(terms(get("model_v2", envir = env)), "term.labels")
    v3_terms <- attr(terms(get("model_v3", envir = env)), "term.labels")
    expect_equal(length(v1_terms), 1)
    expect_true(any(grepl("^seed_variety$", v2_terms)))
    expect_true(any(grepl("^soil_ph$", v2_terms)))
    expect_false(any(grepl("^soil_ph$|^farm_size_hectares$|^pest_management_score$|^harvest_delay_days$", v3_terms)))
  })

  test_that("model_performance has required metrics", {
    perf <- get("model_performance", envir = env)
    expect_s3_class(perf, "data.frame")
    expect_true(all(c("model", "MAE", "RMSE", "MAPE", "R2", "Adjusted_R2") %in% names(perf)))
    expect_equal(nrow(perf), 3)
  })
}
