variable "prefix" {
  description = "Naming prefix for all resources (e.g. contosohealth)"
  type        = string
}

variable "location" {
  description = "Azure region (e.g. eastus)"
  type        = string
  default     = "eastus"
}

variable "hub_address_space" {
  description = "CIDR for hub VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "spoke_prod_address_space" {
  description = "CIDR for prod spoke VNet"
  type        = string
  default     = "10.1.0.0/16"
}
