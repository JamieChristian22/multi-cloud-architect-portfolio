output "hub_vnet_id" {
  value = module.networking.hub_vnet_id
}

output "spoke_prod_vnet_id" {
  value = module.networking.spoke_vnet_id
}

output "app_service_url" {
  value = module.compute_app.app_service_default_hostname
}

output "sql_fqdn" {
  value = module.data.sql_fqdn
}
