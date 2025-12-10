# Lab 08 – Logistic Regression

## Goals
- Fit logistic regression with `glm`
- Convert log-odds to predicted probabilities
- Evaluate with confusion matrix

## Tasks
1. Load `~/ENIA-5120/data/laser_league_players.csv` as `league_df`.
2. Create `high_glow` (1 if `glow_rating >= 8`, else 0) and fit `glow_model <- glm(high_glow ~ matches_played + tag_accuracy_pct + shield_uptime_pct, family = binomial, data = league_df)`.
3. Create `glow_pred` with predicted probabilities using `type = "response"`.
4. Build a confusion matrix with threshold 0.5 stored as `conf_mat`.
5. Calculate accuracy as `conf_accuracy`.
