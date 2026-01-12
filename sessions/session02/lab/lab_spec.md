# Lab 02 – Tidy Data Cleaning and Foundational EDA

## Goals
- Diagnose missingness and distribution shape with quick EDA checks
- Compare deletion, mean imputation, and median imputation strategies
- Apply categorical mode imputation and summarize group-level patterns

## Tasks
1. Load `../../../data/laser_league_players.csv` as `players`.
2. Run `colSums(is.na(players))` and plot a histogram of `season_score`.
3. Create `players_deleted`, `players_mean_imp`, and `players_median_imp`, then compare their resulting means/SDs in `comparison`.
4. Compute `mode_val` for `preferred_loadout` and create `players_clean` using mode imputation.
5. Build `role_eda` summary with counts, mean, median, and `score_diff` by `role`.
6. Create the box plot of `season_score` by `squad_name` and interpret outliers.
7. Answer all reflection questions and submit `.Rmd` and HTML to Canvas.
