# Lab 09 – APIs in R (No Auth + API Key)

## Goals
- Build and run one API call that requires **no authentication**.
- Build and run one API call that requires an **API key**.
- Parse JSON responses into clean data frames for quick policy-relevant summaries.

## APIs for This Lab
1. **No auth API**: Open-Meteo Forecast API  
   Endpoint: `https://api.open-meteo.com/v1/forecast`
2. **Key auth API**: NASA APOD API (free key)  
   Endpoint: `https://api.nasa.gov/planetary/apod`

## Setup
1. Open `lab_template.Rmd`.
2. Install needed packages once if missing: `jsonlite`, `dplyr`, `tibble`.
3. For the NASA section, create a free API key at `https://api.nasa.gov/`.
4. Store your key in `.Renviron`:
   - `NASA_API_KEY=your_key_here`
5. Restart R session after editing `.Renviron`.
6. Verify in R with `Sys.getenv("NASA_API_KEY")` (it should print your key, not an empty string).

## Tasks

### Part A — No Authentication (Open-Meteo)
1. Build `meteo_url` for Washington, DC (`lat = 38.9072`, `lon = -77.0369`) with:
   - `daily=temperature_2m_max,precipitation_sum`
   - `timezone=auto`
2. Pull and parse JSON into `meteo_raw`.
3. Convert `meteo_raw$daily` into `weather_df`.
4. Keep columns: `time`, `temperature_2m_max`, `precipitation_sum`.
5. Create `weather_summary` with:
   - average max temperature
   - total precipitation

### Part B — Authentication (NASA APOD)
1. Read key into `nasa_key <- Sys.getenv("NASA_API_KEY")`.
2. If key is blank, set `nasa_key <- "DEMO_KEY"` and print a message about tighter rate limits.
3. Build `nasa_url` for a short date window (for example `start_date=2026-03-01`, `end_date=2026-03-07`) and include `api_key`.
4. Pull JSON into `nasa_raw`.
5. Convert results to `apod_df` with columns: `date`, `title`, `media_type`, `url`.
6. Create `apod_counts` as counts by `media_type`.

## Reflection Questions
1. What is one practical difference in workflow between no-auth APIs and key-auth APIs?
2. Which API response was easier to clean into a tidy table, and why?
3. What is one reliability risk (rate limit, downtime, missing fields) you noticed?
