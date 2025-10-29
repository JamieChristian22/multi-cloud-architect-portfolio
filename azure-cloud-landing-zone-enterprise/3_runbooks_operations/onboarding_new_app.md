# Onboarding a New Application Team Into the Landing Zone

1. Create a new spoke VNet for that app in NonProd, peered to Hub.
2. Create RGs: `<app>-rg-nonprod`, `<app>-rg-prod`.
3. Apply mandatory Policy assignment (tagging, deny-public-db, Defender enabled).
4. Assign RBAC:
   - AppTeam -> Contributor on their RGs ONLY
   - SecurityTeam -> Security Reader
   - CloudOps -> Network Contributor on Hub only
5. Deploy Terraform modules (network, compute_app, data, monitoring) into NonProd first.
6. Validate:
   - No public access to data tier
   - Logs flowing to Log Analytics
   - Budgets + cost tags present
