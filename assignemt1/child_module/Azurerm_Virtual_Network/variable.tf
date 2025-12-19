variable vnet_child {
    description = "A map of virtual network configurations"
    type = map(object({
        name                = string
        address_space       = list(string)
        location            = string
        resource_group_name = string
    }))
    }