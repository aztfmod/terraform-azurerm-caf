resource "azurecaf_name" "mysql_flexible_firewall_rule" {
  for_each = try(var.settings.mysql_firewall_rules, {})

  name          = each.value.name
  resource_type = "azurerm_mysql_flexible_server_firewall_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}


resource "azurerm_mysql_flexible_server_firewall_rule" "mysql" {
  for_each = try(var.settings.mysql_firewall_rules, {})

  name                = azurecaf_name.mysql_flexible_firewall_rule[each.key].result
  server_name         = azurerm_mysql_flexible_server.mysql.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
  resource_group_name = var.resource_group_name

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


