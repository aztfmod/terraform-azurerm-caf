resource "azurerm_analysis_services_server" "as_server" {
  admin_users             = var.settings.admin_users
  enable_power_bi_service = var.settings.enable_power_bi_service
  location                = var.location
  name                    = var.settings.name
  resource_group_name     = var.resource_group_name
  sku                     = var.settings.sku
  tags                    = local.tags

  dynamic "ipv4_firewall_rule" {
    # for_each = try(var.settings.ipv4_firewall_rules, null) != null ? [var.settings.ipv4_firewall_rules] : []
    for_each = var.settings.ipv4_firewall_rules

    content {
      name        = ipv4_firewall_rule.value.name
      range_start = ipv4_firewall_rule.value.range_start
      range_end   = ipv4_firewall_rule.value.range_end
    }
  }
}
