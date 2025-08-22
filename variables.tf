# Azure Authentication (provided via Jenkins env)
variable "subscription_id" {
  type      = string
  sensitive = true
}
variable "client_id" {
  type      = string
  sensitive = true
}
variable "client_secret" {
  type      = string
  sensitive = true
}
variable "tenant_id" {
  type      = string
  sensitive = true
}

# Resource Group
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}

# Networking
variable "vnet_cidr" {
  type = string
}
variable "subnet_cidr" {
  type = string
}

# VMSS
variable "vmss_name" {
  type = string
}
variable "vmss_instances" {
  type = number
}
variable "vmss_sku" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type      = string
  sensitive = true
}

# Budget
variable "budget_name" {
  type = string
}
variable "budget_amount" {
  type = number
}
variable "budget_threshold" {
  type = number
}
variable "budget_emails" {
  type = list(string)
}
variable "budget_start_date" {
  type = string
}
variable "budget_end_date" {
  type = string
}

