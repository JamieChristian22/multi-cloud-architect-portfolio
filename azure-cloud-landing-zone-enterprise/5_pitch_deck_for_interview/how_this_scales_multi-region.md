## How This Scales Multi-Region

- Terraform modules are parameterized by region and CIDR
- SQL Database supports active geo-replication
- Storage uses RA-GRS
- App Service / Container Apps can be pre-provisioned warm in secondary region
- Front Door or Traffic Manager can route traffic to whichever region is healthy
