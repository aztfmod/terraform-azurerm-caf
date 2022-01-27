resource "azurecaf_name" "postgresql_flexible_server_firewall_rule" {
  for_each = try(var.settings.postgresql_firewall_rules, {})

  name          = each.value.name
  resource_type = "azurerm_postgresql_flexible_server_firewall_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "postgresql" {
  for_each = try(var.settings.postgresql_firewall_rules, {})

  name             = azurecaf_name.postgresql_flexible_server_firewall_rule[each.key].result
  server_id        = azurerm_postgresql_flexible_server.postgresql.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address

  dynamic "timeouts" {
    for_each = try(var.settings.postgresql_flexible_firewall_rule.timeouts, null) == null ? [] : [1]

    content {
      create = try(timeouts.value.create, "30m")
      read   = try(timeouts.value.read, "5m")
      update = try(timeouts.value.update, "30m")
      delete = try(timeouts.value.delete, "30m")
    }
  }
}