library(testthat)

run_lab02_tests <- function(env) {
  required <- c(
    "players",
    "players_deleted",
    "players_mean_imp",
    "players_median_imp",
    "comparison",
    "mode_val",
    "players_clean",
    "role_eda"
  )

  for (obj in required) {
    test_that(paste(obj, "exists"), {
      expect_true(exists(obj, envir = env), info = paste(obj, "is missing"))
    })
  }

  test_that("players data frame has expected columns", {
    df <- get("players", envir = env)
    expect_s3_class(df, "data.frame")
    expect_true(all(c("home_arena", "season_score", "preferred_loadout") %in% names(df)))
  })

  test_that("season_score imputations exist", {
    expect_true(all(c("season_score") %in% names(get("players_deleted", envir = env))))
    expect_true(all(c("season_score") %in% names(get("players_mean_imp", envir = env))))
    expect_true(all(c("season_score") %in% names(get("players_median_imp", envir = env))))
  })

  test_that("comparison table exists", {
    comp <- get("comparison", envir = env)
    expect_true(all(c("Strategy", "Resulting_Mean", "Resulting_SD") %in% names(comp)))
  })

  test_that("preferred_loadout imputed in players_clean", {
    df <- get("players_clean", envir = env)
    expect_false(any(is.na(df$preferred_loadout)))
  })

  test_that("role_eda columns present", {
    tbl <- get("role_eda", envir = env)
    expect_true(all(c("role", "n_players", "avg_score", "med_score", "score_diff") %in% names(tbl)))
  })
}
