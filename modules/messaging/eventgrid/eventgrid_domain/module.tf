# naming convention
resource "azurecaf_name" "egd" {
  name          = var.name
  resource_type = "azurerm_eventgrid_domain"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Per options https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_instance
resource "azurerm_eventgrid_domain" "egd" {
  name                                      = azurecaf_name.egd.result
  location                                  = var.location
  resource_group_name                       = var.resource_group_name
  tags                                      = local.tags
  public_network_access_enabled             = var.public_network_access_enabled
  local_auth_enabled                        = var.local_auth_enabled
  auto_create_topic_with_first_subscription = var.auto_create_topic_with_first_subscription
  auto_delete_topic_with_last_subscription  = var.auto_delete_topic_with_last_subscription

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
      id           = lookup(var.input_mapping_fields, "id", null)
      topic        = lookup(var.input_mapping_fields, "topic", null)
      event_type   = lookup(var.input_mapping_fields, "event_type", null)
      event_time   = lookup(var.input_mapping_fields, "event_time", null)
      data_version = lookup(var.input_mapping_fields, "data_version", null)
      subject      = lookup(var.input_mapping_fields, "subject", null)
    }
  }



  dynamic "inbound_ip_rule" {
    for_each = var.inbound_ip_rule

    content {
      ip_mask = inbound_ip_rule.value.ip_mask
      action  = try(inbound_ip_rule.value.action, null)
    }
  }

}