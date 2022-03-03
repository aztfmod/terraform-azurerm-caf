resource "azurecaf_name" "sdlg2" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_storage_data_lake_gen2_filesystem"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_storage_data_lake_gen2_filesystem" "sdlg2" {
  name               = azurecaf_name.sdlg2.result
  storage_account_id = can(var.settings.storage_account.id) ? var.settings.storage_account.id : var.remote_objects.storage_account[try(var.settings.storage_account.lz_key, var.client_config.landingzone_key)][var.settings.storage_account.key].id
  properties         = try(var.settings.properties, null)
  dynamic "ace" {
    for_each = try(var.settings.ace, null) != null ? [var.settings.ace] : []
    content {
      scope       = try(ace.value.scope, null)
      type        = try(ace.value.type, null)
      id          = try(ace.value.id, null)
      permissions = try(ace.value.permissions, null)
    }
  }
}