# Final Project - Data Analysis Story Project

This is a **group assignment** to be completed in teams of **2-3 students**.

For the final project, your team will choose:
- a topic of interest
- a dataset or datasets of your choice
- an analytical approach that helps answer your question

The goal is not to complete isolated technical tasks. The goal is to produce a cohesive, professional data analysis project that combines data cleaning, exploratory analysis, hypothesis testing, modeling, interpretation, and presentation into one clear story.

## Final Deliverables

Your team must submit **all three** of the following:

1. **Presentation slides**
2. **Source file** in `.qmd` or `.Rmd`
3. **Knitted report** in **HTML or PDF**

## Big Picture Goal

Throughout the semester, many assignments were done in separate pieces. In this final project, those pieces should come together into one well-organized analysis.

I am looking for:
- a clear question
- evidence that the data supports the question
- careful analysis
- a defensible modeling choice
- strong interpretation
- a professional, story-driven final product

Your final project should feel like something you could refer back to later as a model for a real workplace data analysis assignment.

## Required Project Components

Your project should include the following components.

### 1. Research Question and Motivation

Start by explaining:

1. What question is your team trying to answer?
2. What kind of question is this?
   - explanation?
   - prediction?
   - classification?
   - group discovery?
3. Why is this question important or interesting?

Your opening should make the project direction clear from the beginning.

### 2. Data Source and Data Justification

Describe the data you chose.

You must explain:

1. Where the data came from
2. What the dataset contains
3. Why this data provides enough evidence to analyze your chosen topic
4. Any important context, limitations, or scope issues in the data

### 3. Data Selection and Cleaning

You must prepare the data appropriately before analysis.

This should include and not limiting to, when relevant:
- categorical variable alignment
- standardization or scaling
- missing value handling
- subsetting variables if the full dataset is too large

You do **not** need to write out every cleaning step in exhaustive detail.
However, you **must** report:

1. the starting dimensions of the dataset
2. the ending dimensions after cleaning/subsetting
3. the main categories of cleaning decisions you made

This section should show that the data was prepared intentionally and responsibly.

### 4. Exploratory Data Analysis (EDA)

Perform initial EDA that is directly tied to your topic.

Your EDA should:
- explore relevant variables
- investigate patterns that matter for your question
- include variable-level and multivariable-level analysis when appropriate
- help build the case for the rest of the project

EDA should not feel generic.
It should help the reader understand why the later testing and modeling steps matter.

### 5. Hypothesis Testing

Use **1-2 hypothesis tests** that make sense for your topic and data.

Recommended tests include:
- **t-test**
- **ANOVA**
- **chi-squared test**

For each test, explain:

1. what hypothesis you are evaluating
2. why the test is appropriate
3. what the results suggest in plain language
4. how the test supports or challenges your broader claim

### 6. Modeling

Choose an appropriate modeling approach for your project.

You may use a modeling method covered in class, such as:
- linear regression
- logistic regression
- K-means clustering
- hierarchical clustering

Your modeling section should follow the same standards as **Homework 04**.

That means you should explain:

1. why the chosen modeling approach is appropriate
2. what alternative models, settings, or tuning choices you considered
3. why the final model is the most useful or optimal
4. which variables or features are most important
5. how those variables affect the outcome or clustering result
6. what the model output suggests is true

If your method requires technical support for model quality, include it.

Examples:
- train/test split metrics for regression/classification
- confidence intervals or p-values when relevant
- confusion matrix, precision/recall, or AUC for logistic regression
- elbow plot or silhouette score for K-means
- dendrogram and linkage explanation for hierarchical clustering

### 7. Modeling Results and Interpretation

Once the model is fit, your team should interpret the results carefully.

Do not stop at reporting output.

Explain:
- what the model found
- which variables were significant or influential
- what direction the relationships go
- whether the findings support or weaken your original expectations
- what should be interpreted cautiously

### 8. Final Conclusion

Bring the project back together at the end.

Your conclusion should explain:

1. what your team learned overall
2. how the EDA, hypothesis testing, and modeling results connect
3. whether the evidence supports or disproves your claims
4. what limitations remain
5. what a stakeholder or reader should take away from the project

### 9. Slides for Presentation

Your team should convert the most important findings into presentation slides for class.

The slides should:
- communicate the story clearly
- focus on the most important evidence
- avoid clutter
- be presentation-ready

## Formatting Expectations

### Presentable Knitted Report

The knitted report should be clean, readable, and professional.

Recommended approach:
- use **Quarto**
- use article or paper-style output formatting
- include clearly named sections
- organize text, tables, and figures so the report is easy to follow

### Recommended Section Titles

You may adapt these to your topic, but the report should have clearly named sections such as:

- Executive Summary
- Data Source
- Data Selection
- Exploratory Data Analysis
- Hypothesis Testing
- Modeling
- Modeling Results
- Conclusion

## Group Project Guidelines

### Contribution and Accountability

There will be a brief survey after the last day of class asking about group contribution.

Students who contribute very little to the group project may receive a penalty.

### Use of LLMs and Prior Code

You may use:
- LLMs
- code from labs
- code patterns from prior assignments

However:
- the initial attempt and core writing should be your own for the purpose of learning
- you are still responsible for understanding and defending your work

## What I Am Looking For

### 1. A Cohesive Story

This project should not feel like separate assignments pasted together.

I want to see a real storyline:
- question
- evidence
- analysis
- model
- conclusion

### 2. Quality Visuals

Visuals should be part of the story.

That means:
- quality over quantity
- relevant plots rather than filler plots
- visuals that help the audience understand the argument

Not every technical check needs to become a main presentation graphic.

For example, I do **not** want the report filled with things like:
- log transformation plots for no reason
- missing value count plots that do not support the story

### 3. Technical Proof Where Needed

That said, modeling still requires technical evidence.

For example:
- K-means may need an elbow plot
- logistic regression may need AUC or classification metrics
- regression may need train/test performance or coefficient evidence

These are important because they help justify that the model is sound.

### 4. Professionalism

The final product should feel polished and professional.

I want this project to be something students could refer back to in the future if they need to complete a real-world data analysis assignment at work.

## Deliverables Checklist

Before submitting, make sure your team has:

- presentation slides
- source `.qmd` or `.Rmd` file
- knitted HTML or PDF report
- clearly labeled sections
- evidence of cleaning, EDA, testing, and modeling
- a clear conclusion tied to the full analysis
