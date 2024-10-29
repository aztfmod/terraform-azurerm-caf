resource "azurerm_storage_share_directory" "share_directory" {
  name                 = var.settings.name
  storage_share_id     = var.storage_share_id
  metadata             = try(var.settings.metadata, null)
}