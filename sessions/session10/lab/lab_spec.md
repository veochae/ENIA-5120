# Lab 10 - Storytelling and Shiny

## Goals

- build an interactive Shiny dashboard from a real course dataset
- make interface choices that support a clear analytical story
- practice turning a dataset into a focused, stakeholder-friendly interface

## Time Plan

- Shiny dashboard build, about 60 minutes

## Task

Use `~/ENIA-5120/data/wa_ev_population.csv` to build a small but meaningful EV storytelling dashboard.

Your app should include:

1. At least three inputs:
   - a county selector
   - a model year range slider
   - an EV type selector or make selector
2. At least three outputs:
   - one plot
   - one summary table
   - one short text or KPI output that states a takeaway
3. A reactive filtered dataset named `filtered_story`
4. A Shiny app object named `story_dashboard`

Design expectation:

> The dashboard should help a user answer a real question, not just flip filters at random.

## Reflection

Write 3-5 sentences explaining:

- what question your dashboard is designed to answer
- why you chose these inputs instead of other possible controls
- what the KPI, plot, and table each contribute to the story
