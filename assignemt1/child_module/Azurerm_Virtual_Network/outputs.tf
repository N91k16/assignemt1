output "vnet_ids" {
  description = "Map of virtual network ids keyed by input key"
  value = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}

output "vnet_names" {
  description = "Map of virtual network names keyed by input key"
  value = { for k, v in azurerm_virtual_network.vnet : k => v.name }
}
