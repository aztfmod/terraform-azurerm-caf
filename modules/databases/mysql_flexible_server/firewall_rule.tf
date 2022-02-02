resource "azurerm_mysql_flexible_server_firewall_rule" "mysql" {
  for_each = try(var.settings.mysql_firewall_rules, {})

  name                = each.value.name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
  resource_group_name = var.resource_group.name
  
  dynamic "timeouts" {
    for_each = try(var.settings.mysql_flexible_firewall_rule.timeouts, null) == null ? [] : [1]

    content {
      create = try(timeouts.value.create, "30m")
      read   = try(timeouts.value.read, "5m")
      update = try(timeouts.value.update, "30m")
      delete = try(timeouts.value.delete, "30m")
    }
  }
}


