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
    for_each = local.ipv4_firewall_rules

    content {
      name        = ipv4_firewall_rule.value.name
      range_start = try(ipv4_firewall_rule.value.range_start, null)
      range_end   = try(ipv4_firewall_rule.value.range_end, null)
    }
  }
}

locals {
  ipv4_firewall_rules = [
    {
      name        = "ClientIPAddress03"
      range_start = "217.22.14.10"
      range_end   = "217.22.14.10"
    },
    {
      name        = "ClientIPAddress04"
      range_start = "51.140.74.14"
      range_end   = "51.140.74.14"
    },
  ]
}
