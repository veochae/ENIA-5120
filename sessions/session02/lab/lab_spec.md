# Lab 02 – Tidy Data Cleaning and Foundational EDA

## Goals
- Practice core tidyverse verbs (`filter`, `arrange`, `mutate`, `group_by`, `summarise`)
- Diagnose and repair simple data-quality issues (missing categorical values)
- Produce foundational summaries + visuals that echo the lecture content

## Tasks
1. Load `~/ENIA-5120/data/laser_league_players.csv` as `players` (remember to prep `ENIA_ROOT`). Store a `glimpse()` and preview of the first 5 rows.
2. Use at least one pipe (`%>%`) to filter on `role == "Sniper"` and order players by `season_score`. Keep the result visible in the knitted output.
3. Count missing values with `colSums(is.na(players))`. Compute `mode_loadout` (the most common `preferred_loadout`) and create `players_clean` that replaces `NA` loadouts via `coalesce()`.
4. Summarize scores:
   - `role_summary`: total players, average score, and score variability (SD) per `role`, sorted by average score.
   - `squad_summary`: total players and average stamina per `squad_name`, sorted by average stamina.
5. Produce the box plot (season_score by `squad_name`) and bar chart (counts by `home_arena`) exactly as described, and answer the reflection questions in the template.
6. Knit to HTML and submit both `.Rmd` and HTML to Canvas.
