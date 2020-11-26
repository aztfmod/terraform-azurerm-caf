
#
# Firewall Rule
#

resource "azurerm_mysql_firewall_rule" "mysql_firewall_rules" {

  for_each = try(var.settings.mysql_firewall_rules, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}
