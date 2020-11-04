# naming convention
resource "azurecaf_name" "ws" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_workspace"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

# synapse workspace
resource "azurerm_synapse_workspace" "ws" {
  name                                 = azurecaf_name.ws.result
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = var.settings.sql_administrator_login
  sql_administrator_login_password     = try(var.settings.sql_administrator_login_password, random_password.sql_admin.0.result)
  tags                                 = local.tags
}

# Generate sql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "sql_admin" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  length           = 128
  special          = true
  upper            = true
  number           = true
  override_special = "$#%"
}

# Store the generated password into keyvault for password rotation support
resource "azurerm_key_vault_secret" "sql_admin_password" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-sql-admin-password", azurerm_synapse_workspace.ws.name)
  value        = random_password.sql_admin.0.result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_secret" "sql_admin" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-sql-admin-username", azurerm_synapse_workspace.ws.name)
  value        = var.settings.sql_administrator_login
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "synapse_name" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-name", azurerm_synapse_workspace.ws.name)
  value        = azurerm_synapse_workspace.ws.name
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "synapse_rg_name" {
  count = try(var.settings.sql_administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-synapse-resource-group-name", azurerm_synapse_workspace.ws.name)
  value        = var.resource_group_name
  key_vault_id = var.keyvault_id
}

resource "azurerm_synapse_firewall_rule" "wrkspc_firewall" {
  name                 = var.settings.workspace_firewall.name
  synapse_workspace_id = azurerm_synapse_workspace.ws.id
  start_ip_address     = var.settings.workspace_firewall.start_ip
  end_ip_address       = var.settings.workspace_firewall.end_ip
}