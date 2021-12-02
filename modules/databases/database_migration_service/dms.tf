resource "azurecaf_name" "dms" {
  name          = var.settings.name
  resource_type = "azurerm_database_migration_service"
  prefixes      = var.global_settings.prefix
  suffixes      = var.global_settings.suffixes
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
  subnet_id = coalesce(
    try(var.settings.subnet.id, null),
    try(var.remote_objects.vnets[var.client_config.landingzone_key][var.settings.subnet.vnet_key].subnets[var.settings.subnet.subnet_key].id, null),
    try(var.remote_objects.vnets[var.settings.subnet.lz_key][var.settings.subnet.vnet_key].subnets[var.settings.subnet.subnet_key].id, null)
  )
}