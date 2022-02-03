# naming convention
resource "azurecaf_name" "egt" {
  name          = var.name
  resource_type = "azurerm_eventgrid_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Per options https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_instance
resource "azurerm_eventgrid_topic" "egt" {
  name                = azurecaf_name.egt.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type         = var.identity.type
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

  input_schema = var.input_schema

  dynamic "input_mapping_fields" {
    for_each = try(var.input_mapping_fields, null) == null ? [] : [1]

    content {
      id           = try(each.value.id, null)
      topic        = try(each.value.topic, null)
      event_type   = try(each.value.event_type, null)
      event_time   = try(each.value.event_time, null)
      data_version = try(each.value.data_version, null)
      subject      = try(each.value.subject, null)
    }
  }


  dynamic "input_mapping_default_values" {
    for_each = try(var.input_mapping_default_values, null) == null ? [] : [1]

    content {
      event_type   = try(each.value.event_type, null)
      data_version = try(each.value.data_version, null)
      subject      = try(each.value.subject, null)
    }
  }

  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = var.local_auth_enabled



  dynamic "inbound_ip_rule" {
    for_each = var.inbound_ip_rule

    content {
      ip_mask = inbound_ip_rule.value.ip_mask
      action  = try(inbound_ip_rule.value.action, null)
    }
  }

}