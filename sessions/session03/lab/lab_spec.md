# Lab 03: The Commissioner's Visual Briefing

## Goals
- Use advanced ggplot2 layers (reference lines, annotations, and highlights) to tell a policy story
- Practice density, box plot, scatter, violin, and faceted comparisons with clear themes
- Produce executive-ready visuals with meaningful benchmarks

## Tasks
1. Load `laser_league_players.csv` with tidyverse tools.
2. Mission 1 (Density + VLine): Plot `wellbeing_index` with a vertical line at 55 and a "danger zone" annotation.
3. Mission 2 (Boxplot + HLine): Compare `reflex_score` by `role` and add a league-average reference line.
4. Mission 3 (AbLine): Plot `matches_played` vs `season_score` with a target slope line.
5. Mission 4 (Rect Highlight): Plot `reflex_score` vs `reaction_time_sec` with an elite reaction-time band.
6. Mission 5 (Violin + Curve): Plot `glow_rating` by `role` and annotate the superstar peak.
7. Mission 6 (Facets + Benchmark): Plot `tag_accuracy_pct` vs `shield_uptime_pct` faceted by `squad_name` with a 50% benchmark line.
