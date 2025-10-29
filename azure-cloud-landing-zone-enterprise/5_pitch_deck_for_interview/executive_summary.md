## Executive Summary

This project delivers an Azure landing zone + production analytics workload for a healthcare org that handles PHI.

Highlights:
- Hub-and-spoke network with central security services
- Zero-trust 3-tier app (WAF -> Web -> API -> SQL via private endpoint)
- Azure Policy + RBAC guardrails
- Full observability and cost governance
- HA (zone redundant) + DR (cross-region Terraform redeploy + SQL geo-replication)

This is how we standardize future app deployments safely and fast.
