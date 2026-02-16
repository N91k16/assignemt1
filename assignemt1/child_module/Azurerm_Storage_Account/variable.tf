variable "storage_account_child" {
  description = "A map of storage account configurations"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    virtual_network_subnet_ids = optional(list(string), []) 
    # customer managed key removed; CMK is not required
  }))
}