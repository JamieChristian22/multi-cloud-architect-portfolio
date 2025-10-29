#############################################
# Log Analytics + basic alerts
#############################################

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.prefix}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Example budget alert / cost mgmt would normally be handled at Subscription scope.
# Here we'll just output workspace id and you can wire diagnostics_settings to it.

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.law.id
}
