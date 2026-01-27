variable "aws_region" {
  type        = string
  description = "AWS region for core data lake."
  default     = "us-east-1"
}

variable "azure_location" {
  type        = string
  description = "Azure location for analytics workloads."
  default     = "eastus"
}

variable "gcp_region" {
  type        = string
  description = "GCP region for ML workloads."
  default     = "us-central1"
}
