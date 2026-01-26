#download usethis
#options(repos = c(CRAN = "https://cloud.r-project.org"))
#install.packages("gert", type = "binary")
#install.packages("usethis", type = "binary")


#load packages
library(usethis)
library(gfwr)
library(dplyr)
library(readr)

# -----------------------------
# 1) User-configurable settings
# -----------------------------
# Choose a compact time window for class (1–3 months is plenty)
START_DATE <- "2023-01-01"
END_DATE   <- "2023-04-01"   # end is exclusive in many APIs; keep it simple

# Pick a region source + name.
# Good beginner choices:
#   region_source = "EEZ"  + ISO3 (e.g., "PER", "USA", "KOR")
#   region_source = "MPA"  + keyword (e.g., "Galapagos", "Phoenix")
REGION_SOURCE <- "EEZ"
REGION_QUERY  <- "PER"     # Peru EEZ (ISO3). Change to "USA", "KOR", etc.

# Resolution choices (keep LOW for speed)
SPATIAL_RES   <- "LOW"
TEMPORAL_RES  <- "MONTHLY"

# Optional filters (SQL-like). Leave as NULL if you want all.
# Examples:
# FILTER_SQL <- NULL
# FILTER_SQL <- "geartype IN ('TRAWLERS','LONGLINERS')"
# FILTER_SQL <- "flag IN ('CHN','ESP','USA')"
FILTER_SQL <- NULL

# Output folder
OUT_DIR <- "gfw_outputs"
dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

# -----------------------------
# 2) Token check + auth
# -----------------------------
# usethis::edit_r_environ()

# This will error if token is invalid / not picked up
key <- gfw_auth()

# -----------------------------
# 3) Resolve region ID
# -----------------------------
# gfw_region_id returns a tibble with candidate IDs + labels
region_tbl <- gfw_region_id(region = REGION_QUERY, region_source = REGION_SOURCE)

if (nrow(region_tbl) == 0) {
  stop("No regions found. Try a different REGION_QUERY or REGION_SOURCE.")
}

# Pick the first match by default (you can choose a specific row if multiple)
REGION_ID <- region_tbl$id[1]
message("Using region: ", region_tbl$label[1], " (id=", REGION_ID, ")")

# Save region lookup
write_csv(region_tbl, file.path(OUT_DIR, "region_candidates.csv"))

# -----------------------------
# 4) Helper: run request + (if needed) fetch last report
# -----------------------------
# Some larger queries may return a "report" job. gfwr provides gfw_last_report().
# This helper tries the call, and if a report is being generated, it fetches it.
run_effort <- function(...) {
  res <- gfw_ais_fishing_hours(...)
  
  # In many cases res is already the tibble you want.
  # If the API queued a report, gfw_last_report() is used to retrieve it.
  # We try to detect this by attempting gfw_last_report() if res looks "empty-ish".
  if (is.list(res) && !("fishing_hours" %in% names(res))) {
    # If the structure changes, just return res and let the user inspect.
    return(res)
  }
  
  if (is.data.frame(res) && nrow(res) == 0) {
    # Try fetching last report (if request was queued)
    message("Result is empty; attempting gfw_last_report() (in case a report is processing)...")
    # This may error if there is no pending/finished report; that's fine.
    res2 <- tryCatch(gfw_last_report(), error = function(e) NULL)
    if (!is.null(res2)) return(res2)
  }
  
  res
}

# -----------------------------
# 5) A) Vessel-level fishing hours (best for skew/outliers)
# -----------------------------
effort_by_vessel_monthly <- run_effort(
  spatial_resolution  = SPATIAL_RES,
  temporal_resolution = TEMPORAL_RES,
  start_date = START_DATE,
  end_date   = END_DATE,
  region_source = REGION_SOURCE,
  region = REGION_ID,
  group_by = "MMSI",
  filter_by = FILTER_SQL,
  key = key
)

# Standardize column names (API returns may vary slightly across versions)
# Common columns: mmsi, fishing_hours, start_date/end_date or date/month
effort_by_vessel_monthly <- effort_by_vessel_monthly %>%
  rename_with(tolower)

write_csv(
  effort_by_vessel_monthly,
  file.path(OUT_DIR, "effort_by_vessel_monthly.csv")
)

# Optional: collapse to total fishing hours per vessel for the lab
effort_by_vessel_total <- effort_by_vessel_monthly %>%
  group_by(mmsi) %>%
  summarize(
    fishing_hours = sum(fishing_hours, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(fishing_hours))

write_csv(
  effort_by_vessel_total,
  file.path(OUT_DIR, "effort_by_vessel_total.csv")
)

# -----------------------------
# 6) B) Flag + gear (best for class imbalance)
# -----------------------------
effort_by_flag_gear <- run_effort(
  spatial_resolution  = SPATIAL_RES,
  temporal_resolution = TEMPORAL_RES,
  start_date = START_DATE,
  end_date   = END_DATE,
  region_source = REGION_SOURCE,
  region = REGION_ID,
  group_by = "FLAGANDGEARTYPE",
  filter_by = FILTER_SQL,
  key = key
) %>%
  rename_with(tolower)

write_csv(
  effort_by_flag_gear,
  file.path(OUT_DIR, "effort_by_flag_gear.csv")
)

# Optional: also pull just FLAG (even simpler for students)
effort_by_flag <- run_effort(
  spatial_resolution  = SPATIAL_RES,
  temporal_resolution = TEMPORAL_RES,
  start_date = START_DATE,
  end_date   = END_DATE,
  region_source = REGION_SOURCE,
  region = REGION_ID,
  group_by = "FLAG",
  filter_by = FILTER_SQL,
  key = key
) %>%
  rename_with(tolower)

write_csv(
  effort_by_flag,
  file.path(OUT_DIR, "effort_by_flag.csv")
)

# -----------------------------
# 7) Quick sanity prints (so you know it worked)
# -----------------------------
message("\nTop 10 vessels by total fishing hours:")
print(head(effort_by_vessel_total, 10))

message("\nTop 10 flag+gear rows by fishing hours:")
print(effort_by_flag_gear %>% arrange(desc(fishing_hours)) %>% head(10))

message("\nSaved outputs to: ", normalizePath(OUT_DIR))
############################################################
# End script
############################################################
