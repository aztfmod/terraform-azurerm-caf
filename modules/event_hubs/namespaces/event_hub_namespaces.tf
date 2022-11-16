resource "azurecaf_name" "evh" {
  name          = var.settings.name
  resource_type = "azurerm_eventhub_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_eventhub_namespace" "evh" {
  name                     = azurecaf_name.evh.result
  location                 = local.location
  resource_group_name      = var.resource_group.name
  sku                      = var.settings.sku
  capacity                 = try(var.settings.capacity, null)
  tags                     = local.tags
  auto_inflate_enabled     = try(var.settings.auto_inflate_enabled, null)
  dedicated_cluster_id     = try(var.settings.dedicated_cluster_id, null)
  maximum_throughput_units = try(var.settings.maximum_throughput_units, null)
  zone_redundant           = try(var.settings.zone_redundant, null)

  dynamic "identity" {
    for_each = try(var.settings.identity, {})
    content {
      type = identity.value.type
    }
  }

  dynamic "network_rulesets" {
    for_each = try(var.settings.network_rulesets, {})
    content {
      default_action                 = network_rulesets.value.default_action #Possible values are Allow and Deny. Defaults to Deny.
      trusted_service_access_enabled = try(network_rulesets.value.trusted_service_access_enabled, null)

      dynamic "virtual_network_rule" {
        for_each = try(var.settings.network_rulesets.virtual_network_rule, {})
        content {
          subnet_id                                       = virtual_network_rule.value.subnet_id
          ignore_missing_virtual_network_service_endpoint = try(virtual_network_rule.value.ignore_missing_virtual_network_service_endpoint, null)
        }
      }

      dynamic "ip_rule" {
        for_each = try(var.settings.network_rulesets.ip_rule, {})
        content {
          ip_mask = ip_rule.value.ip_mask
          action  = try(ip_rule.value.action, null)
        }
      }
    }
  }

}
