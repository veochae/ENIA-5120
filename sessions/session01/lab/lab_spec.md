# Lab 01 – Meet Your Dataframe

## Goals

- Practice the ENIA-5120 folder setup (`ENIA_ROOT`)
- See what a dataframe looks like in R (rows, columns, simple metadata)
- Run basic data quality checks with the easiest possible commands
- Summarize missing values by arena to spot potential issues

## Tasks

0. (Optional) If this is your first R session on a new machine, run `install.packages(c("readr","dplyr"))` once.
1. Load `~/ENIA-5120/data/laser_league_players.csv` as `players`, and save `table_preview <- head(players, 5)` so you can see the first few rows.
2. Store `row_count <- nrow(players)` and `col_count <- ncol(players)` for reference.
3. Save all column names in `column_names <- names(players)`. Record example data types with `player_id_type`, `season_score_type`, and `reaction_time_type <- class(players$reaction_time_sec)[1]`. (If you want, create `type_summary` to list every column/type.)
4. Run `season_score_summary <- summary(players$season_score)` so you can cite medians/max values in your reflection.
5. Compute `missing_totals <- colSums(is.na(players))` and also `missing_checks`, a small data frame with columns `column` + `missing_n` covering `season_score`, `favorite_drink`, and `glow_rating`.
6. Store `home_arena_counts <- players %>% count(home_arena) %>% arrange(desc(n))` to surface messy labels, and `duplicate_ids <- sum(duplicated(players$player_id))` to capture ID issues.
7. End with written answers to the reflection questions (nominal vs ordinal, missing data implications, spotting inconsistencies, etc.).
8. Knit and submit the `.Rmd` to Canvas.
