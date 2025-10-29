#############################################
# Hub-Spoke Networking + Resource Groups
#############################################

resource "azurerm_resource_group" "hub" {
  name     = "${var.prefix}-rg-hub"
  location = var.location
}

resource "azurerm_resource_group" "workload" {
  name     = "${var.prefix}-rg-prod"
  location = var.location
}

# Hub VNet (Shared services: Firewall, Bastion, DNS, Log)
resource "azurerm_virtual_network" "hub" {
  name                = "${var.prefix}-vnet-hub"
  address_space       = [var.hub_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
}

# Spoke VNet (Prod Workload)
resource "azurerm_virtual_network" "spoke_prod" {
  name                = "${var.prefix}-vnet-prod"
  address_space       = [var.spoke_prod_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.workload.name
}

# Subnets for web / api / data tiers
resource "azurerm_subnet" "web" {
  name                 = "${var.prefix}-snet-web"
  resource_group_name  = azurerm_resource_group.workload.name
  virtual_network_name = azurerm_virtual_network.spoke_prod.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "api" {
  name                 = "${var.prefix}-snet-api"
  resource_group_name  = azurerm_resource_group.workload.name
  virtual_network_name = azurerm_virtual_network.spoke_prod.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "data" {
  name                 = "${var.prefix}-snet-data"
  resource_group_name  = azurerm_resource_group.workload.name
  virtual_network_name = azurerm_virtual_network.spoke_prod.name
  address_prefixes     = ["10.1.3.0/24"]
}

# VNet Peering Hub <-> Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "${var.prefix}-peer-hub-to-prod"
  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_prod.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "${var.prefix}-peer-prod-to-hub"
  resource_group_name       = azurerm_resource_group.workload.name
  virtual_network_name      = azurerm_virtual_network.spoke_prod.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
  allow_virtual_network_access = true
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "spoke_vnet_id" {
  value = azurerm_virtual_network.spoke_prod.id
}

output "workload_rg_name" {
  value = azurerm_resource_group.workload.name
}

output "shared_rg_name" {
  value = azurerm_resource_group.hub.name
}

output "subnet_ids" {
  value = {
    web  = azurerm_subnet.web.id
    api  = azurerm_subnet.api.id
    data = azurerm_subnet.data.id
  }
}
