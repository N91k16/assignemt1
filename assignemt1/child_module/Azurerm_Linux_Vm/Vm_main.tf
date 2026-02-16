resource "azurerm_linux_virtual_machine" "vm1" {
  for_each             = var.linux_vm_child
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  network_interface_ids = each.value.network_interface_ids

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(each.value.admin_ssh_key.public_key)
  }

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }
  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
  tags = {
    environment = "Production"
  }
}