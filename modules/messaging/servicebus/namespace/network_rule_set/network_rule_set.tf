resource "azurerm_servicebus_namespace_network_rule_set" "rule_set" {
  namespace_id = var.remote_objects.servicebus_namespace_id
  # resource_group_name = var.remote_objects.resource_group_name
  default_action                = try(var.settings.default_action, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  trusted_services_allowed      = try(var.settings.trusted_services_allowed, null)
  ip_rules                      = try(var.settings.ip_rules, null)

  dynamic "network_rules" {
    for_each = try(var.settings.subnets, {})
    content {
      subnet_id                            = can(network_rules.value.id) ? network_rules.value.id : var.remote_objects.vnets[try(network_rules.value.lz_key, var.client_config.landingzone_key)][network_rules.value.vnet_key].subnets[network_rules.value.subnet_key].id
      ignore_missing_vnet_service_endpoint = try(network_rules.value.ignore_missing_vnet_service_endpoint, null)
    }
  }
}
