variable "subnet_child" {   
    description = "A map of subnet configurations"
    type = map(object({
        name                 = string
        resource_group_name  = string
        virtual_network_name = string
        address_prefixes     = list(string)
        # optional: associate this subnet with an NSG id
        network_security_group_id = optional(string, "")
    }))
}