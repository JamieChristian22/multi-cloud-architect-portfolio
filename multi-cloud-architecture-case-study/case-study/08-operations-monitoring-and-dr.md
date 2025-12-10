# 08 – Operations, Monitoring, and Disaster Recovery

## 1. Observability Strategy

### 1.1 Logging

- AWS:
  - Application, Lambda, Glue, and MSK logs → CloudWatch Logs.
- Azure:
  - ADF, Synapse, and ADLS logs → Log Analytics.
- GCP:
  - Dataflow, BigQuery, Vertex AI logs → Cloud Logging.

Centralization:

- A log shipping mechanism (e.g., exporting logs to a SIEM) aggregates security‑relevant events from all three clouds.

### 1.2 Metrics

- KPIs monitored:
  - Pipeline latency.
  - Failed job counts.
  - Data volume per partition.
  - Model drift and prediction error metrics.

### 1.3 Alerts

Sample alerts:

- Glue job failure more than 2 times in a row.
- ADF pipeline duration exceeds baseline by 50%.
- BigQuery cost anomaly beyond daily budget.
- Vertex AI model accuracy drops below a threshold.

## 2. Runbooks and On‑Call

- Clear runbooks exist for:
  - Pipeline failures.
  - Data quality issues.
  - Security incidents.
- On‑call rotation for:
  - Data Platform team.
  - Security team.
  - ML/AI team.

## 3. Disaster Recovery (DR)

Goals:

- RPO (Recovery Point Objective): 15 minutes for critical streaming data; 4 hours for batch data.
- RTO (Recovery Time Objective): 4 hours for analytics workloads.

Tactics:

- Cross‑region replication in each cloud (e.g., S3 cross‑region, GRS for ADLS, multi‑region datasets in BigQuery).
- Backup and restore procedures tested quarterly.
- Ability to rehydrate analytics stores from S3 raw data if needed.

This operations and DR design ensures the platform is **reliable, observable, and recoverable**.
