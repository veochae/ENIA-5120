# Lab 02 – Data Cleaning Strategies and Exploratory Data Analysis (EDA)

## Goals
- Diagnose missingness, balance, and distribution shape with quick EDA checks
- Compare deletion, mean imputation, and median imputation strategies
- Apply categorical mode imputation and interpret relationships/outliers

## Tasks
1. Load `../../../data/gfw_outputs/efforts_by_flag_gear.csv` as `df` and inspect structure.
2. Produce `numeric_summary` and `missing_totals` for basic diagnostics.
3. Create `flag_counts`, `geartype_counts`, `flag_bar_plot`, and `gear_bar_plot` to assess class imbalance.
4. Compare deletion vs. mean/median imputation on `crew_size`, and store results in `comparison`.
5. Compute `mode_flag`, create `df_mode_imp`, and set `df_imputed` for downstream analysis.
6. Flag 3-SD outliers in `apparent_fishing_hours`, then create `box_overall` and `box_trim`.
7. Create a log-transform diagnostic plot using `catch_value_usd` and `log_catch_value`.
8. Build a correlation heatmap in raw units and a scatterplot with a linear model + equation.
9. Create a box plot of fishing hours by gear type using the trimmed dataset.
