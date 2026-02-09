# Homework 02 – Data Cleaning, Merging, and EDA

You will analyze two provided datasets:
- `data/air_quality_sites.csv`
- `data/policy_actions.csv`

Produce a 2–4 page report (Rmd or Qmd) plus your R script that does the following:

1. **Understand the data**
   - Briefly describe each dataset (purpose, units, key variables).
   - Use `glimpse()`, `summary()`, and/or tables to show structure and basic distributions.

2. **Clean the data / correct data types / log transformations**
   - Apply all necessary cleaning steps to ensure valid types, consistent categories, and usable values.
   - Transform at least one skewed variable using a log transform and explain why.

3. **Merge the data**
   - Choose and justify a join strategy.
   - Demonstrate that the merge worked as intended (e.g., row counts, key checks, missingness review).

4. **EDA 1: single‑variable analysis**
   - Provide summary statistics for key variables.
   - Include at least one univariate visualization with clear narration.

5. **EDA 2: two‑variable analysis**
   - Analyze at least two relationships.
   - Include appropriate bivariate visualizations (scatter with linear relationship, boxplot, etc.) with interpretation.

6. **EDA 3: multi‑variable analysis (multicollinearity)**
   - Examine multi‑variable relationships and discuss multicollinearity where relevant.
   - Include an appropriate multi‑variable visualization or diagnostic (e.g., correlation heatmap, scatter matrix).

7. **Ratio construction**
   - Create at least one meaningful ratio after merging (e.g., policy per site, pollution per inspection).
   - Explain its interpretation and relevance.

8. **Advanced visualization**
   - Create one advanced visualization that helps tell a coherent story (e.g., map, faceting, annotated trend).

**Deliverables**
- A pdf or HTML report with your write up rendered by Rmd or Qmd file (code has to be folded, only outputs showing)
- Raw Rmd or Qmd file with your code
