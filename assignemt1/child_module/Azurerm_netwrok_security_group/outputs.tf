output "nsg_ids" {
  description = "Map of network security group ids keyed by input key"
  value = { for k, v in azurerm_network_security_group.nsg1 : k => v.id }
}

output "nsg_names" {
  description = "Map of network security group names keyed by input key"
  value = { for k, v in azurerm_network_security_group.nsg1 : k => v.name }
}
