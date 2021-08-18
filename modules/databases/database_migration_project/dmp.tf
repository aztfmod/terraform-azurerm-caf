resource "azurecaf_name" "dmp" {
  name          = var.settings.name
  resource_type = "azurerm_database_migration_project"
  prefixes      = var.global_settings.prefix
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azurerm_database_migration_project" "dmp" {
  name                = azurecaf_name.dmp.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  service_name = coalesce(
    try(var.settings.service.name, null),
    try(var.database_migration_services[var.client_config.landingzone_key][var.settings.service.key].name, null),
    try(var.database_migration_services[var.settings.service.lz_key][var.settings.service.key].name, null)
  )
  source_platform = var.settings.source_platform
  target_platform = var.settings.target_platform
}