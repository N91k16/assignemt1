variable "nic_child" {
	description = "A map of NIC configurations"
	type = map(object({
		name                = string
		location            = string
		resource_group_name = string
		ip_configuration = list(object({
			name                          = string
			# Either provide `subnet_id` directly or provide `subnet_name` and `virtual_network_name` to lookup
			subnet_id                     = optional(string)
			subnet_name                   = optional(string)
			virtual_network_name          = optional(string)
			private_ip_address_allocation = string
			public_ip_address_id          = optional(string)
		}))
		tags = optional(map(string), {})
	}))
}