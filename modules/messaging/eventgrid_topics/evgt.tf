resource "azurecaf_name" "evgt" {
  name          = var.settings.name
  resource_type = "azurerm_eventgrid_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_eventgrid_topic" "evgt" {
  name                     = azurecaf_name.evgt.result
  location                 = var.location
  resource_group_name      = var.resource_group_name 
  tags                     = merge(try(var.settings.tags, {}), local.tags)
  input_schema             = try(var.settings.input_schema, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)

  // dynamic "identity" {
  //   for_each = try(var.settings.identity, null) == null ? [] : [1]

  //   content {
  //     type = var.settings.identity.type
  //     user_assigned_identity_id = lower(var.settings.identity.type) == "userassigned" ? coalesce(
  //       try(var.settings.identity.user_assigned_identity_id, null),
  //       try(var.managed_identities[var.settings.identity.lz_key][var.settings.identity.managed_identity_key].id, null),
  //       try(var.managed_identities[var.client_config.landingzone_key][var.settings.identity.managed_identity_key].id, null)
  //     ) : null
  //   }
  // }

  dynamic "input_mapping_fields" {
    for_each = try(var.settings.input_mapping_fields[*], {})

    content {
      id      = try(input_mapping_fields.value.id, null)
      topic     = try(input_mapping_fields.value.topic, null)
      event_type       = try(input_mapping_fields.value.event_type, null)
      event_time    = try(input_mapping_fields.value.event_time, null)
      data_version   = try(input_mapping_fields.value.data_version, null)
      subject                    = try(input_mapping_fields.value.subject, null)      
    }
  }

  dynamic "input_mapping_default_values" {
    for_each = try(var.settings.input_mapping_default_values[*], {})

    content {      
      event_type       = try(input_mapping_default_values.value.event_type, null)      
      data_version     = try(input_mapping_default_values.value.data_version, null)
      subject          = try(input_mapping_default_values.value.subject, null)      
    }
  }

  dynamic "inbound_ip_rule" {
    for_each = try(var.settings.inbound_ip_rules[*], {})

    content {
      action   = try(inbound_ip_rule.value.action, "Allow")
      ip_mask = inbound_ip_rule.value.ip_mask
    }
  }

}
