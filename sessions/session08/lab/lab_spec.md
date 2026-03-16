# Lab 08 - Clustering with Abalone

## Goals
- Standardize numeric features for distance-based clustering.
- Use K-means and hierarchical clustering on the same dataset.
- Use an elbow plot to justify a value of `K`.
- Compare unsupervised clusters with the observed `Type` labels (`M`, `F`, `I`) without treating those labels as the ground truth.

## Scenario
You are exploring whether abalone measurements naturally fall into a small number of groups. You have observed labels (`M`, `F`, `I`), but clustering should be treated as a discovery tool, not a label-recovery exercise.

## Data
Use `~/ENIA-5120/data/abalone.csv`.

## Tasks
1. Load the abalone data and inspect the variables.
2. Keep `Type` as a comparison label and create a numeric-only clustering dataset.
3. Standardize the numeric clustering variables.
4. Run K-means for several candidate values of `K`.
5. Build an elbow plot and justify one final `K`.
6. Fit a final K-means solution using your chosen `K`.
7. Plot the K-means clusters and centroids.
8. Fit hierarchical clustering using Euclidean distance and complete linkage.
9. Plot the dendrogram and cut it into the same number of clusters used for K-means.
10. Compare both clustering methods to `Type` (`M`, `F`, `I`) and interpret where they align or fail to align.

## Required Interpretation Questions
- Why is standardization necessary here?
- Why did you choose your final `K` from the elbow plot?
- What do the K-means clusters appear to represent?
- What do the hierarchical clusters appear to represent?
- Does either method map cleanly to `M`, `F`, `I`? Why or why not?
- If you had to brief a non-technical audience, which method would you trust more for this dataset and what limitation would you mention?
