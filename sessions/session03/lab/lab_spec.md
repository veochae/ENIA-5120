# Lab 03: EV Infrastructure Audit

## Goals
- Load, clean, and type-check EV population and charging station datasets
- Compare demand vs supply at the city level
- Practice joins and ratios to identify infrastructure gaps
- Build clear visual diagnostics (bars, stacked shares, maps)

## Tasks
1. Load `wa_ev_population.csv` and `wa_ev_charge_stations.csv`.
2. Clean station group labels and standardize ZIP codes as character.
3. Compute EV counts by city and visualize the top 15.
4. Compute station counts by city and visualize the top 15.
5. Compare left/inner/full joins and build a city audit with EV-to-station ratios.
6. Compute EV-per-station ratios by city and plot the lowest ratios.
7. Compare station groups (Public vs Private) across top EV-demand cities.
8. Pivot charger tech levels and compare proportional shares by station group.
9. Map EV density vs station locations across Washington (interactive).
