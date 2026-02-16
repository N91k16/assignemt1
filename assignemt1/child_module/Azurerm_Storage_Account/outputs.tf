output "storage_account_ids" {
  description = "Map of storage account ids keyed by input key"
  value = { for k, v in azurerm_storage_account.storage1 : k => v.id }
}

output "storage_account_names" {
  description = "Map of storage account names keyed by input key"
  value = { for k, v in azurerm_storage_account.storage1 : k => v.name }
}
