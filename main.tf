resource "azurerm_resource_group" "rg" {
  name     = "budget-alert-raksha"
  location = "East US"
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "budget-vmss"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_DS1_v2"
  instances           = 1
  admin_username      = "azureuser"

  admin_password = "Rks@3007"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_consumption_budget_subscription" "budget" {
  name            = "vmss-budget"
  subscription_id = var.subscription_id
  amount          = 50
  time_grain      = "Monthly"

  time_period {
    start_date = "2025-08-01T00:00:00Z"
    end_date   = "2026-08-01T00:00:00Z"
  }

  notification {
    enabled   = true
    threshold = 80.0
    operator  = "GreaterThan"
    contact_emails = ["rakshashetty@example.com"]
  }
}
