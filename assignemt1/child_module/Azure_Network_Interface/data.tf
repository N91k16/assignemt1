data "azurerm_subnet" "subnetdata" {
  name                = "subnet1"
  virtual_network_name = "vnet1"
  resource_group_name  = "ultimate"
}