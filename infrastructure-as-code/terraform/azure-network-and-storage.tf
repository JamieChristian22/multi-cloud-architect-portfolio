resource "azurerm_resource_group" "analytics_rg" {
  name     = "rg-novaretail-analytics"
  location = var.azure_location
}

resource "azurerm_storage_account" "datalake" {
  name                     = "novaretaildatalake"
  resource_group_name      = azurerm_resource_group.analytics_rg.name
  location                 = azurerm_resource_group.analytics_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "raw" {
  name                  = "raw"
  storage_account_name  = azurerm_storage_account.datalake.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "curated" {
  name                  = "curated"
  storage_account_name  = azurerm_storage_account.datalake.name
  container_access_type = "private"
}
