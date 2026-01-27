# 09 – Cost and Scaling Considerations

## 1. Cost Drivers

- **AWS**
  - S3 storage and data transfer.
  - Glue ETL jobs.
  - Redshift compute.
- **Azure**
  - Data Factory activity runs and integration runtimes.
  - Synapse DWUs.
  - ADLS storage.
- **GCP**
  - BigQuery queries and storage.
  - Dataflow jobs.
  - Vertex AI training and predictions.

## 2. Optimization Strategies

- Use storage lifecycle policies:
  - Move older data to colder tiers (S3 Glacier, ADLS cool, GCS Nearline).
- Use partitioning and clustering:
  - For Redshift, Synapse, and BigQuery tables to reduce scanned data.
- Right‑size compute:
  - Auto‑pause Redshift and Synapse when idle.
  - Schedule ML training jobs during off‑peak hours.

## 3. Scaling

- Ingestion scales horizontally:
  - More Kinesis shards / Kafka partitions.
  - Scaled out Dataflow workers, Glue DPU allocation, and ADF concurrency.
- Analytics scales via:
  - Elastic pools and serverless options in Synapse and Redshift.
  - BigQuery’s separation of storage and compute.

The design balances **performance**, **cost control**, and **flexibility** across all three clouds.
