output "subnet_ids" {
  description = "Map of subnet ids keyed by input key"
  value = { for k, v in azurerm_subnet.backend_subnet : k => v.id }
}

output "subnet_names" {
  description = "Map of subnet names keyed by input key"
  value = { for k, v in azurerm_subnet.backend_subnet : k => v.name }
}
