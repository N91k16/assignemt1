resource "azurerm_subnet" "backend_subnet" {
  for_each = var.subnet_child
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

# Associate network security group to subnet when provided
resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = { for k, v in var.subnet_child : k => v if lookup(v, "network_security_group_id", "") != "" }

  subnet_id                 = azurerm_subnet.backend_subnet[each.key].id
  network_security_group_id = each.value.network_security_group_id
}