# Lab 07 – Linear Regression

## Goals
- Fit linear models with `lm`
- Interpret coefficients
- Examine diagnostic plots

## Tasks
1. Load `~/ENIA-5120/data/laser_league_players.csv`.
2. Fit `model_lm <- lm(season_score ~ matches_played + assists + tag_accuracy_pct + shield_uptime_pct, data = league_df)`.
3. Create a tibble `coef_table` with term, estimate, and p-value from the model.
4. Save diagnostic plots with `plot(model_lm)` (or `autoplot` if available) and comment on residual issues.
5. Compute predictions for a new data frame `new_profiles` provided in the template.
