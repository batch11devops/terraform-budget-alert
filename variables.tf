variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "resource_group_name" {
  default = "rg-vmss-budget"
}

variable "location" {
  default = "Japan East"
}

variable "vmss_name" {
  default = "vmss-budget-raksha"
}

variable "vmss_instances" {
  default = 1
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  description = "Admin password for VMSS"
  type        = string
  sensitive   = true
}

variable "budget_amount" {
  default = 50
}

variable "budget_emails" {
  type    = list(string)
  default = ["rakshajshetty1999@gmail.com"]
}

variable "budget_start_date" {
  default = "2025-08-01T00:00:00Z"
}

variable "budget_end_date" {
  default = "2026-08-01T00:00:00Z"
}

variable "budget_threshold" {
  default = 80.0
}
