# HIPAA Alignment Summary

- PHI never exposed on public endpoints.
- App Gateway WAF blocks common OWASP threats pre-app.
- Azure SQL behind Private Endpoint only; public network access disabled.
- Key Vault stores credentials; no secrets in code or Terraform output.
- Defender for Cloud + SQL Auditing -> centralized Log Analytics (immutable trail).
- RBAC separation of duties: least privilege for AppTeam, CloudOps, SecurityTeam.
