# 05 – Detailed Architecture – GCP

## 1. Role of GCP

GCP is the **machine learning and advanced analytics** platform:

- BigQuery stores ML‑ready, denormalized datasets.
- Vertex AI runs experiments, training, and deployment.
- Pub/Sub handles streaming data from AWS and Azure.

## 2. Key Components

### 2.1 Networking and Identity

- Dedicated VPC with subnets for:
  - Private access to BigQuery and Cloud Storage.
  - Vertex AI training and serving resources.
- Cloud VPN connected to:
  - AWS VPC.
  - Azure VNet.
- IAM roles are tightly scoped to:
  - One service account for Data Factory integration.
  - One service account per ML pipeline.

### 2.2 Storage – Cloud Storage and BigQuery

- Cloud Storage buckets:
  - `novaretail-ml-landing`
  - `novaretail-ml-features`
- BigQuery datasets:
  - `raw_events`
  - `customers_360`
  - `transactions`
  - `fraud_features`
  - `recommendation_features`

### 2.3 Ingestion

Two main paths:

1. **Batch from Azure Data Factory**
   - Data Factory writes partitioned files into Cloud Storage.
   - A scheduled Cloud Function or Dataflow job loads them into BigQuery.

2. **Streaming from AWS**
   - Events from Kafka/Kinesis are forwarded to **Pub/Sub** via a secure bridge.
   - Dataflow streaming jobs parse, validate, and enrich events, then write to BigQuery.

### 2.4 Vertex AI – ML Lifecycle

ML use cases:

1. **Fraud Detection**
   - Features:
     - Transaction amount, velocity, country, device fingerprint, IP reputation.
   - Labels:
     - `is_fraud` based on chargeback outcomes.

2. **Product Recommendation**
   - Features:
     - User purchase history, browsing behavior, product similarity metrics.
   - Model:
     - Embedding‑based retrieval, ranking model, or matrix factorization.

Vertex AI pipelines:

- Pull feature tables from BigQuery.
- Split into training/validation/test sets.
- Train models with hyperparameter tuning.
- Deploy to online prediction endpoints or schedule batch predictions.

### 2.5 Output and Feedback Loop

- Batch predictions written back to:
  - BigQuery tables (e.g., `fraud_scores`, `recommendation_scores`).
  - Exported to S3 / ADLS for integration with applications and BI.
- Online predictions:
  - Exposed via endpoints fronted by API Gateway / Cloud Load Balancing.
  - Consumed by e‑commerce applications (hosted in AWS).

## 3. Security on GCP

- Cloud KMS for key management; CMEK used for BigQuery and Storage.
- VPC Service Controls for sensitive datasets.
- Cloud Logging and Cloud Audit Logs capture access and config changes.

GCP gives NovaRetail a powerful platform to **rapidly build, evaluate, and deploy ML models** while integrating tightly with the multi‑cloud data platform.
