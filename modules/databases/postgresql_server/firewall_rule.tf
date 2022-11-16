
#
# Firewall Rule
#

resource "azurerm_postgresql_firewall_rule" "postgresql_firewall_rules" {
  for_each = try(var.settings.postgresql_firewall_rules, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}
