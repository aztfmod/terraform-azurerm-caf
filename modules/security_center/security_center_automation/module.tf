resource "azurecaf_name" "sec_center_automation" {
  name          = var.settings.name
  resource_type = "azurerm_eventhub"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_security_center_automation" "sca1" {
  name                = azurecaf_name.sec_center_automation.result
  location            = var.location
  resource_group_name = var.resource_group_name


  dynamic "action" {
    for_each = var.settings.type == "EventHub" ? var.settings.eventhub_data : {}
    content {
      type              = action.value.type
      resource_id       = var.eventhub_namespace_id
      connection_string = var.eventhub_namespace_connection
    }
  }

  dynamic "action" {
    for_each = var.settings.type == "LogAnalytics" ? var.settings.loganalytics_data : {}
    content {
      type              = action.value.type
      resource_id       = var.loganalytics_workspace.id
    }
  }

  dynamic "action" {
    for_each = var.settings.type == "LogicApp" ? var.settings.logicapp_data : {}
    content {
      type              = action.value.type
      resource_id       = action.value.resource_id
      trigger_url       = try(action.value.trigger_url, null)
    }
  }

  dynamic "source" {
    for_each = var.settings.source
    content {
      event_source = source.value.event_source
      dynamic "rule_set" {
        for_each = try(var.settings.source.ruleset, {})
        content {
        rule {
          property_path = source.value.property_path
          operator = source.value.operator
          expected_value = source.value.expected_value
          property_type = source.value.property_type
         }
        }
      }
    }
  }

  scopes = ["/subscriptions/${var.subscription_id}"]
}