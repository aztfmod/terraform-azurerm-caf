resource "azurerm_servicebus_namespace_network_rule_set" "rule_set" {
  namespace_name      = var.remote_objects.servicebus_namespace_name
  resource_group_name = var.remote_objects.resource_group_name
  default_action      = var.settings.default_action
  ip_rules            = var.settings.ip_rules

  dynamic "network_rules" {
    for_each = try(var.settings.network_rules, {})
    content {
      subnet_id = coalesce(
        try(var.remote_objects.vnets[network_rules.value.lz_key][network_rules.value.vnet_key].subnets[network_rules.value.subnet_key].id, null),
        try(var.remote_objects.vnets[var.client_config.landingzone_key][network_rules.value.vnet_key].subnets[network_rules.value.subnet_key].id, null)
      )
      ignore_missing_vnet_service_endpoint = network_rules.value.ignore_missing_vnet_service_endpoint
    }
  }
}
