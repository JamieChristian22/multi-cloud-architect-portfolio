variable "prefix" { type = string }
variable "location" { type = string }
variable "log_analytics_id" { type = string }
variable "resource_group_name" {
  type        = string
  description = "We will pass the hub/shared RG or security RG; simplifying here."
  default     = "placeholder-security-rg"
}
