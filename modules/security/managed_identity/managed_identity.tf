locals {
  tags = try(var.settings.tags, null) == null ? null : try(var.settings.tags.environment, null) == null ? var.settings.tags : merge(lookup(var.settings, "tags", {}), { "environment" : var.global_settings.environment })
}
resource "azurecaf_name" "msi" {
  name          = var.name
  resource_type = "azurerm_user_assigned_identity"
  prefixes      = try(var.settings.naming_convention.prefixes, var.global_settings.prefixes)
  random_length = try(var.settings.naming_convention.random_length, var.global_settings.random_length)
  clean_input   = true
  passthrough   = try(var.settings.naming_convention.passthrough, var.global_settings.passthrough)
  use_slug      = try(var.settings.naming_convention.use_slug, var.global_settings.use_slug)
}

resource "azurerm_user_assigned_identity" "msi" {
  name = azurecaf_name.msi.result
  resource_group_name = coalesce(
    try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].name, null),
    try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group_key].name, null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group_key].name, null),
  )
  location = coalesce(
    try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].location, null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].location, null),
    try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group_key].location, null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group_key].location, null),
  )
  tags = try(
    merge(
      try(var.global_settings.inherit_tags, false) ?
      coalesce(
        try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].tags, null),
        try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].tags, null),
        try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group_key].tags, null),
        try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group_key].tags, null),
      ) : {},
      local.tags
    ),
    {}
  )

  lifecycle {
    ignore_changes = [
      location, resource_group_name
    ]
  }
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [azurerm_user_assigned_identity.msi]

  create_duration = "30s"
}