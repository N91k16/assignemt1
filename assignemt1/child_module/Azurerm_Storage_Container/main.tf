resource "azurerm_storage_container" "container1" {
  for_each = var.container_child
  name                  = each.value.name
  # expects `storage_account_id` to be the full resource id of the storage account
  storage_account_id    = each.value.storage_account_id
  container_access_type = each.value.container_access_type
}

# optional blob creation when `blob_content` is provided
resource "azurerm_storage_blob" "blob" {
  for_each = { for k, v in var.container_child : k => v if lookup(v, "blob_source", "") != "" }

  name                   = lookup(each.value, "blob_name", "blob")
  storage_account_name   = lookup(each.value, "storage_account_name", "")
  storage_container_name = azurerm_storage_container.container1[each.key].name
  type                   = "Block"
  source                 = each.value.blob_source
  content_type           = each.value.blob_content_type
}