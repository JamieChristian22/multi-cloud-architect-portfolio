# 04 – Detailed Architecture – Azure

## 1. Role of Azure

Azure is the **analytics and reporting hub** for business stakeholders and finance teams:

- Orchestrates cross‑cloud data movement.
- Serves curated datasets to Power BI.
- Hosts some regional data stores for regulatory reasons.

## 2. Key Components

### 2.1 Networking and Identity

- Dedicated analytics VNet with:
  - Subnets for Data Factory integration runtime, Synapse, and private endpoints.
- Site‑to‑site VPN to AWS and GCP.
- **Azure Active Directory** as:
  - Main identity provider for internal users.
  - Federation with AWS IAM and GCP IAM for cross‑cloud roles.

### 2.2 Ingestion with Azure Data Factory (ADF)

ADF pipelines perform:

1. **Batch Copy from S3 to ADLS Gen2**
   - Uses the S3 connector with:
     - Encrypted credentials stored in **Key Vault**.
   - Incremental loads based on partition filters (`year`, `month`, `day`).

2. **Copy from AWS Redshift to Synapse**
   - For curated datasets that are easier to pull from Redshift.

3. **Copy from ADLS to GCP Cloud Storage**
   - Uses the HTTP or custom connector with secure endpoints.

ADF includes:

- Pipelines for orders, customers, products, and events.
- Data flows for light transformations needed for BI models.

### 2.3 Storage – ADLS Gen2

- Container structure:
  - `raw` – Landing data from S3 with minimal transformations.
  - `curated` – Cleaned, conformed data modeled for reporting.
  - `sandbox` – For exploratory work and POCs.

### 2.4 Analytics – Azure Synapse

- **Serverless SQL pools** for:
  - Ad‑hoc exploration of ADLS data.
- **Dedicated SQL pools** for:
  - Highly optimized reporting tables.

Typical use:

- Dimensional modeling (star schemas) for:
  - `dim_customer`
  - `dim_product`
  - `dim_date`
  - `fact_orders`
  - `fact_payments`
- These models feed Power BI datasets.

### 2.5 Visualization – Power BI

- Executive dashboards:
  - Revenue by region / day / channel.
  - Customer acquisition and retention.
  - Product performance and inventory KPIs.
- Operational dashboards:
  - Order processing SLAs.
  - Cart abandonment.
  - Support tickets.

Power BI connects either:

- Directly to Synapse, or
- To curated data in ADLS via Power BI Dataflows.

## 3. Security and Governance on Azure

- **Azure RBAC** and AAD groups control access to:
  - Data Factory, Synapse, and storage accounts.
- **Key Vault** holds:
  - Secrets for S3, GCP service accounts, connection strings.
- **Customer‑Managed Keys** for ADLS encryption.
- **Azure Policy** ensures:
  - Storage accounts must have encryption and logging enabled.
  - Public exposure is blocked.

## 4. Cross‑Cloud Role

Azure’s most important role is to:

- **Unify the reporting experience** for business stakeholders.
- Provide a **central orchestration engine** (ADF) that coordinates data transfer across clouds.
