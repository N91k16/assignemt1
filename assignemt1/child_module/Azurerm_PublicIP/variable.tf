variable "public_ip_child" {
	description = "A map of Public IP configurations"
	type = map(object({
		name                = string
		resource_group_name = string
		location            = string
		allocation_method   = string
	}))
}