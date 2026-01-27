# 03 – Detailed Architecture – AWS

## 1. Role of AWS

AWS acts as:

- Primary **system of record** for core e‑commerce workloads.
- Home of the **enterprise data lake**.
- Main **streaming ingestion** and **batch ETL** platform.

## 2. Key Components

### 2.1 Networking

- Single AWS Organization with multiple accounts:
  - `prod-core`
  - `nonprod-core`
  - `shared-services`
- VPC in `prod-core` with:
  - Private subnets for application servers and databases.
  - Interface endpoints for S3, KMS, and Glue.
- Site‑to‑site VPN connections:
  - To Azure virtual network gateway.
  - To GCP Cloud VPN.

### 2.2 Data Lake on S3

Buckets (example names):

- `novaretail-prod-datalake-raw`
- `novaretail-prod-datalake-curated`
- `novaretail-prod-datalake-analytics`

Partitioning strategy:

- `s3://novaretail-prod-datalake-raw/orders/year=YYYY/month=MM/day=DD/`
- `s3://novaretail-prod-datalake-raw/customers/...`
- `s3://novaretail-prod-datalake-raw/events/...`

Data is stored in **Parquet** format where appropriate, with **Glue Data Catalog** tables for each dataset.

### 2.3 Streaming Ingestion

Two main patterns:

1. **Event Streaming**
   - Microservices publish events to **Amazon MSK** (Kafka) topics like:
     - `orders`
     - `cart_events`
     - `customer_updates`
   - Kafka Connect sinks write events to S3 in near real‑time.

2. **Change Data Capture (CDC)**
   - **AWS DMS** captures changes from transactional databases (e.g., Amazon RDS for PostgreSQL) and mirrors them into S3.

### 2.4 ETL and Data Processing

- **AWS Glue Jobs** perform:
  - Schema enforcement.
  - Data quality checks (null checks, range validation).
  - Conformance of IDs and reference data (e.g., country codes, currency).
- **AWS Lambda** functions handle lightweight transformations and event‑driven tasks.

Result:

- Clean, conformed, analytics‑ready tables in `curated` and `analytics` zones.

### 2.5 Analytics – Amazon Redshift Serverless

- Redshift Serverless is configured for:
  - BI exploration by the data team.
  - Heavy join workloads and report generation.
- External schemas reference S3 data via **Redshift Spectrum**, enabling a **lakehouse** style.

## 3. Security on AWS

- **AWS IAM** roles with least privilege:
  - Separate roles for Glue, Lambda, DMS, and analytics users.
- **KMS** for:
  - S3 SSE‑KMS encryption.
  - Redshift encryption.
- **CloudTrail** and **CloudWatch Logs**:
  - Track API calls.
  - Store job logs and metrics.

## 4. Cross‑Cloud Connectivity from AWS

- Private endpoints and VPNs connect to Azure and GCP networks.
- S3 data is exposed to Azure Data Factory using:
  - Private endpoints or VPC endpoints with whitelisted IP ranges.
- Event streaming bridge sends selected MSK topics into GCP Pub/Sub.

This AWS layer provides a **robust, secure, and scalable backbone** for the entire multi‑cloud analytics platform.
