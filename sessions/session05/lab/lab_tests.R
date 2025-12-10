library(testthat)

run_lab05_tests <- function(env) {
  objs <- c("players_engineered", "squad_features", "players_with_context", "feature_glossary")
  for (obj in objs) {
    test_that(paste(obj, "exists"), {
      expect_true(exists(obj, envir = env), info = paste0(obj, " not found"))
    })
  }

  test_that("players_engineered has engineered columns", {
    df <- get("players_engineered", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true(all(c(
      "score_per_match",
      "assist_rate",
      "stamina_adjusted_score",
      "high_glow",
      "accuracy_bucket",
      "energy_balance"
    ) %in% names(df)))
  })

  test_that("squad_features summarises squads", {
    sf <- get("squad_features", envir = env)
    expect_true(all(c(
      "squad_id",
      "avg_score_per_match",
      "pct_high_glow",
      "top_loadout"
    ) %in% names(sf)))
    expect_gt(nrow(sf), 0)
  })

  test_that("players_with_context joins squad info", {
    pwc <- get("players_with_context", envir = env)
    expect_true(all(c("avg_score_per_match", "pct_high_glow") %in% names(pwc)))
    expect_equal(nrow(pwc), nrow(get("players_engineered", envir = env)))
  })

  test_that("feature_glossary documents engineered columns", {
    fg <- get("feature_glossary", envir = env)
    expect_s3_class(fg, "data.frame")
    expect_true(all(c("feature_name", "description") %in% names(fg)))
    expect_gte(nrow(fg), 5)
  })
}
