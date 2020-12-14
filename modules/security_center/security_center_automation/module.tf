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

  action {
    type              = var.settings.type
    resource_id       = var.settings.resource_id
    connection_string = try(var.eventhub_namespace.default_primary_connection_string, null)
    trigger_url       = try(var.settings.trigger_url, null)
  }

  dynamic "source" {
    for_each = var.settings.source
    content {
      event_source = source.value.event_source
      rule_set {
        rule {
          property_path = source.value.property_path
          operator = source.value.operator
          expected_value = source.value.expected_value
          property_type = source.value.property_type
        }
      }
    }
  }

  scopes = ["/subscriptions/${var.subscription_id}"]
}