# Lab 03 – Data Cleaning with dplyr

## Goals
- Practice select/filter/mutate pipelines
- Handle missing values and inconsistent casing
- Produce a cleaned dataset ready for analysis

## Tasks
1. Load `data/laser_league_players.csv` as `league_raw`.
2. Remove duplicate rows based on `player_id` to create `league_dedup`.
3. Build `league_clean` that:
   - Uses `janitor::clean_names()`
   - Trims whitespace and uppercases `squad_id`
   - Replaces missing `preferred_loadout` with "Unknown Loadout"
   - Standardizes `favorite_drink` to title case
4. Create `score_imputed` by replacing missing `season_score` with the median score for each `squad_name`.
5. Summarize the cleaned data as `arena_summary` with player counts and average `tag_accuracy_pct` per `home_arena`.
6. Knit the template and submit the `.Rmd` to Canvas.
