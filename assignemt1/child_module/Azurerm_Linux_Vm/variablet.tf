variable "linux_vm_child" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string

    admin_ssh_key = object({
      public_key = string
    })

    os_disk = object({
      caching             = string
      storage_account_type = string
    })

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    network_interface_ids = optional(list(string), [])
  }))
  # optional list of NIC ids to attach to the VM
  # parent should provide `network_interface_ids` inside each VM object as list(string)
  # example: network_interface_ids = [module.nicmodule.nic_ids["nic1"]]
  # keep default empty
  
}
