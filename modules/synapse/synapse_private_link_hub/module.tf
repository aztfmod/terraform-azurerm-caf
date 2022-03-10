
resource "azurecaf_name" "syplh" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_private_link_hub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_private_link_hub" "syplh" {
  name                = azurecaf_name.syplh.result
  resource_group_name = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_group[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
  location            = var.location
  tags                = local.tags
}