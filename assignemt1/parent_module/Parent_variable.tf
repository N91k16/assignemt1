variable "rg_parent" {
  description = "A map of resource groups to create"
  type = map(object({
    name     = string
    location = string
  }))
}


variable "vnet_parent" {
  description = "A map of virtual network configurations"
  type = map(object({
    name                = string
    address_space       = list(string)
    location            = string
    resource_group_name = string
  }))
}


variable "subnet_parent" {
  description = "A map of subnet configurations"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "nsg_parent" {
  description = "A map of network security group configurations"
  type = map(object({
   name                       = string
       location                   = string
    resource_group_name        = string
    security_rule = object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
    })
  }))
}




variable "nic_parent" {
#   description = "A map of NIC configurations"
#   type = map(object({
#     name                = string
#     location            = string
#     resource_group_name = string
#     ip_configuration = object({
#       name                          = string
#       # subnet_id                     = string
#       private_ip_address_allocation = string
#       public_ip_address_id          = optional(string)
#     })
#     tags = optional(map(string), {})
#   }))
}




variable "public_ip_parent" {
  description = "A map of Public IP configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
  }))
}


variable "storage_account_parent" {
  description = "A map of storage account configurations"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    virtual_network_subnet_ids = optional(list(string), []) 
  }))
}


variable "myvmparent" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string
    admin_ssh_key       = object({
      public_key = string
    })
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
  default = {}
}


variable "ilb_parent" {
  description = "A map of internal load balancer configurations. Use `subnet_key` to reference a subnet from `subnet_parent`."
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    subnet_key          = optional(string)
    frontend_private_ip_address = optional(string)
    frontend_private_ip_allocation = optional(string, "Dynamic")
    probe_port = optional(number, 80)
    backend_ports = optional(list(number), [80])
  }))
  default = {}
}



variable "container_parent" {
  description = "A map of storage container names to be created in the storage accounts."
  type        = map(object({
    key = string
    name = string
    storage_account_id = string
    container_access_type = string

  }))
}