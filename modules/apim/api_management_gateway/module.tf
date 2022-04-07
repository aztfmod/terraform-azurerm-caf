resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_api_management_gateway"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_api_management_gateway" "apim" {
  name = azurecaf_name.apim.result

  api_management_id = coalesce(
    try(var.remote_objects.api_management[var.settings.api_management.lz_key][var.settings.api_management.key].id, null),
    try(var.remote_objects.api_management[var.client_config.landingzone_key][var.settings.api_management.key].id, null),
    try(var.settings.api_management.id, null)
  )

  # resource_group_name exists in the documentation but not in the provider Source code
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_gateway
  #
  #
  # resource_group_name = coalesce(
  #   try(var.remote_objects.resource_group[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, null),
  #   try(var.remote_objects.resource_group[var.client_config.landingzone_key][var.settings.resource_group.key].name, null),
  #   try(var.settings.resource_group.name, null)
  # )

  description = try(var.settings.description, null)

  dynamic "location_data" {
    for_each = try(var.settings.location_data, null) != null ? [var.settings.location_data] : []
    content {
      name     = try(location_data.value.name, null)
      region   = try(location_data.value.region, null)
      city     = try(location_data.value.city, null)
      district = try(location_data.value.district, null)
    }
  }
}