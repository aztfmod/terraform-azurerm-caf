resource "azurecaf_name" "sc" {
  name          = var.settings.name
  resource_type = "azurerm_storage_container"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_storage_container" "sc" {
  name = azurecaf_name.sc.result

  storage_account_name  = var.storage_account_name
  container_access_type = try(var.settings.container_access_type, null)
  metadata              = try(var.settings.metadata, null)
}
