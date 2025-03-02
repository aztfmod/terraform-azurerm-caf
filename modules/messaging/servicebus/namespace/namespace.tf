
locals {
  # Need to update the tags if the environment tag is updated with the rover command line
  caf_tags = can(var.settings.tags.caf_environment) || can(var.settings.tags.environment) ? merge(lookup(var.settings, "tags", {}), { "caf_environment" : var.global_settings.environment }) : {}
}

# naming convention azure_caf
resource "azurecaf_name" "namespace" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_namespace" "namespace" {
  name                         = azurecaf_name.namespace.result
  sku                          = var.settings.sku
  capacity                     = try(var.settings.capacity, null)
  tags                         = merge(try(var.settings.tags, null), local.caf_tags)
  premium_messaging_partitions = try(var.settings.premium_messaging_partitions, null)
  location                     = local.location
  resource_group_name          = local.resource_group_name
  dynamic "network_rule_set" {
    for_each = try(var.settings.network_rule_sets, {})
    content {
      default_action                = try(network_rule_set.value.default_action, null)
      public_network_access_enabled = try(network_rule_set.value.public_network_access_enabled, null)
      trusted_services_allowed      = try(network_rule_set.value.trusted_services_allowed, null)
      ip_rules                      = try(network_rule_set.value.ip_rules, null)
      dynamic "network_rules" {
        for_each = try(network_rule_set.value.subnets, {})
        content {
          subnet_id = can(network_rules.value.id) ? network_rules.value.id : var.remote_objects.vnets[try(network_rules.value.lz_key, var.client_config.landingzone_key)][network_rules.value.vnet_key].subnets[network_rules.value.subnet_key].id
          ignore_missing_vnet_service_endpoint = try(network_rules.value.ignore_missing_vnet_service_endpoint, null)
        }
      }
  }
}
}