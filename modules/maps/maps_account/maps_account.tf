
# naming convention
data "azurecaf_name" "map" {
  name          = var.settings.name
  resource_type = "azurerm_maps_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_maps_account" "map" {
  name                = data.azurecaf_name.map.result
  resource_group_name = local.resource_group_name
  sku_name            = var.settings.sku_name
  tags                = local.tags

}

# Store the primary_access_key into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "primary_access_key" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-primary-key", data.azurecaf_name.map.result)
  value        = azurerm_maps_account.map.primary_access_key
  key_vault_id = var.remote_objects.keyvaults[try(var.settings.keyvault.lz_key, var.client_config.landingzone_key)][var.settings.keyvault.key].id
}

# Store the secondary_access_key into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "secondary_access_key" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-secondary-key", data.azurecaf_name.map.result)
  value        = azurerm_maps_account.map.secondary_access_key
  key_vault_id = var.remote_objects.keyvaults[try(var.settings.keyvault.lz_key, var.client_config.landingzone_key)][var.settings.keyvault.key].id
}
