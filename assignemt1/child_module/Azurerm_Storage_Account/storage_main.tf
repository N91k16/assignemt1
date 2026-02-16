resource "azurerm_storage_account" "storage1" {
    for_each             = var.storage_account_child
  name                = each.value.name
    resource_group_name = each.value.resource_group_name
    location            = each.value.location
    account_tier        = each.value.account_tier
    
    account_replication_type = each.value.account_replication_type
    tags = {
      environment = "Production"
    }

    

    identity {
      type = "SystemAssigned"
    }

    network_rules {
      default_action             = "Deny"
      bypass                     = ["AzureServices"]
      virtual_network_subnet_ids = each.value.virtual_network_subnet_ids
    }
}

/* Log Analytics workspace and diagnostic settings removed per user request (not required). */
