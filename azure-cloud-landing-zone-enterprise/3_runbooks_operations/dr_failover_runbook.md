# DR / Failover Runbook

Primary Region: eastus  
Secondary Region: eastus2  

1. Confirm Terraform vars for secondary region (CIDRs, names).  
2. Deploy networking + monitoring modules in secondary.  
3. Enable active geo-replication for Azure SQL Database.  
4. Sync Key Vault secrets to secondary region Key Vault.  
5. Pre-provision App Service Plan + Container Apps in secondary.  
6. In an outage:
   - Update DNS / Front Door to point to secondary App Gateway.
   - Scale up secondary App Service and Container Apps replicas.
   - Confirm app can reach secondary SQL replica.
