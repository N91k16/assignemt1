terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "9385c619-7c30-43c8-a2e8-96626e341b2d"
}

# provider "azurerm" {
#   features {}
#   # subscription_id = var.subscription_id
# }