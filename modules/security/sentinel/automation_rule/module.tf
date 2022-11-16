resource "azurerm_sentinel_automation_rule" "automation_rule" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  display_name               = var.display_name
  order                      = var.order
  enabled                    = var.enabled
  expiration                 = var.expiration

  dynamic "action_incident" {
    for_each = try(var.settings.action_incident, {})

    content {
      order                  = try(action_incident.value.order, null)
      status                 = try(action_incident.value.status, null)
      classification         = try(action_incident.value.classification, null)
      classification_comment = try(action_incident.value.classification_comment, null)
      labels                 = try(action_incident.value.labels, null)
      owner_id               = try(action_incident.value.owner_id, null)
      severity               = try(action_incident.value.severity, null)
    }
  }

  dynamic "action_playbook" {
    for_each = try(var.settings.action_playbook, {})

    content {
      logic_app_id = try(var.combined_objects_logic_app_workflow[try(action_playbook.value.lz_key, var.client_config.landingzone_key)][action_playbook.value.logic_app_key].id, null)
      order        = try(action_playbook.value.order, null)
      tenant_id    = try(action_playbook.value.tenant_id, null)
    }
  }

  dynamic "condition" {
    for_each = try(var.settings.condition, {})

    content {
      operator = try(condition.value.operator, null)
      property = try(condition.value.property, null)
      values   = try(condition.value.values, null)
    }
  }
}
