
resource "azurecaf_name" "rhc" {
  name          = var.settings.name
  resource_type = "azurerm_relay_hybrid_connection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_relay_hybrid_connection" "rhc" {
  name                          = azurecaf_name.rhc.result
  resource_group_name           = var.resource_group_name
  relay_namespace_name          = can(var.settings.relay_namespace.name) ? var.settings.relay_namespace.name : var.remote_objects.relay_namespace[try(var.settings.relay_namespace.lz_key, var.client_config.landingzone_key)][var.settings.relay_namespace.key].name
  requires_client_authorization = try(var.settings.requires_client_authorization, null)
  user_metadata                 = try(var.settings.user_metadata, null)
}