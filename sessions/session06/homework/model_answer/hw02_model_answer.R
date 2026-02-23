# HW02 Model Answer - Script Version

library(tidyverse)

sites_path_candidates <- c("../../../data/air_quality_sites.csv", "data/air_quality_sites.csv")
policy_path_candidates <- c("../../../data/policy_actions.csv", "data/policy_actions.csv")

sites_path <- sites_path_candidates[file.exists(sites_path_candidates)][1]
policy_path <- policy_path_candidates[file.exists(policy_path_candidates)][1]

sites_raw <- read_csv(sites_path, show_col_types = FALSE)
policy_raw <- read_csv(policy_path, show_col_types = FALSE)

sites <- sites_raw %>%
  mutate(
    site_id = str_trim(str_to_upper(site_id)),
    region = str_trim(str_to_title(region))
  )

policy <- policy_raw %>%
  mutate(
    site_id = str_trim(str_to_upper(site_id)),
    policy_strength = factor(str_trim(str_to_title(policy_strength)), levels = c("None", "Pilot", "Partial", "Full"), ordered = TRUE),
    policy_type = str_trim(str_to_title(policy_type)),
    policy_adopted = as.character(policy_adopted),
    grant_amount = as.numeric(grant_amount),
    compliance_score = as.numeric(compliance_score),
    estimated_reduction_pct = as.numeric(estimated_reduction_pct)
  )

policy_site <- policy %>%
  filter(!is.na(policy_strength), !is.na(policy_type)) %>%
  arrange(site_id, start_date) %>%
  group_by(site_id) %>%
  summarize(
    policy_strength = max(policy_strength),
    policy_type = first(policy_type),
    grant_amount = sum(grant_amount, na.rm = TRUE),
    compliance_score = mean(compliance_score, na.rm = TRUE),
    estimated_reduction_pct = mean(estimated_reduction_pct, na.rm = TRUE),
    policy_adopted = as.character(any(policy_adopted == "TRUE" | policy_adopted == "True")),
    .groups = "drop"
  )

analysis_df <- left_join(sites, policy_site, by = "site_id") %>%
  filter(
    !is.na(pm25),
    !is.na(policy_strength),
    !is.na(traffic_index),
    !is.na(compliance_score),
    !is.na(estimated_reduction_pct),
    !is.na(grant_amount)
  )

# Q1: Violin
p1 <- analysis_df %>%
  ggplot(aes(x = policy_strength, y = pm25, fill = policy_strength)) +
  geom_violin(alpha = 0.75, trim = FALSE, color = "gray35") +
  stat_summary(fun = median, geom = "point", color = "black", size = 2) +
  labs(title = "PM2.5 Distribution by Policy Strength", x = "Policy Strength", y = "PM2.5") +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none")

# Q2: Facet wrap
p2 <- analysis_df %>%
  ggplot(aes(x = traffic_index, y = pm25, color = policy_strength)) +
  geom_point(alpha = 0.45, size = 1.2) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 0.8) +
  facet_wrap(~policy_type) +
  labs(title = "Traffic vs PM2.5 by Policy Type", x = "Traffic Index", y = "PM2.5") +
  theme_minimal(base_size = 12)

# Q3: Bubble scatter
p3 <- analysis_df %>%
  ggplot(aes(x = compliance_score, y = estimated_reduction_pct, size = grant_amount, color = policy_adopted)) +
  geom_point(alpha = 0.65) +
  scale_size_continuous(range = c(1.5, 10)) +
  labs(
    title = "Policy Reduction Potential vs Compliance (Bubble Size = Grant Amount)",
    x = "Compliance Score",
    y = "Estimated Reduction (%)"
  ) +
  theme_minimal(base_size = 12)

# Optional bonus: interactive bubble
if (requireNamespace("plotly", quietly = TRUE)) {
  print(plotly::ggplotly(p3))
}

# Q4: Ridgeline (with fallback)
if (requireNamespace("ggridges", quietly = TRUE)) {
  p4 <- analysis_df %>%
    ggplot(aes(x = pm25, y = region, fill = region)) +
    ggridges::geom_density_ridges(alpha = 0.7, scale = 1.1, color = "gray20") +
    labs(title = "Ridgeline Density of PM2.5 by Region", x = "PM2.5", y = "Region") +
    theme_minimal(base_size = 12) +
    theme(legend.position = "none")
} else {
  p4 <- analysis_df %>%
    ggplot(aes(x = pm25, fill = region)) +
    geom_density(alpha = 0.35) +
    facet_wrap(~region, ncol = 1) +
    labs(
      title = "Fallback View (Install ggridges for Ridgeline): PM2.5 Density by Region",
      x = "PM2.5",
      y = "Density"
    ) +
    theme_minimal(base_size = 12)
}

print(p1)
print(p2)
print(p3)
print(p4)
