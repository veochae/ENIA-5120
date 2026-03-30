# Homework 04 - Modeling Choice Project

Use the same two course datasets from earlier assignments:
- `data/air_quality_sites.csv`
- `data/policy_actions.csv`

Your homework should use these two datasets as the basis for the analysis. You may work with one dataset alone if your modeling choice clearly fits it, or join/use both when that improves the analysis.

Produce one knitted report (`.Rmd` or `.qmd`) plus your source file. In this homework, you will choose **one** of the following modeling approaches:

1. **Linear regression**
2. **Logistic regression**
3. **K-means clustering**
4. **Hierarchical clustering**

Your job is not just to run a model. Your job is to justify why this method fits your question, explain how you chose the final model setup, and interpret what the results actually show.

## Required Opening Section

Before showing model output, include a short setup section that answers:

1. What question are you trying to answer?
2. Why is your chosen modeling method the right tool for that question?
3. What are you trying to test, predict, compare, or discover?
4. Which dataset and variables are you using, and why do they make sense?

This section should make it clear that the method follows from the analytical question, not the other way around.

## Choose One Model Path

You will complete **one** of the four paths below.

---

## Option 1 (Linear Regression)

Use **linear regression** when your outcome variable is numeric and your goal is to explain or predict how that outcome changes with one or more predictors.

Your report must:

1. State the outcome variable and predictor variables clearly.
2. Explain why linear regression is appropriate for this question.
3. Fit at least **two reasonable candidate models** and explain why your final model is the most useful or optimal.
4. Use a **train/test split** and explain why it is necessary for evaluating the model on unseen data.
5. Report and interpret the most important model outputs in plain language:
   - coefficients
   - **p-values**
   - **confidence intervals**
   - **R-squared** or **adjusted R-squared**
   - **MAE**, **RMSE**, or other relevant prediction metrics from the test set
6. Explain which variables matter most and how they affect the outcome variable.
7. Include at least one visualization that supports the regression story.
8. End with a short conclusion describing what you found to be true and one limitation or caution.

What is especially important to see:
- why the final model was chosen over alternatives
- which variables have the strongest contribution or impact
- whether coefficient signs and magnitudes make substantive sense
- what the p-values and confidence intervals suggest
- whether the model is useful for explanation, prediction, or both

---

## Option 2 (Logistic Regression)

Use **logistic regression** when your outcome variable is binary and your goal is to estimate probabilities or classify cases into two groups.

Your report must:

1. State the binary outcome variable and predictor variables clearly.
2. Explain why logistic regression is appropriate for this question.
3. Fit at least **two reasonable candidate models** and explain why your final model is the most useful or optimal.
4. Use a **train/test split** and explain why the split is necessary for evaluating the classifier on unseen data.
5. Report and interpret the most important model outputs in plain language:
   - coefficient signs
   - **p-values**
   - odds ratios and/or probability interpretation
   - confidence intervals if used
   - classification metrics such as **accuracy**, **precision**, **recall**, or **AUC**
6. Explain which variables are most influential in moving the outcome toward Yes/No.
7. Include at least one model-evaluation output such as a confusion matrix, ROC curve, or threshold-based interpretation.
8. End with a short conclusion describing what you found to be true and one limitation or caution.

What is especially important to see:
- why the final logistic model was chosen over alternatives
- how predictors change the odds or probability of the outcome
- whether coefficients are statistically meaningful
- how well the model separates the two classes
- why your evaluation metric(s) make sense for this problem

---

## Option 3 (K-Means Clustering)

Use **K-means clustering** when you want to discover groups in unlabeled numeric data.

Your report must:

1. Explain what kinds of groups or patterns you are trying to discover.
2. Explain why K-means is appropriate for this question.
3. Describe the variables included in the clustering analysis and why they were chosen.
4. Explain how you prepared the data, including any scaling or filtering.
5. Compare at least **two candidate values of K** and explain how you chose the final K.
6. Include and interpret relevant outputs such as:
   - elbow plot
   - cluster visualization
   - cluster sizes
   - centroid summaries or cluster profiles
   - silhouette score if you choose to use it
7. Describe what distinguishes the final clusters from one another.
8. End with a short conclusion describing what the groupings suggest and one limitation or caution.

What is especially important to see:
- why your chosen K is defensible
- what variables seem to differentiate clusters most strongly
- whether the resulting groups are substantively useful
- how scaling and variable choice affect the result

---

## Option 4 (Hierarchical Clustering)

Use **hierarchical clustering** when you want to study nested grouping structure and inspect how observations merge over time.

Your report must:

1. Explain what kinds of groups or structure you are trying to discover.
2. Explain why hierarchical clustering is appropriate for this question.
3. Describe the variables included in the clustering analysis and why they were chosen.
4. Explain how you prepared the data, including any scaling or filtering.
5. State the linkage method you used and why.
6. Include and interpret relevant outputs such as:
   - dendrogram
   - chosen cut level or number of clusters
   - cluster sizes
   - cluster summaries or profiles
7. Explain what the final grouping structure reveals about the data.
8. End with a short conclusion describing what the groupings suggest and one limitation or caution.

What is especially important to see:
- why the linkage method and cut level are reasonable
- what early and late merges reveal
- how the final groups differ in their characteristics
- whether the structure is useful for interpretation or decision-making

## Required Write-up Standard

Your interpretation must go beyond printing output.

You should explain:
- why the chosen method fits the problem
- why the final model/setup is better than the alternatives you considered
- what the most important variables or cluster characteristics are
- what the results suggest in plain language
- one limitation, caution, or assumption that affects interpretation

## Final Summary

End with one short concluding section:
- What did your chosen model help you learn that a simpler summary would not?
- What result from your analysis should be interpreted most cautiously, and why?

## Deliverables

- A knitted HTML or PDF report with code folded and outputs visible.
- The source `.Rmd` or `.qmd` file.
