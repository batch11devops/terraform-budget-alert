# ---- Auth (optional if Jenkins provides ARM_* env) ----
variable "subscription_id" { type = string, default = null }
variable "client_id"       { type = string, default = null }
variable "client_secret"   { type = string, default = null }
variable "tenant_id"       { type = string, default = null }

# ---- Core ----
variable "resource_group_name" {
  description = "RG where VMSS + Budget are created"
  type        = string
  default     = "rg-vmss-budget"
}
variable "location" {
  type    = string
  default = "Japan East"
}

# ---- Networking ----
variable "vnet_cidr"   { type = string, default = "10.0.0.0/16" }
variable "subnet_cidr" { type = string, default = "10.0.1.0/24" }

# ---- VMSS ----
variable "vmss_name"         { type = string, default = "vmss-budget-raksha" }
variable "vmss_instances"    { type = number, default = 1 }
variable "vmss_sku"          { type = string, default = "Standard_DS1_v2" }
variable "admin_username"    { type = string, default = "azureuser" }
variable "admin_password" {
  description = "Admin password for VMSS local user"
  type        = string
  sensitive   = true
}

# ---- Budget (RG-scoped) ----
variable "budget_name"       { type = string, default = "vmss-budget-alert" }
variable "budget_amount"     { type = number, default = 50 }     # USD
variable "budget_threshold"  { type = number, default = 80.0 }   # percent
variable "budget_emails" {
  description = "Recipients for budget notifications"
  type        = list(string)
  default     = ["rakshashetty@example.com"]
}
# RFC3339 timestamps (UTC)
variable "budget_start_date" { type = string, default = "2025-08-01T00:00:00Z" }
variable "budget_end_date"   { type = string, default = "2026-08-01T00:00:00Z" }
