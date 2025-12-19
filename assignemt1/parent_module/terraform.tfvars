rg_parent = {
  rg1 = {
    name     = "ultimate"
    location = "Australia East"
  }
}


# Internal Load Balancer configuration
ilb_parent = {
  ilb1 = {
    name = "internal-ilb"
    resource_group_name = "ultimate"
    location = "Australia East"
    subnet_key = "frontend"
    probe_port = 80
    backend_ports = [80]
  }
}

#create storage account---------------------------------------------------------------------------
storage_account_parent = {
  stg1 = {
    name                   = "nagendrastorage"
    resource_group_name    = "ultimate"
    location               = "Australia East"
    account_tier           = "Standard"
    account_replication_type = "LRS"

    network_rules = {
      default_action             = "Deny"
      bypass                     = ["AzureServices"]
      
    }
  }
}

container_parent = {
  container1 = {
    key                   = "containerone"
    name                  = "containerone"
    storage_account_id    = "stg1"
    container_access_type = "blob"
  }

  }#end of storage account-----------------------------------------------------------------------------



vnet_parent = {
  vnet1 = {
    name                = "vnetwork1"
    address_space       = ["12.0.0.0/16"]
    location            = "Australia East"
    resource_group_name = "ultimate"

  }
}



subnet_parent = {
  frontend = {
    name                 = "frontend_subnet"
    resource_group_name  = "ultimate"
    virtual_network_name = "vnetwork1"
    address_prefixes     = ["12.0.1.0/24"]
  }
  backend = {
    name                 = "backend_subnet"
    resource_group_name  = "ultimate"
    virtual_network_name = "vnetwork1"
    address_prefixes     = ["12.0.2.0/24"]

  }
}


nsg_parent = {
  nsg1 = {
    name                       = "nsg1"
    location                   = "Australia East"
    resource_group_name        = "ultimate"

    security_rule = {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  }
  
}




nic_parent = {
  nic1 = {
    name                = "nic1"
    location            = "Australia East"
    resource_group_name = "ultimate"


     ip_configuration = [ {
              name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
                        
     ]

    tags = {
      environment = "dev"
    }
    
  }
  
}


public_ip_parent = {
  pip1 = {
    name                = "frontend_pip"
    location            = "Australia East"
    resource_group_name = "ultimate"
    allocation_method   = "Static"
  }
}






# Virtual Machine (FIXED SSH KEY)
myvmparent = {
  vm1 = {
    name                = "linuxvm"
    resource_group_name = "ultimate"
    location            = "Australia East"
    size                = "Standard_B1s"
    admin_username      = "azureuser"

    admin_ssh_key = {
      public_key = "C:/Users/Lenovo/.ssh/id_rsa.pub"
    }

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
  }
}