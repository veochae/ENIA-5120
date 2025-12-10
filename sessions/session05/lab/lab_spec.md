# Lab 05 – Feature Engineering & Transformation

## Goals
- Practice building reusable transformation pipelines
- Engineer informative numeric and categorical features
- Create squad-level context for each player
- Document every engineered column clearly

## Tasks
1. Load `~/ENIA-5120/data/laser_league_players.csv` as `league_players`.
2. Create `players_engineered` that:
   - Ensures column names are clean (`janitor::clean_names()`).
   - Replaces missing `season_score`, `assists`, and `stamina_score` with the overall median (after cleaning).
   - Adds the columns:
     - `score_per_match = season_score / pmax(matches_played, 1)`
     - `assist_rate = assists / pmax(matches_played, 1)`
     - `stamina_adjusted_score = score_per_match * (stamina_score / 100)`
     - `high_glow = glow_rating >= 8`
     - `accuracy_bucket` using `case_when()` with thresholds: `>=80` = "Elite", `>=65` = "Solid", else "Needs Work"
     - `energy_balance = energy_delta_pct - shield_uptime_pct`
3. Build `squad_features` (one row per squad) summarizing:
   - Average `score_per_match`
   - Percentage of players with `high_glow`
   - Most common `preferred_loadout` (use `dplyr::slice_max` or `janitor::top_n`)
4. Join `players_engineered` with `squad_features` to create `players_with_context`.
5. Create a small tibble named `feature_glossary` with columns `feature_name` and `description` describing each engineered column (at least 5 rows).
6. Knit and submit your `.Rmd` along with a short paragraph explaining which engineered features you expect to help modeling.
