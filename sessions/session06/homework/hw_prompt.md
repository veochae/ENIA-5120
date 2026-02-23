# Homework 02 – Advanced Data Visualization Storytelling

Use the same datasets as HW1:
- `data/air_quality_sites.csv`
- `data/policy_actions.csv`

Produce a short knitted report (Rmd or Qmd) that includes **4 visualizations** and a short write-up.

## Setup Requirement
- Join the two datasets using `site_id` before building visuals. Leverage what you have done for HW 1 if need for cleaning. 

## Questions (Build These 4 Visualizations)

### Q1 (30%)
Create a **violin plot** that compares one air-quality-related outcome across a policy grouping variable.
- Hint: choose one continuous outcome from `air_quality_sites` and one grouping variable from `policy_actions`.
- Include an explanation of what distribution differences you observe.

### Q2 (30%)
Create a **facet wrap visualization** that reveals a relationship across subgroups.
- Hint: use one numeric x-axis, one numeric y-axis, and facet by one categorical variable.
- Explain how the relationship changes across facets.

### Q3 (30%)
Create a **bubble scatter plot** for a policy decision narrative.
- Hint: map one variable to x, one to y, one to bubble size, and one to color.
- Explain the decision insight from the size and color patterns.
- **Bonus:** If you convert this plot to interactive using `plotly::ggplotly()`, you can earn bonus credit.

### Q4 (10%)
Create a **ridgeline density plot** comparing a key outcome across groups.
- Hint: choose one continuous outcome and one categorical grouping variable.
- **Hint:** use package `ggridges` and function `geom_density_ridges()`.

## Required Write-up (short, focused)
For **each** visualization, include:
1. The question the chart is trying to answer.
2. What the chart shows (1 short paragraph).
3. One caveat or limitation (if any).

Then include a final 1-paragraph summary:
- If you were briefing leadership, what are the top 2 insights and 1 caution?

## Bonus (optional)
- +2 bonus points for converting the bubble scatter plot (Q3) into an interactive Plotly chart using `ggplotly()` in a meaningful way.

## Deliverables
- A knitted HTML or PDF report (code folded; outputs visible).
- The source `.Rmd` or `.qmd` file.
