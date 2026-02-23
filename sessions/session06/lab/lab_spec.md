# Lab 06 – Logistic Regression in Practice

## Goals
- Build and compare logistic regression models for policy adoption.
- Interpret coefficients, odds ratios, ROC, AUC, and threshold tradeoffs.
- Select and justify a best cutoff using Youden's J.

## Scenario
You are advising a state climate office on likely policy adoption by county.

## Data
Use `~/ENIA-5120/data/climate_policy_adoption_synthetic.csv`.

## Tasks
1. Load synthetic policy dataset.
2. Clean data and set variable types.
3. Build Logistic Regression V1 (simple baseline).
4. Assess V1 with ROC, AUC, accuracy, precision, and recall.
5. Build Logistic Regression V2 (expanded model).
6. Find best cutoff for V2 from ROC (Youden's J).
7. Build V3 by applying V2 with best cutoff.
8. Build confusion matrix for V3.
9. Compare V1, V2, and V3 metrics.

## Required Interpretation Questions
- Coefficient interpretation (including odds ratio).
- ROC interpretation.
- AUC interpretation.
- Why the best cutoff is selected.
- Precision vs recall preference in this context.
- Interpretation of V3 confusion matrix.
