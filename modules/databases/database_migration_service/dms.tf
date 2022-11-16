resource "azurecaf_name" "dms" {
  name          = var.settings.name
  resource_type = "azurerm_database_migration_service"
  prefixes      = var.global_settings.prefix
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azurerm_database_migration_service" "dms" {
  name                = azurecaf_name.dms.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.settings.sku_name
  tags                = local.tags
  subnet_id           = can(var.settings.subnet.id) ? var.settings.subnet.id : var.remote_objects.vnets[try(var.settings.subnet.lz_key, var.client_config.landingzone_key)][var.settings.subnet.vnet_key].subnets[var.settings.subnet.subnet_key].id
}