# HW 01 Rubric

**Total points:** 30

## Criteria
### data_understanding (4 pts)
Introduces both datasets with purpose, units, and structure; identifies key variables and initial summaries.

| Score | Description                                                                                                                                         |
| ----- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| 4     | Accurate dataset purpose + context; clear structure summary (rows/cols/types); identifies key variables with correct units and basic distributions. |
| 3     | Mostly correct description; minor omissions in units or structure; summaries are present but incomplete.                                            |
| 2     | General description only; limited structure or variable detail; summaries are minimal.                                                              |
| 1     | Superficial description with unclear variables or structure.                                                                                        |
| 0     | No meaningful dataset understanding shown.                                                                                                          |

### cleaning_types_logs (6 pts)
Applies necessary cleaning, corrects types/categories, and performs justified log transform(s).

| Score | Description                                                                                                                                                             |
| ----- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 6     | Comprehensive cleaning pipeline; data types corrected; categories standardized; missing/invalid values handled with rationale; log transform justified and interpreted. |
| 5     | Strong cleaning with minor gaps (e.g., one issue not addressed or rationale thin).                                                                                      |
| 3     | Partial cleaning; some types corrected; limited handling of invalid/missing data; log transform applied but weak justification.                                         |
| 1     | Minimal cleaning; incorrect types remain; log transform missing or incorrect.                                                                                           |
| 0     | No cleaning shown.                                                                                                                                                      |

### merge_strategy (5 pts)
Chooses an appropriate join, verifies results, and discusses merge implications.

| Score | Description                                                                                                            |
| ----- | ---------------------------------------------------------------------------------------------------------------------- |
| 5     | Join choice is justified; key alignment verified (types/format); row counts checked; missingness after join explained. |
| 4     | Join is appropriate and verified with some checks; discussion of implications is brief.                                |
| 2     | Join performed but limited verification; missingness or key issues not discussed.                                      |
| 1     | Join type appears arbitrary; no verification.                                                                          |
| 0     | No merge performed.                                                                                                    |

### eda_single_two (6 pts)
Single‑ and two‑variable EDA with correct summaries, plots, and interpretations.

| Score | Description                                                                                                                             |
| ----- | --------------------------------------------------------------------------------------------------------------------------------------- |
| 6     | Clear univariate summaries and visuals; at least two bivariate relationships analyzed with correct plots and thoughtful interpretation. |
| 5     | Good EDA; minor issues in plot choice/interpretation or limited bivariate depth.                                                        |
| 3     | Basic summaries and plots; interpretations are brief or partially incorrect.                                                            |
| 1     | Minimal EDA; plots or summaries are missing/incorrect.                                                                                  |
| 0     | No EDA evidence.                                                                                                                        |

### multivariable_collinearity (4 pts)
Multi‑variable analysis addresses multicollinearity with appropriate diagnostics/visuals.

| Score | Description                                                                                                          |
| ----- | -------------------------------------------------------------------------------------------------------------------- |
| 4     | Uses appropriate diagnostic (correlation matrix, scatter matrix, or VIF) and correctly interprets multicollinearity. |
| 3     | Diagnostic used but interpretation is limited or partially incorrect.                                                |
| 2     | Multi‑variable analysis present but weak diagnostic/interpretation.                                                  |
| 1     | Mentions multicollinearity without evidence.                                                                         |
| 0     | No multi‑variable analysis.                                                                                          |

### visualization_story (3 pts)
Visualizations are clear, labeled, and the advanced graphic supports the story.

| Score | Description                                                                                              |
| ----- | -------------------------------------------------------------------------------------------------------- |
| 3     | All visuals labeled and readable; advanced visualization is well‑designed and strengthens the narrative. |
| 2     | Most visuals are clear; advanced visualization exists but is weakly connected to the story.              |
| 1     | Visuals are cluttered or lack labels; advanced visualization is missing or confusing.                    |
| 0     | No meaningful visualizations.                                                                            |

### ratio_construction (2 pts)
Constructs and interprets meaningful ratios derived from merged data.

| Score | Description                                                                       |
| ----- | --------------------------------------------------------------------------------- |
| 2     | Ratio(s) correctly constructed, explained, and used in analysis or visualization. |
| 1     | Ratio constructed but interpretation or use is weak.                              |
| 0     | No ratio construction.                                                            |
