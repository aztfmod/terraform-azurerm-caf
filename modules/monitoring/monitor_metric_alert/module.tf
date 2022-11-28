
resource "azurecaf_name" "mma" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_monitor_metric_alert"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_monitor_metric_alert" "mma" {
  name                = azurecaf_name.mma.result
  resource_group_name = var.resource_group_name
  scopes = try(flatten([
    for key, value in var.settings.scopes : coalesce(
      try(var.remote_objects[value.resource_type][value.lz_key][value.lz_key][value.key].id, null),
      try(var.remote_objects[value.resource_type][var.client_config.landingzone_key][value.key].id, null),
      try(value.id, null),
      []
    )
  ]), [])
  dynamic "criteria" {
    for_each = try(var.settings.criteria, null) != null ? [var.settings.criteria] : []
    content {
      metric_namespace = try(criteria.value.metric_namespace, null)
      metric_name      = try(criteria.value.metric_name, null)
      aggregation      = try(criteria.value.aggregation, null)
      operator         = try(criteria.value.operator, null)
      threshold        = try(criteria.value.threshold, null)
      dynamic "dimension" {
        for_each = try(var.settings.dimension, null) != null ? [var.settings.dimension] : []
        content {
          name     = try(dimension.value.name, null)
          operator = try(dimension.value.operator, null)
          values   = try(dimension.value.values, null)
        }
      }
      skip_metric_validation = try(criteria.value.skip_metric_validation, null)
    }
  }
  dynamic "dynamic_criteria" {
    for_each = try(var.settings.dynamic_criteria, null) != null ? [var.settings.dynamic_criteria] : []
    content {
      metric_namespace  = try(dynamic_criteria.value.metric_namespace, null)
      metric_name       = try(dynamic_criteria.value.metric_name, null)
      aggregation       = try(dynamic_criteria.value.aggregation, null)
      operator          = try(dynamic_criteria.value.operator, null)
      alert_sensitivity = try(dynamic_criteria.value.alert_sensitivity, null)
      dynamic "dimension" {
        for_each = try(var.settings.dimension, null) != null ? [var.settings.dimension] : []
        content {
          name     = try(dimension.value.name, null)
          operator = try(dimension.value.operator, null)
          values   = try(dimension.value.values, null)
        }
      }
      evaluation_total_count   = try(dynamic_criteria.value.evaluation_total_count, null)
      evaluation_failure_count = try(dynamic_criteria.value.evaluation_failure_count, null)
      ignore_data_before       = try(dynamic_criteria.value.ignore_data_before, null)
      skip_metric_validation   = try(dynamic_criteria.value.skip_metric_validation, null)
    }
  }
  dynamic "application_insights_web_test_location_availability_criteria" {
    for_each = try(var.settings.application_insights_web_test_location_availability_criteria, null) != null ? [var.settings.application_insights_web_test_location_availability_criteria] : []
    content {
      web_test_id           = try(application_insights_web_test_location_availability_criteria.value.web_test_id, null)
      component_id          = try(application_insights_web_test_location_availability_criteria.value.component_id, null)
      failed_location_count = try(application_insights_web_test_location_availability_criteria.value.failed_location_count, null)
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
  enabled                  = try(var.settings.enabled, null)
  auto_mitigate            = try(var.settings.auto_mitigate, null)
  description              = try(var.settings.description, null)
  frequency                = try(var.settings.frequency, null)
  severity                 = try(var.settings.severity, null)
  target_resource_type     = try(var.settings.target_resource_type, null)
  target_resource_location = try(var.settings.target_resource_location, null)
  window_size              = try(var.settings.window_size, null)
  tags                     = local.tags
}