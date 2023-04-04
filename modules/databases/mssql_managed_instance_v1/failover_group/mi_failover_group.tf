resource "azurecaf_name" "sqlmifailover" {

  name          = var.settings.name
  resource_type = "azurerm_sql_failover_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_sql_managed_instance_failover_group" "sqlmi_failover_group" {
  name                        = azurecaf_name.sqlmifailover.result
  resource_group_name         = var.resource_group_name
  location                    = var.location
  managed_instance_name       = var.managed_instance_name
  partner_managed_instance_id = var.partner_managed_instance_id

  dynamic "read_write_endpoint_failover_policy" {
    for_each = can(var.settings.read_write_endpoint_failover_policy) ? [1] : []

    content {
      mode          = var.settings.read_write_endpoint_failover_policy.mode
      grace_minutes = var.settings.read_write_endpoint_failover_policy.mode == "Automatic" ? var.settings.read_write_endpoint_failover_policy.grace_minutes : null
    }
  }
}
