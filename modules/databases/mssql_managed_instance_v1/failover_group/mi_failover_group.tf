resource "azurerm_mssql_managed_instance_failover_group" "sqlmi_failover_group" {
  name                        = var.settings.name
  location                    = var.location
  managed_instance_id         = var.managed_instance_id
  partner_managed_instance_id = var.partner_managed_instance_id

  dynamic "read_write_endpoint_failover_policy" {
    for_each = can(var.settings.read_write_endpoint_failover_policy) ? [1] : []

    content {
      mode          = var.settings.read_write_endpoint_failover_policy.mode
      grace_minutes = var.settings.read_write_endpoint_failover_policy.mode == "Automatic" ? var.settings.read_write_endpoint_failover_policy.grace_minutes : null
    }
  }

}
