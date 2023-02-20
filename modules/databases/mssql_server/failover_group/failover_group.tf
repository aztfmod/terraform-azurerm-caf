resource "azurecaf_name" "failover_group" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_server" //TODO: add support for sql failover group
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_mssql_failover_group" "failover_group" {
  name                                      = azurecaf_name.failover_group.result
  server_id                                 = var.primary_server_id
  databases                                 = local.databases
  readonly_endpoint_failover_policy_enabled = try(var.settings.readonly_endpoint_failover_policy_enabled, null)

  partner_server {
    id = var.secondary_server_id
  }

  read_write_endpoint_failover_policy {
    mode          = var.settings.read_write_endpoint_failover_policy.mode
    grace_minutes = var.settings.read_write_endpoint_failover_policy.mode == "Automatic" ? var.settings.read_write_endpoint_failover_policy.grace_minutes : null
  }
}
