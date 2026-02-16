resource "azurerm_network_interface" "nic" {

  for_each            = var.nic_child
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = lookup(ip_configuration.value, "subnet_id", data.azurerm_subnet.subnetdata.id)
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    }
  
}


  tags = each.value.tags
}