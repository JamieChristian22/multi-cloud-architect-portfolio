#############################################
# Data Tier: Azure SQL + Private Endpoint + Storage
#############################################

resource "azurerm_mssql_server" "sql" {
  name                         = "${var.prefix}-sqlsrv"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "ChangeMeNow!123" # <-- in real usage use Key Vault / TF vars
}

resource "azurerm_mssql_database" "sqldb" {
  name           = "${var.prefix}-sqldb"
  server_id      = azurerm_mssql_server.sql.id
  sku_name       = "BC_Gen5_2" # Business Critical, zone redundant
  zone_redundant = true
}

# Storage for audit / exports
resource "azurerm_storage_account" "logs" {
  name                     = "${var.prefix}logsstore"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = false
}

# Private Endpoint into the data subnet
resource "azurerm_private_endpoint" "sql_pe" {
  name                = "${var.prefix}-sql-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_data

  private_service_connection {
    name                           = "${var.prefix}-sql-pe-conn"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}

output "sql_fqdn" {
  value = azurerm_mssql_server.sql.fully_qualified_domain_name
}
