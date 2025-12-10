# 07 – Security, Governance, and Compliance

## 1. Data Classification

Data classified into four levels:

1. **Public** – Marketing content, public product catalog.
2. **Internal** – Non‑sensitive operational metrics.
3. **Confidential** – Customer PII, order details, payment metadata.
4. **Restricted** – Security logs, keys, credentials, fraud investigation data.

Policies:

- Confidential and Restricted data:
  - Must be encrypted at rest and in transit.
  - Must have strict access control and auditing.

## 2. Identity and Access Management

- **Central IdP:** Azure AD acts as primary IdP.
- **AWS IAM** and **GCP IAM** federated with AAD to enable:
  - Role‑based access with least privilege.
  - Just‑In‑Time access for elevated roles.

Principles:

- No shared accounts.
- Separation of duties (data engineer, data scientist, security admin).
- Short‑lived credentials; heavy use of managed identities / service principals.

## 3. Encryption

- AWS: KMS‑backed SSE on S3, Redshift, and MSK.
- Azure: Customer‑managed keys for ADLS, Synapse; TLS enforced for all endpoints.
- GCP: CMEK for BigQuery and Cloud Storage; TLS enforced for APIs and endpoints.

## 4. Network Security

- Private subnets for data plane components.
- Site‑to‑site VPNs with BGP routing between clouds.
- Use of security groups / NSGs / firewall rules:
  - Allow only necessary ports.
  - Restrict traffic to known private IP ranges.

## 5. Compliance and Audit

- Logging and audit trails:
  - AWS CloudTrail, Azure Activity Log, GCP Audit Logs.
- Regular access reviews:
  - Quarterly IAM review for roles and privileges.
- Data retention:
  - Raw data kept for 7 years (for financial and legal needs).
  - Aggregated analytics kept as long as business requires.

## 6. Data Governance

- Data dictionaries and catalogs:
  - Glue Data Catalog, Purview, and Data Catalog (GCP) integrated where feasible.
- Ownership:
  - Each dataset has a **data owner**, **data steward**, and **technical owner**.
- Quality:
  - Data quality checks built into Glue, Data Factory, and Dataflow.
