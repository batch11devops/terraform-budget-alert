output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vmss_name" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.name
}

output "budget_name" {
  value = azurerm_consumption_budget_subscription.budget.name
}
