# Lab 09 – Clustering

## Goals
- Apply k-means clustering
- Use elbow method to choose k
- Visualize clusters

## Tasks
1. Load `~/ENIA-5120/data/laser_league_players.csv` as `cust_df`.
2. Select numeric features (age, volunteer_hours, energy_reduction_pct, wellbeing_index, monthly_water_usage_l) and scale them as `cust_scaled`.
3. Use `map_dbl` to compute total within-cluster sum of squares for k = 2:6 (`wss_values`).
4. Fit `kmeans_model` with a chosen k (justify in comments).
5. Append cluster assignments back to the original data as `cust_clustered`.
