#############################
# Root composition
#############################

module "networking" {
  source = "./networking"

  prefix                = var.prefix
  location              = var.location
  hub_address_space     = var.hub_address_space
  spoke_prod_address_space = var.spoke_prod_address_space
}

module "security" {
  source = "./security"

  prefix          = var.prefix
  location        = var.location
  log_analytics_id = module.monitoring.log_analytics_id
}

module "data" {
  source                 = "./data"
  prefix                 = var.prefix
  location               = var.location
  resource_group_name    = module.networking.workload_rg_name
  subnet_id_data         = module.networking.subnet_ids["data"]
}

module "compute_app" {
  source                      = "./compute_app"
  prefix                      = var.prefix
  location                    = var.location
  resource_group_name         = module.networking.workload_rg_name
  subnet_id_web               = module.networking.subnet_ids["web"]
  subnet_id_api               = module.networking.subnet_ids["api"]
  sql_server_fqdn             = module.data.sql_fqdn
  key_vault_id                = module.security.key_vault_id
}

module "monitoring" {
  source               = "./monitoring"
  prefix               = var.prefix
  location             = var.location
  resource_group_name  = module.networking.shared_rg_name
}
