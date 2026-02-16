# Lab 05 – Linear Regression Workflow (Agricultural Yield)

## Goals
- Frame a policy-style regression question using agricultural yield data
- Clean and prepare a simple modeling dataset (no feature engineering)
- Split data into train/test with a reproducible 70/30 workflow
- Compare three model versions: simple -> expanded -> trimmed
- Interpret coefficients, confidence intervals, and fit metrics
- Select a final model using both training fit and test-set performance

## Tasks
1. Define a regression question with `yield_kg_per_hectare` as the outcome.
2. Load `agricultural_yield_combined.csv` and keep rows with valid values.
3. Split data into `train_df` and `test_df` using a 70/30 rule.
4. Fit **Model V1 (simple)** with one numeric predictor.
5. Fit **Model V2 (expanded)** using all available predictor columns **except** `soil_quality`.
6. Fit **Model V3 (trimmed)** using only the original predictors from the pre-fabrication dataset.
7. Compare V1/V2/V3 using **MAE, RMSE, MAPE, R², Adjusted R²**.
8. Answer interpretation questions about coefficient meaning, uncertainty, and model tradeoffs.
