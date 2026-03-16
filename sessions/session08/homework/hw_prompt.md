# Homework 03 - Hypothesis Testing

Use the same datasets from the earlier homeworks:
- `data/air_quality_sites.csv`
- `data/policy_actions.csv`

Produce a knitted report (Rmd or Qmd) plus your source file that uses the data to complete:
- one **t-test**
- one **ANOVA**
- one **chi-squared test**

You may reuse your cleaning and join logic from previous assignments, but this homework should stand on its own as a complete analysis.

## Setup Requirement
- Join the two datasets using `site_id`.
- Do the minimum cleaning needed so the variables used in your tests are valid.
- For each test, choose variables that make sense for that method:
  - **t-test**: one categorical variable with **2 groups** and one continuous outcome
  - **ANOVA**: one categorical variable with **3 or more groups** and one continuous outcome
  - **chi-squared**: two categorical variables

## Questions

### Q1 (35%) - T-Test
Use the merged dataset to perform one meaningful **two-sample t-test**.

For this test, you must:
1. State what you are trying to learn and why you chose these variables.
2. Write the null hypothesis and alternative hypothesis clearly.
3. Run the test.
4. Explain the key values from the output in plain language.
   - This should include the **t-value**, **p-value**, and **confidence interval**.
5. Based on the p-value, judge the result and explain what it means in context.

### Q2 (35%) - ANOVA
Use the merged dataset to perform one meaningful **one-way ANOVA**.

For this test, you must:
1. State what you are trying to learn and why you chose these variables.
2. Write the null hypothesis and alternative hypothesis clearly.
3. Run the ANOVA.
4. Explain the key values from the output in plain language.
   - This should include the **F-value** and **p-value**.
5. Based on the p-value, judge the result and explain what it means in context.
6. If your ANOVA is significant, identify where the difference is coming from (post-hoc).
7. Include one simple visualization that supports the group comparison.

### Q3 (30%) - Chi-Squared Test
Use the merged dataset to perform one meaningful **chi-squared test of association**.

For this test, you must:
1. State what you are trying to learn and why you chose these variables.
2. Write the null hypothesis and alternative hypothesis clearly.
3. Run the chi-squared test.
4. Explain the key values from the output in plain language.
   - This should include the **chi-squared statistic** and **p-value**.
5. Based on the p-value, judge the result and explain what it means in context.
6. Include the contingency table (count matrix) used for the test.

## Required Write-up Standard
For **each** of the three tests, your interpretation should go beyond "reject" or "fail to reject."

You should explain:
- what the result suggests substantively
- whether the effect or difference looks meaningful, not just statistically significant
- one limitation, caution, or assumption relevant to that test

## Final Summary
End with one short concluding section:
- Which of your three tests produced the most decision-useful result, and why?
- Which result should be interpreted most cautiously, and why?

## Deliverables
- A knitted HTML or PDF report with code folded and outputs visible.
- The source `.Rmd` or `.qmd` file.
