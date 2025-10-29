# Azure Cloud Landing Zone (Enterprise) – Healthcare Analytics Platform

## 1. Business Problem
Contoso Health needs to migrate a patient analytics workload to Azure. They handle PHI, so they need security, auditability, cost control, and repeatability for future apps.  
Goal: build a compliant landing zone + deploy a production 3‑tier analytics app in that landing zone.

## 2. High-Level Architecture
- Hub VNet (shared services: Azure Firewall, Bastion, Private DNS, Log Analytics)
- Spoke VNet (per-app): Web/App/Data subnets, zero-trust east/west rules
- App Gateway (WAF) → App Service (frontend) → Container Apps (API) → Azure SQL (Private Endpoint)
- Azure Policy + RBAC guardrails
- Log Analytics + Monitor alerts
- Budgets + tagging enforcement

See `1_architecture_diagrams/` for visuals.

## 3. What This Repo Includes
- `/2_terraform` – Terraform IaC modules for:
  - networking (hub/spoke vnets, subnets, peering, NSGs)
  - security / governance (RBAC, Policy, Key Vault)
  - compute_app (App Service, App Gateway WAF, Container Apps env)
  - data (Azure SQL DB + Private Endpoints + Storage Account)
  - monitoring (Log Analytics, diagnostics, alerts)
- `/3_runbooks_operations` – ops procedures (DR, onboarding, key rotation, cost review)
- `/4_security_compliance` – PHI/least privilege notes, RBAC matrix
- `/5_pitch_deck_for_interview` – how to talk about this project in an interview / on resume

## 4. Deploy (example flow)
```bash
cd 2_terraform
terraform init
terraform plan -var-file="env.prod.tfvars"
terraform apply -var-file="env.prod.tfvars"
```

You would supply values like:
- location (`eastus` / `eastus2`)
- address spaces for hub/spoke
- SKU sizes (App Service plan tier, SQL tier, etc.)
- budget thresholds

## 5. HA / DR / Cost / Security (Talking Points)
- HA: zone-redundant App Service, App Gateway, SQL Business Critical
- DR: same Terraform can be applied in secondary region; SQL geo-replication + RA-GRS storage
- Cost: budgets + required costcenter tags + storage lifecycle rules
- Security: no public DB, WAF front door, Key Vault for secrets, Defender for Cloud enabled, Azure Policy blocks insecure configs

This is production pattern you present in interviews to prove you think beyond “I launched a VM.”
