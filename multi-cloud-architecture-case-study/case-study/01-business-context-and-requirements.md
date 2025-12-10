# 01 – Business Context and Requirements

## 1. Company Background

**Company Name:** NovaRetail  
**Industry:** E‑commerce / Retail  
**Regions:** North America and Europe  
**Cloud Footprint:** Historical multi‑cloud

- **AWS** hosts the main transactional e‑commerce platform and customer accounts.
- **Azure** hosts several legacy BI solutions and finance workloads.
- **GCP** is used by a newer data science team for experimentation and ML.

## 2. Current State

NovaRetail’s systems evolved organically:

- Separate engineering teams adopted different clouds.
- Data pipelines are point‑to‑point and fragile.
- Reporting is mainly batch and delayed by 24–48 hours.
- Each cloud has its own identity, monitoring, and backup approach.

### Problems

1. **Fragmented data**
   - Customer, order, and product data are duplicated and inconsistent.
   - No single source of truth for business KPIs.

2. **Slow decision‑making**
   - Analysts manually combine CSV exports from different tools.
   - Leadership dashboards lag behind reality.

3. **Inconsistent governance**
   - Different encryption and key management policies per cloud.
   - No centralized data classification and retention strategy.

4. **Limited ML operationalization**
   - Data science work in GCP is ad‑hoc.
   - No standard path from experiment to production deployment.

## 3. Target Outcomes

NovaRetail wants to achieve:

1. **Unified Customer 360 View**
   - Clean, conformed customer profiles across all channels and regions.

2. **Near Real‑Time Analytics**
   - Key metrics (orders, revenue, sign‑ups, cart abandonment) available in under 5 minutes.

3. **Multi‑Cloud Leverage**
   - Use the **best‑fit services** from AWS, Azure, and GCP without locking into just one.

4. **Enterprise‑Grade Security & Compliance**
   - Centralized policies for data classification, encryption, key rotation, and access.

5. **Production‑Ready ML**
   - Fraud detection models and personalized recommendation models running in production.

## 4. Non‑Functional Requirements

- **Availability:** 99.9% for analytics services; 99.99% for ingestion pathways.
- **Scalability:** Must handle seasonal peaks (Black Friday, holiday spikes).
- **Latency:** Business metrics updated within 1–5 minutes of events.
- **Durability:** No data loss for committed transactions; immutable raw data retention.
- **Portability:** Ability to move specific analytical capabilities between clouds over time.
- **Auditability:** Complete traceability of who accessed which data and when.

## 5. Constraints and Assumptions

- Existing operational apps remain in their current clouds.
- No “big bang” migration; we incrementally connect and centralize analytics.
- Compliance with GDPR for EU customers and relevant privacy regulations.
- Managed cloud services are preferred over self‑managed infrastructure.

These requirements drive the multi‑cloud architecture defined in the rest of this case study.
