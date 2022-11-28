resource "azurecaf_name" "egt" {
  name          = var.settings.name
  resource_type = "azurerm_eventgrid_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_eventgrid_topic" "egt" {
  name                = azurecaf_name.egt.result
  resource_group_name = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_group[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
  location            = var.location

  dynamic "identity" {
    for_each = try(var.settings.identity, null) != null ? [var.settings.identity] : []
    content {
      type         = try(identity.value.type, null)
      identity_ids = try(identity.value.identity_ids, null)
    }
  }
  input_schema = try(var.settings.input_schema, null)

  dynamic "input_mapping_fields" {
    for_each = try(var.settings.input_mapping_fields, null) != null ? [var.settings.input_mapping_fields] : []
    content {
      id           = try(input_mapping_fields.value.id, null)
      topic        = try(input_mapping_fields.value.topic, null)
      event_type   = try(input_mapping_fields.value.event_type, null)
      event_time   = try(input_mapping_fields.value.event_time, null)
      data_version = try(input_mapping_fields.value.data_version, null)
      subject      = try(input_mapping_fields.value.subject, null)
    }
  }
  dynamic "input_mapping_default_values" {
    for_each = try(var.settings.input_mapping_default_values, null) != null ? [var.settings.input_mapping_default_values] : []
    content {
      event_type   = try(input_mapping_default_values.value.event_type, null)
      data_version = try(input_mapping_default_values.value.data_version, null)
      subject      = try(input_mapping_default_values.value.subject, null)
    }
  }
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  local_auth_enabled            = try(var.settings.local_auth_enabled, null)

  dynamic "inbound_ip_rule" {
    for_each = try(var.settings.inbound_ip_rule, null) != null ? [var.settings.inbound_ip_rule] : []
    content {
      ip_mask = try(inbound_ip_rule.value.ip_mask, null)
      action  = try(inbound_ip_rule.value.action, null)
    }
  }
  tags = local.tags

}