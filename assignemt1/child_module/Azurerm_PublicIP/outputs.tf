output "public_ip_ids" {
  description = "Map of public IP ids keyed by input key"
  value = { for k, v in azurerm_public_ip.pip1 : k => v.id }
}

output "public_ip_addresses" {
  description = "Map of public IP addresses"
  value = { for k, v in azurerm_public_ip.pip1 : k => v.ip_address }
}
