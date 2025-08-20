# --------------------
# Resource Group
# --------------------
resource "azurerm_resource_group" "rg" {
  name     = "rg-vmss-raksha"
  location = "Canada Central"
}

# --------------------
# Virtual Network + Subnet
# --------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-demo"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# --------------------
# VM Scale Set
# --------------------
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "vmss-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_DS1_v2"
  instances           = 2
  admin_username      = "azureuser"
  admin_password      = "Rks@3007"   

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet.id
    }
  }
}

# --------------------
# Budget Alert
# --------------------
resource "azurerm_consumption_budget_subscription" "budget" {
  name            = "budget-vmss-demo"
  subscription_id = var.subscription_id
  amount          = 50
  time_grain      = "Monthly"

  time_period {
    start_date = "2025-08-01T00:00:00Z"
    end_date   = "2025-12-31T00:00:00Z"
  }

  notification {
    enabled        = true
    threshold      = 80.0
    operator       = "GreaterThan"
    contact_emails = ["rakshajshetty1999@example.com"]
  }
}
