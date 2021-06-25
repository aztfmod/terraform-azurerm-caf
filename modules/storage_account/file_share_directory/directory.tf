resource "azurerm_storage_share_directory" "share_directory" {
  name                 = var.settings.name
  share_name           = var.share_name
  storage_account_name = var.storage_account_name
  metadata             = try(var.settings.metadata, null)
}