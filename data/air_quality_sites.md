# air_quality_sites.csv

## Dataset purpose
This dataset represents air quality monitoring sites and surrounding community conditions. It combines
environmental measurements (e.g., PM2.5, ozone), land use and development pressures, and socio‑economic
context (e.g., income, density) to support exploratory analysis of environmental risks and policy needs.

Primary key: site_id (may contain duplicates/whitespace issues intentionally).

## Column definitions
- site_id: unique monitoring site identifier (string). Used as the primary key and to join to policy data.
- region: broad geographic region (nominal; e.g., North/South/East/West/Central).
- county_code: three‑digit county code (string). 
- monitor_type: type of monitoring program (Regulatory, Community, Mobile).
- has_monitoring: logical flag indicating whether an active monitor is currently installed.
- station_count: number of stations or sensors operating at the site (discrete integer).
- traffic_index: index of nearby traffic intensity on a 0–100 scale (higher means more traffic).
- population_density: people per square mile around the site (continuous).
- industrial_index: index of industrial activity on a 0–100 scale (higher means more industry).
- pm25: fine particulate matter (PM2.5) concentration in micrograms per cubic meter
- ozone: ozone concentration in parts per billion (ppb).
- co2_ppm: carbon dioxide concentration in parts per million (ppm).
- asthma_rate: estimated asthma prevalence in percent of population.
- median_income: median household income in USD.
- green_space_pct: percent of nearby land area classified as parks/green space.
- development_pressure: ordinal development pressure rating (Low < Medium < High < Severe).
- latitude: site latitude in decimal degrees.
- longitude: site longitude in decimal degrees.

## Known data quality issues (intentional)
Missing values, invalid categories, negative values, duplicates, and whitespace/case inconsistencies
in IDs.
