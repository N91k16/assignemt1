variable "ilb_child" {
  description = "Map of internal load balancer configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    subnet_key          = optional(string)
    # optional: parent can provide `frontend_subnet_id` directly; when present it will be used
    frontend_subnet_id  = optional(string)
    frontend_private_ip_address = optional(string)
    frontend_private_ip_allocation = optional(string, "Dynamic")
    probe_port = optional(number, 80)
    backend_ports = optional(list(number), [80])
  }))
}

variable "nic_id_map" {
  description = "Map of NIC ids to associate into the ILB backend pool"
  type = map(string)
}

variable "ip_configuration_name" {
  description = "Name of the NIC ip configuration to associate with the backend pool"
  type = string
  default = "ipconfig1"
}
