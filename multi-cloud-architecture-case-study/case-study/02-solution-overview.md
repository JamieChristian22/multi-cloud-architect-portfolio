# 02 – Solution Overview

This document summarizes the **target multi‑cloud architecture** before diving into each cloud in detail.

## 1. Architecture Principles

1. **Cloud‑Native First**
   - Use managed services in each cloud for storage, compute, and analytics.

2. **Separation of Concerns**
   - Clear layers for ingestion, storage, processing, serving, and consumption.

3. **Data‑Centric**
   - Treat data as a shared product; define strong contracts and schemas.

4. **Secure by Design**
   - Encryption in transit and at rest, least‑privilege IAM, strong network boundaries.

5. **Observability Everywhere**
   - Logs, metrics, and traces for ingestion, processing, and serving pipelines.

## 2. Cloud Roles

### AWS – System of Record & Core Data Lake

- Hosts the transactional e‑commerce backend.
- Acts as the **primary raw data landing zone**.
- Provides scalable batch and streaming processing.

Key Services:
- Amazon S3 (data lake: raw → curated → analytics zones)
- AWS Glue & AWS Lambda (ETL/ELT)
- Amazon Redshift Serverless (warehouse)
- Amazon MSK / Kinesis Data Streams (events)
- AWS IAM, KMS, CloudWatch, CloudTrail

### Azure – BI, Reporting & Finance Analytics

- Hosts regional reporting and finance systems.
- Serves interactive dashboards for business stakeholders.
- Orchestrates cross‑cloud data movement.

Key Services:
- Azure Data Factory (orchestration, cross‑cloud copy)
- ADLS Gen2 (landing and curated layer for Azure workloads)
- Azure Synapse Analytics (SQL pools, serverless SQL)
- Power BI (dashboards & self‑service reporting)
- Azure Active Directory, Key Vault, Monitor, Log Analytics

### GCP – ML & Advanced Analytics

- Home for the data science and ML team.
- Stores ML‑ready datasets and features.
- Trains and deploys fraud and recommendation models.

Key Services:
- Google Cloud Storage (feature and training data)
- BigQuery (analytical store)
- Vertex AI (training, hyperparameter tuning, deployment)
- Pub/Sub (stream ingestion from AWS/Azure)
- Cloud IAM, Cloud KMS, Cloud Logging

## 3. End‑to‑End Data Flow (Summary)

1. **Transactional Data Capture**
   - Orders, clicks, cart events, and customer profile changes emit events to **MSK/Kinesis** on AWS.
   - Operational databases (RDS/DynamoDB) are replicated to S3 using **DMS**.

2. **Raw Data Lake on AWS**
   - All event streams and DB snapshots land in **S3 raw zone** with immutable, partitioned storage.
   - Glue crawlers infer schema; Glue jobs clean and standardize data into **curated zone**.

3. **Cross‑Cloud Replication**
   - Azure Data Factory reads curated S3 data via secure endpoints and copies selected datasets into **ADLS Gen2**.
   - Data Factory also pushes curated datasets into **GCP Cloud Storage** for ML workloads.
   - Streaming events are mirrored using **Kafka Connect**, **Kinesis Data Firehose → HTTP**, or **custom bridge** into GCP Pub/Sub.

4. **Analytics Serving Layers**
   - AWS: Redshift Serverless for data engineers and some BI workloads.
   - Azure: Synapse (and Power BI) for business reporting and financial analysis.
   - GCP: BigQuery as the analytical source for ML feature tables and offline scoring.

5. **ML and Real‑Time Use Cases**
   - Models built on Vertex AI read training data from BigQuery.
   - Batch predictions are written back to S3 and ADLS for consumption by other systems.
   - Optional real‑time scoring: APIs exposed via GCP API Gateway / Cloud Run, callable from applications running in AWS or Azure.

## 4. Benefits

- **Unified Customer 360** across clouds
- **Low‑latency metrics** for executives and operations
- **Specialized use of each cloud**:
  - AWS for robust data lake and ingestion
  - Azure for top‑tier BI tooling
  - GCP for ML and experimentation
- **Reduced vendor lock‑in** and flexibility to shift components over time
