# HW02 Model Answer - Script Version

library(tidyverse)

# Load data
sites_raw <- read_csv("../../../data/air_quality_sites.csv", show_col_types = FALSE)
policy_raw <- read_csv("../../../data/policy_actions.csv", show_col_types = FALSE)

# Clean sites
sites <- sites_raw %>%
  mutate(
    site_id = str_trim(str_to_upper(site_id)),
    region = str_trim(str_to_title(region)),
    monitor_type = str_trim(str_to_title(monitor_type)),
    county_code = str_pad(county_code, width = 3, side = "left", pad = "0"),
    development_pressure = factor(
      development_pressure,
      levels = c("Low", "Medium", "High", "Severe"),
      ordered = TRUE
    )
  ) %>%
  mutate(
    ozone = if_else(ozone < 0, NA_real_, ozone)
  )

# Clean policy
policy <- policy_raw %>%
  mutate(
    policy_id = str_trim(str_to_upper(policy_id)),
    site_id = str_trim(str_to_upper(site_id)),
    policy_strength = str_trim(str_to_title(policy_strength)),
    policy_strength = factor(
      policy_strength,
      levels = c("None", "Pilot", "Partial", "Full"),
      ordered = TRUE
    ),
    start_date = as.Date(start_date),
    grant_amount = suppressWarnings(as.numeric(grant_amount)),
    compliance_score = if_else(compliance_score < 0 | compliance_score > 100, NA_real_, compliance_score)
  )

# Log transforms
sites <- sites %>% mutate(log_pm25 = log(pm25))
policy <- policy %>% mutate(log_grant = log(grant_amount))

# Merge (left join)
merged <- left_join(sites, policy, by = "site_id")

# EDA: single-variable summary
sites %>%
  summarize(
    pm25_mean = mean(pm25, na.rm = TRUE),
    pm25_median = median(pm25, na.rm = TRUE),
    ozone_mean = mean(ozone, na.rm = TRUE),
    income_mean = mean(median_income, na.rm = TRUE)
  )

# EDA: two-variable relationships
p1 <- sites %>%
  ggplot(aes(industrial_index, pm25)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred") +
  labs(title = "PM2.5 vs Industrial Index", x = "Industrial Index", y = "PM2.5")

p2 <- sites %>%
  ggplot(aes(traffic_index, population_density)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "darkgreen") +
  labs(title = "Traffic Index vs Population Density", x = "Traffic Index", y = "Population Density")

# EDA: multivariable (correlation heatmap)
vars <- sites %>%
  select(traffic_index, population_density, industrial_index, pm25, ozone) %>%
  drop_na()

corr_mat <- cor(vars)
corr_df <- as.data.frame(as.table(corr_mat))

p3 <- corr_df %>%
  ggplot(aes(Var1, Var2, fill = Freq)) +
  geom_tile() +
  scale_fill_gradient2(low = "navy", mid = "white", high = "firebrick", midpoint = 0) +
  labs(title = "Correlation Matrix", x = NULL, y = NULL) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Ratio construction
ratio_df <- merged %>%
  group_by(site_id) %>%
  summarize(
    station_count = first(station_count),
    policy_count = sum(!is.na(policy_id)),
    policies_per_station = policy_count / station_count
  )

ratio_df %>%
  summarize(
    mean_ratio = mean(policies_per_station, na.rm = TRUE),
    median_ratio = median(policies_per_station, na.rm = TRUE)
  )

p4 <- ratio_df %>%
  ggplot(aes(policies_per_station)) +
  geom_histogram(bins = 30, fill = "slateblue", color = "white") +
  labs(title = "Policies per Station", x = "Policies per Station", y = "Count")

# Advanced visualization (map-style)
p5 <- sites %>%
  ggplot(aes(longitude, latitude, color = pm25)) +
  geom_point(alpha = 0.7, size = 2) +
  scale_color_viridis_c(option = "C") +
  coord_quickmap() +
  labs(
    title = "Air Quality Hotspots by Monitoring Site",
    x = "Longitude",
    y = "Latitude",
    color = "PM2.5"
  )

# Print plots
print(p1)
print(p2)
print(p3)
print(p4)
print(p5)
