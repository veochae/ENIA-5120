# policy_actions.csv

## Dataset purpose
This dataset catalogs environmental policy actions tied to monitoring sites. It includes policy
type, strength, funding, compliance outcomes, and timing. Merging with the site dataset enables
analysis of how policy investments relate to local air quality and community characteristics.

Primary key: policy_id (may contain duplicates intentionally).
Foreign key: site_id (links to air_quality_sites).

## Column definitions
- policy_id: unique policy record identifier (string).
- site_id: site identifier (string) used to join with air_quality_sites.
- policy_strength: ordinal policy intensity (None < Pilot < Partial < Full).
- policy_type: type of policy intervention (nominal; e.g., Emissions Cap, EV Incentive).
- grant_amount: policy grant amount in USD.
- inspection_count: number of compliance inspections conducted (discrete integer).
- compliance_score: compliance score from 0 to 100 (higher is better).
- estimated_reduction_pct: estimated emissions reduction percent (can be negative if estimated impact is adverse).
- policy_adopted: logical flag indicating whether the policy was adopted/implemented.
- start_date: policy start date in YYYY‑MM‑DD format.

## Known data quality issues (intentional)
Missing values, invalid categories, out‑of‑range compliance scores, invalid dates, duplicate IDs,
and key mismatches for merges (case/whitespace and non‑matching site IDs).
