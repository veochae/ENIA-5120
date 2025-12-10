# Lab 04 – Joining & Reshaping Data

## Goals
- Practice joining the player and event datasets
- Detect and fix messy squad codes
- Reshape participation records for analysis

## Tasks
1. Load `~/ENIA-5120/data/laser_league_players.csv` and `~/ENIA-5120/data/laser_league_events.csv`.
2. Clean both squad-ID columns (trim whitespace, uppercase, remove prefixes like `squad-`) so they align.
3. Perform a `left_join` to create `squad_events`, keeping every player even if they lack event data.
4. Use `count`/`pivot_longer` to create `program_long`, a long table with one row per squad-program combination plus a participation count.
5. Compare squads with and without event participation by computing average `season_score` and `tag_accuracy_pct`.
