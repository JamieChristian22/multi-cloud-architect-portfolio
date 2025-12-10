resource "azurerm_synapse_workspace" "analytics_ws" {
  name                                 = "syn-novaretail-analytics"
  resource_group_name                  = azurerm_resource_group.analytics_rg.name
  location                             = azurerm_resource_group.analytics_rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_container.curated.resource_manager_id
  sql_administrator_login              = "synadmin"
  sql_administrator_login_password     = "StrongPassword123!"
}
