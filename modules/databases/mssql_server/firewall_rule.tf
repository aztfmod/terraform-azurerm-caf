#
# Firewall Rule
#

resource "azurerm_sql_firewall_rule" "mssql_firewall_rules" {

  for_each = try(var.settings.mssql_firewall_rules, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.mssql.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}