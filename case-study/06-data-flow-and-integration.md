# 06 – Data Flow and Integration

This document walks through **how data moves** between systems and clouds.

## 1. Ingestion Stages

### Stage 1 – Capture Events and Transactions (AWS)

- Application services publish:
  - `OrderCreated`, `OrderShipped`, `CartUpdated`, `CustomerUpdated` events to MSK.
- RDS and DynamoDB:
  - Changes captured via DMS.
- All data lands in:
  - S3 raw zone with append‑only files.

### Stage 2 – Curate and Conform (AWS Glue)

- Glue jobs:
  - Standardize timestamps to UTC.
  - Normalize country and currency codes.
  - Create surrogate keys for dimensions.
- Outputs:
  - Curated Parquet tables partitioned by date and region.

### Stage 3 – Replicate to Azure

- Azure Data Factory pipelines:
  - Connect to S3 using encrypted credentials in Key Vault.
  - Copy curated Parquet files to ADLS Gen2.
  - Apply light transformations if needed for Synapse models.

### Stage 4 – Replicate to GCP

- From ADLS or S3 (depending on dataset), ADF:
  - Writes data into Cloud Storage landing buckets.
- GCP Dataflow jobs:
  - Load Cloud Storage files into BigQuery.
  - Enrich with additional reference data if required.

### Stage 5 – Analytics, BI, and ML

- AWS Redshift:
  - Used for engineering‑focused analytics and SQL back‑office workflows.
- Azure Synapse + Power BI:
  - Used for business reporting and executive dashboards.
- BigQuery + Vertex AI:
  - Used for feature engineering, model training, and predictions.

## 2. Integration Patterns

1. **Batch File Replication**
   - S3 → ADLS → Cloud Storage.

2. **Change Data Capture**
   - DMS from RDS → S3 → Glue → downstream.

3. **Streaming**
   - MSK / Kinesis → S3 / Pub/Sub → BigQuery.

4. **API‑Level Integration**
   - ML prediction endpoints are consumed from AWS/Azure applications over HTTPS using mTLS and IAM‑backed service accounts.

These patterns combine to create a **cohesive, resilient multi‑cloud data fabric**.
