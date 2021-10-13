
# azure_caf
resource "azurecaf_name" "namespace" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_namespace" "namespace" {
  name           = azurecaf_name.namespace.result
  sku            = var.settings.sku
  capacity       = try(var.settings.capacity, null)
  zone_redundant = try(var.settings.zone_redundant, null)
  tags           = merge(local.base_tags, try(var.settings.tags, {}))
  
  location = coalesce(
    try(var.settings.location, null),
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].location, null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].location, null)
  )

  resource_group_name = coalesce(
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].name, null)
  )

}