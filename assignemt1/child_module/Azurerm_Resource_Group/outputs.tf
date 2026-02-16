output "rg_ids" {
  description = "Map of resource group ids keyed by input key"
  value = { for k, v in azurerm_resource_group.rg : k => v.id }
}

output "rg_names" {
  description = "Map of resource group names keyed by input key"
  value = { for k, v in azurerm_resource_group.rg : k => v.name }
}
