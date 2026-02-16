data "azurerm_key_vault" "mynameiskeyvault" {
  name                = "mynameiskeyvault"
  resource_group_name = "storage"
}



data "azurerm_key_vault_secret" "subid" {
  name         = "subid"
  key_vault_id = data.azurerm_key_vault.mynameiskeyvault.id
}
