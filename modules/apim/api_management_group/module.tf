resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_api_management_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_api_management_group" "apim" {
  name = azurecaf_name.apim.result

  api_management_name = coalesce(
    try(var.remote_objects.api_management[var.settings.api_management.lz_key][var.settings.api_management.key].name, null),
    try(var.remote_objects.api_management[var.client_config.landingzone_key][var.settings.api_management.key].name, null),
    try(var.settings.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(var.remote_objects.resource_group[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, null),
    try(var.remote_objects.resource_group[var.client_config.landingzone_key][var.settings.resource_group.key].name, null),
    try(var.settings.resource_group.name, null)
  )

  display_name = var.settings.display_name
  description  = try(var.settings.description, null)
  #external_id         = var.settings.external_id
  #type                = var.settings.type

  dynamic "timeouts" {
    for_each = try(var.settings.timeouts, null) != null ? [var.settings.timeouts] : []
    content {
      create = try(timeouts.value.create, null)
      read   = try(timeouts.value.read, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
