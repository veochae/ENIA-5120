# Lab 06 – Distributions & Hypothesis Testing

## Goals
- Visualize distributions
- Run t-tests and chi-square tests in R
- Interpret p-values and confidence intervals

## Tasks
1. Load `data/laser_league_players.csv`.
2. Create histograms of `tag_accuracy_pct` split by whether players commute via Hover Tram (`hover_commuter` flag).
3. Run a two-sample t-test comparing `tag_accuracy_pct` between Hover Tram commuters and everyone else (`ttest_result`).
4. Build a contingency table of `preferred_channel` vs `favorite_drink` and run `chisq.test`, saving to `chi_result`.
5. Summarize findings in text.
