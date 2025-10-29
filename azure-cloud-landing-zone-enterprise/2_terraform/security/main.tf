#############################################
# Key Vault + Example Policy / RBAC hooks
#############################################

resource "azurerm_key_vault" "main" {
  name                        = "${var.prefix}-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
}

data "azurerm_client_config" "current" {}

# Placeholder: this is where you'd enforce Azure Policy assignments,
# RBAC role assignments, Defender for Cloud, etc.
# For interview you can say: "we assign policy at the 'Prod' mgmt group
# to block public DBs and require tagging."

output "key_vault_id" {
  value = azurerm_key_vault.main.id
}
