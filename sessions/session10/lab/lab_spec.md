# Lab 10 – Model Evaluation

## Goals
- Perform train/test split
- Calculate regression and classification metrics
- Compare models

## Tasks
1. Load `~/ENIA-5120/data/laser_league_players.csv`.
2. Create a train/test split (e.g., 75/25) and fit a linear model predicting `season_score` from gameplay metrics; compute RMSE on the test set (`rmse_value`).
3. Using the same split, fit a logistic model predicting `high_glow` (glow rating >= 8) and generate class predictions.
4. Build a confusion matrix (`eval_confusion`) plus precision and recall values (`precision_val`, `recall_val`) for the positive class.
5. Reflect on potential sources of bias or leakage.
