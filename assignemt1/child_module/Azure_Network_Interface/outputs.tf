output "nic_ids" {
  description = "Map of network interface ids keyed by input key"
  value = { for k, v in azurerm_network_interface.nic : k => v.id }
}

output "nic_names" {
  description = "Map of network interface names keyed by input key"
  value = { for k, v in azurerm_network_interface.nic : k => v.name }
}
