resource "azurerm_storage_container" "sc" {
  name                  = var.settings.name
  storage_account_name  = var.storage_account_name
  container_access_type = try(var.settings.container_access_type, null)
  metadata              = try(var.settings.metadata, null)
}
