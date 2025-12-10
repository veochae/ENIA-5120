library(testthat)

run_lab01_tests <- function(env) {
  required <- c(
    "players",
    "table_preview",
    "row_count",
    "col_count",
    "column_names",
    "players_class",
    "players_glimpse",
    "player_id_type",
    "season_score_type",
    "reaction_time_type",
    "season_score_summary",
    "missing_totals",
    "missing_checks",
    "home_arena_counts",
    "duplicate_ids"
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

  test_that("counts and names align with dataframe", {
    df <- get("players", envir = env)
    expect_equal(get("row_count", envir = env), nrow(df))
    expect_equal(get("col_count", envir = env), ncol(df))
    expect_equal(get("column_names", envir = env), names(df))
  })

  test_that("stored types are character strings", {
    expect_true(is.character(get("player_id_type", envir = env)))
    expect_true(is.character(get("season_score_type", envir = env)))
    expect_true(is.character(get("reaction_time_type", envir = env)))
  })

  test_that("season_score summary captured", {
    ss <- get("season_score_summary", envir = env)
    expect_is(ss, "summaryDefault")
  })

  test_that("missing information recorded", {
    totals <- get("missing_totals", envir = env)
    expect_true(is.numeric(totals))
    mc <- get("missing_checks", envir = env)
    expect_true(all(c("column", "missing_n") %in% names(mc)))
    expect_true(all(c("season_score", "favorite_drink", "glow_rating") %in% mc$column))
  })

  test_that("home_arena_counts and duplicate_ids computed", {
    hac <- get("home_arena_counts", envir = env)
    expect_true(all(c("home_arena", "n") %in% names(hac)))
    expect_gte(get("duplicate_ids", envir = env), 0)
  })
}
