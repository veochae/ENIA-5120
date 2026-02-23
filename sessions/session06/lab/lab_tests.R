library(testthat)

run_lab06_tests <- function(env) {
  test_that("cleaned data and split exist", {
    expect_true(exists("policy_clean", envir = env))
    expect_true(exists("train_df", envir = env))
    expect_true(exists("test_df", envir = env))
  })

  test_that("models exist and are glm", {
    expect_true(exists("model_v1", envir = env))
    expect_true(exists("model_v2", envir = env))
    expect_true(exists("model_v3", envir = env))
    expect_s3_class(get("model_v1", envir = env), "glm")
    expect_s3_class(get("model_v2", envir = env), "glm")
    expect_s3_class(get("model_v3", envir = env), "glm")
  })

  test_that("best cutoff and comparison table exist", {
    expect_true(exists("best_cutoff_v2", envir = env))
    cutoff <- get("best_cutoff_v2", envir = env)
    expect_true(is.numeric(cutoff) && length(cutoff) == 1)
    expect_true(cutoff >= 0 && cutoff <= 1)

    expect_true(exists("model_comparison", envir = env))
    comp <- get("model_comparison", envir = env)
    expect_true(is.data.frame(comp))
    expect_true(all(c("model", "cutoff", "accuracy", "precision", "recall", "AUC") %in% names(comp)))
  })

  test_that("v3 confusion matrix exists", {
    expect_true(exists("cm_v3", envir = env))
    expect_true(is.matrix(get("cm_v3", envir = env)))
  })
}
