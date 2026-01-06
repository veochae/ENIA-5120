# Lab 01 – Meet Your Dataframe

## Goals
- Perform a forensic audit of the Laser League dataset
- Confirm data structure, column types, and basic integrity checks
- Identify missingness, inconsistent labels, and duplicate IDs

## Tasks
1. Load `../../../data/laser_league_players.csv` as `players`.
2. Inspect structure with `class(players)`, `nrow()`, `ncol()`, `glimpse()`, and `names()`.
3. Check column types with `class(players$player_id)[1]`, `class(players$season_score)[1]`, and `class(players$reaction_time_sec)[1]`.
4. Summarize `season_score` with `summary(players$season_score)` and interpret the median and max.
5. Scan for missing values using `colSums(is.na(players))`.
6. Check inconsistent categories with `players %>% count(home_arena) %>% arrange(desc(n))`.
7. Check duplicate IDs with `sum(duplicated(players$player_id))`.
8. Answer all reflection questions, including the raw data snippet analysis.
