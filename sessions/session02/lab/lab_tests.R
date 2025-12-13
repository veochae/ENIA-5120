library(testthat)

run_lab02_tests <- function(env) {
  required <- c(
    "players",
    "players_clean",
    "mode_loadout",
    "role_summary",
    "squad_summary"
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

  test_that("preferred_loadout imputed in players_clean", {
    df <- get("players_clean", envir = env)
    expect_false(any(is.na(df$preferred_loadout)))
  })

  test_that("role_summary columns present", {
    tbl <- get("role_summary", envir = env)
    expect_true(all(c("role", "total_players", "avg_score") %in% names(tbl)))
  })

  test_that("squad_summary columns present", {
    tbl <- get("squad_summary", envir = env)
    expect_true(all(c("squad_name", "total_players", "avg_stamina") %in% names(tbl)))
  })
}
