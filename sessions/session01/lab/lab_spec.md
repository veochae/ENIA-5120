# Lab 01 – Intro to R with Laser League Data

## Goals

- Load the core `laser_league_players.csv` dataset
- Inspect structure and column types
- Produce a simple grouped summary

## Tasks

1. Load `data/laser_league_players.csv` as `league_df`.
2. Report the number of rows/columns and print the column names.
3. Use `str(league_df)` to inspect data types (note the mix of numeric + categorical fields).
4. Create `summary_tbl` that groups by `home_arena` and calculates average `wellbeing_index` and `matches_played`.
5. Knit the template and submit the `.Rmd` to Canvas.
