provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# VNet + Subnet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_group_name}-vnet"
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource_group_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

# VMSS
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = var.vmss_sku
  instances           = var.vmss_instances
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "internal"
      subnet_id = azurerm_subnet.subnet.id
      primary   = true
    }
  }
}

# Budget Alert
resource "azurerm_consumption_budget_resource_group" "budget" {
  name                = var.budget_name
  resource_group_name = azurerm_resource_group.rg.name
  amount              = var.budget_amount
  time_grain          = "Monthly"

  time_period {
    start_date = var.budget_start_date
    end_date   = var.budget_end_date
  }

  notification {
    enabled   = true
    threshold = var.budget_threshold
    operator  = "GreaterThan"
    contact_emails = var.budget_emails
  }
}
