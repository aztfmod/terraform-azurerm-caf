resource "azurecaf_naming_convention" "acr" {
  name          = var.name
  prefix        = var.global_settings.prefix
  resource_type = "azurerm_container_registry"
  max_length    = var.global_settings.max_length
  convention    = var.global_settings.convention
}

resource "azurerm_container_registry" "acr" {
  name                     = azurecaf_naming_convention.acr.result
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  georeplication_locations = var.georeplication_locations
  tags                     = var.tags

  dynamic "network_rule_set" {
    for_each = var.network_rule_set

    content {
      default_action = try(var.network_rule_set.default_action, "Allow")

      dynamic "ip_rule" {
        for_each = try(network_rule_set.value.ip_rules, {})

        content {
          action   = "Allow"
          ip_range = ip_rule.value.ip_range
        }
      }
      dynamic "virtual_network" {
        for_each = try(network_rule_set.value.virtual_networks, {})

        content {
          action    = "Allow"
          subnet_id = try(var.vnets[virtual_network.value.vnet_key].subnets[virtual_network.value.subnet_key].id, {})
        }
      }
    }
  }
}

