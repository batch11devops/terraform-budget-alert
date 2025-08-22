# Resource Group
resource_group_name = "rg-vmss-budget"
location            = "Japan West"

# Networking
vnet_cidr   = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

# VMSS
vmss_name       = "vmss-budget-raksha"
vmss_instances  = 1
vmss_sku        = "Standard_DS1_v2"
admin_username  = "azureuser"

# Budget
budget_name       = "vmss-budget-alert"
budget_amount     = 50
budget_threshold  = 80.0
budget_emails     = ["rakshashetty@example.com"]
budget_start_date = "2025-08-01T00:00:00Z"
budget_end_date   = "2026-08-01T00:00:00Z"
