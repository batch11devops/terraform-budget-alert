# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a VM Scale Set (just sample infra)
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss-budget-raksha"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_DS1_v2"
  instances           = 1
  admin_username      = "azureuser"

  admin_password = "Rks@3007"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

# Create a Budget for the Resource Group
resource "azurerm_consumption_budget_resource_group" "budget" {
  name              = "vmss-budget-alert"
  resource_group_id = azurerm_resource_group.rg.id
  amount            = 50
  time_grain        = "Monthly"

  time_period {
    start_date = "2025-08-01T00:00:00Z"
    end_date   = "2026-08-01T00:00:00Z"
  }

  notification {
    enabled   = true
    threshold = 80.0
    operator  = "GreaterThan"
    contact_emails = [
      "your-email@example.com"
    ]
  }
}
