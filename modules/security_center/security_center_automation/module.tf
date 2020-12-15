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
  description  = try(var.settings.description, null)
  enabled = try(var.settings.enabled, true)


  dynamic "action" {
    for_each = var.settings.type == "EventHub" ? var.settings.eventhub_data : {}
    content {
      type              = action.value.type
      resource_id       = var.eventhub_namespace_id
      connection_string = var.eventhub_namespace_connection #mandatory argument for Eventhub type
    }
  }

  dynamic "action" {
    for_each = var.settings.type == "LogAnalytics" ? var.settings.loganalytics_data : {}
    content {
      type              = action.value.type
      resource_id       = var.loganalytics_workspace
    }
  }

# support for 'LogicApps" coming soon

  dynamic "source" {
    for_each = var.settings.source
    content {
      event_source = source.value.event_source
      dynamic "rule_set" {
        for_each = try(var.settings.source.ruleset, {})
        content {
        rule {
          property_path = source.rulesetvalue.property_path
          operator = source.rulesetvalue.operator
          expected_value = source.ruleset.value.expected_value
          property_type = source.ruleset.value.property_type
         }
        }
      }
    }
  }

  scopes = ["/subscriptions/${var.subscription_id}"]
  tags = local.tags
}