output "container_ids" {
  description = "Map of storage container ids keyed by input key"
  value = { for k, v in azurerm_storage_container.container1 : k => v.id }
}

output "container_names" {
  description = "Map of storage container names keyed by input key"
  value = { for k, v in azurerm_storage_container.container1 : k => v.name }
}
