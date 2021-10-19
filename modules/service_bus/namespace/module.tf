resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = var.settings.namespace
  location            = var.location
  resource_group_name = var.resource_group_name

  sku      = try(var.settings.sku, "Basic")
  capacity = try(var.settings.capacity, try(var.settings.sku, "Basic") == "Premium" ? 1 : 0)

  tags = local.tags
}

resource "azurerm_servicebus_namespace_network_rule_set" "servicebus" {
  count = length(try(var.settings.ip_rules, [])) + length(try(var.settings.network_rules, [])) > 0 ? 1 : 0

  namespace_name      = var.settings.namespace
  resource_group_name = var.resource_group_name

  default_action = "Deny"
  ip_rules       = var.settings.ip_rules

  dynamic "network_rules" {
    for_each = try(var.settings.network_rules, [])
    content {
      subnet_id                            = network_rules.value["subnet_id"]
      ignore_missing_vnet_service_endpoint = network_rules.value["ignore_missing_vnet_service_endpoint"]
    }
  }
}