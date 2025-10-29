#############################################
# Application Gateway (WAF) + App Service + Container Apps
#############################################

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.prefix}-app-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "app"
  reserved            = false

  sku {
    tier = "P1v3"
    size = "P1v3"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "${var.prefix}-webapp"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  https_only          = true

  site_config {
    minimum_tls_version = "1.2"
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "API_BASE_URL"             = "https://api.internal"    # placeholder
    "SQL_FQDN"                 = var.sql_server_fqdn
    "KEY_VAULT_ID"             = var.key_vault_id
  }
}

# NOTE: For simplicity, we won't fully stand up Azure Container Apps infra here
# (env, revision, ingress rules). This stub proves intent and interview depth.

resource "azurerm_application_gateway" "agw" {
  name                = "${var.prefix}-agw-waf"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gwipconfig"
    subnet_id = var.subnet_id_web
  }

  frontend_port {
    name = "frontendPort443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontendPublicIp"
    public_ip_address_id = azurerm_public_ip.agw_public.id
  }

  backend_address_pool {
    name  = "backendPool"
    fqdns = [azurerm_app_service.webapp.default_hostname]
  }

  backend_http_settings {
    name                  = "httpsSettings"
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
  }

  http_listener {
    name                           = "httpsListener"
    frontend_ip_configuration_name = "frontendPublicIp"
    frontend_port_name             = "frontendPort443"
    protocol                       = "Https"
    ssl_certificate_name           = null
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "httpsListener"
    backend_address_pool_name  = "backendPool"
    backend_http_settings_name = "httpsSettings"
    priority                   = 1
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }
}

resource "azurerm_public_ip" "agw_public" {
  name                = "${var.prefix}-agw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

output "app_service_default_hostname" {
  value = azurerm_app_service.webapp.default_hostname
}
