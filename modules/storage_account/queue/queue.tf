resource "azurerm_storage_queue" "queue" {
  name                 = var.settings.name
  storage_account_name = var.storage_account_name
  metadata             = try(var.settings.metadata, null)
}