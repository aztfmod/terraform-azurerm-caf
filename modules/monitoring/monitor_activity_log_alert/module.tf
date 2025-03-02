
resource "azurecaf_name" "mala" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_monitor_activity_log_alert"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_monitor_activity_log_alert" "mala" {
  name                = azurecaf_name.mala.result
  resource_group_name = var.resource_group_name
  scopes = try(flatten([
    for key, value in var.settings.scopes : coalesce(
      try(var.remote_objects[value.resource_type][value.lz_key][value.key].id, null),
      try(var.remote_objects[value.resource_type][var.client_config.landingzone_key][value.key].id, null),
      try(value.id, null),
      []
    )
  ]), [])
  dynamic "criteria" {
    for_each = try(var.settings.criteria, null) != null ? [var.settings.criteria] : []
    content {
      category          = try(criteria.value.category, null)
      operation_name    = try(criteria.value.operation_name, null)
      resource_provider = try(criteria.value.resource_provider, null)
      resource_type     = try(criteria.value.resource_type, null)
      resource_group    = try(criteria.value.resource_group, null)
      resource_id = try(
        var.remote_objects[criteria.value.resource.resource_type][criteria.value.resource.lz_key][criteria.value.resource.key].id,
        var.remote_objects[criteria.value.resource.resource_type][var.client_config.landingzone_key][criteria.value.resource.key].id,
        criteria.value.resource.id,
        null
      )
      caller                  = try(criteria.value.caller, null)
      level                   = try(criteria.value.level, null)
      status                  = try(criteria.value.status, null)
      sub_status              = try(criteria.value.sub_status, null)
      recommendation_type     = try(criteria.value.recommendation_type, null)
      recommendation_category = try(criteria.value.recommendation_category, null)
      recommendation_impact   = try(criteria.value.recommendation_impact, null)
      dynamic "service_health" {
        for_each = try(var.settings.service_health, null) != null ? [var.settings.service_health] : []
        content {
          events    = try(service_health.value.events, null)
          locations = try(service_health.value.locations, null)
          services  = try(service_health.value.services, null)
        }
      }
    }
  }
  dynamic "action" {
    for_each = try(var.settings.action, null) != null ? [var.settings.action] : []
    content {
      action_group_id = coalesce(
        try(var.remote_objects["monitor_action_groups"][action.value.action_group.lz_key][action.value.action_group.key].id, null),
        try(var.remote_objects["monitor_action_groups"][var.client_config.landingzone_key][action.value.action_group.key].id, null),
        try(action.value.action_group.id, null),
      )
      webhook_properties = try(action.value.webhook_properties, null)
    }
  }
  enabled     = try(var.settings.enabled, null)
  description = try(var.settings.description, null)
  tags        = local.tags
}
