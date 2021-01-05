
#
# Firewall Rule
#
resource "azurerm_mariadb_firewall_rule" "mariadb_firewall_rules" {

  for_each = try(var.settings.mariadb_firewall_rules, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mariadb_server.mariadb.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}