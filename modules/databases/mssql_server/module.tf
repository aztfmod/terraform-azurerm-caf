
resource "azurerm_mssql_server" "mssql" {

  name                          = azurecaf_naming_convention.mssql.result
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = try(var.settings.version, "12.0")
  administrator_login           = var.settings.administrator_login
  administrator_login_password  = try(var.settings.administrator_login_password, azurerm_key_vault_secret.sql_admin_password.0.value)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  tags                          = try(var.settings.tags, null)

  dynamic "extended_auditing_policy" {
    for_each = lookup(var.settings, "extended_auditing_policy", {}) == {} ? [] : [1]

    content {
      storage_endpoint                        = data.azurerm_storage_account.mssql_auditing.0.primary_blob_endpoint
      storage_account_access_key              = data.azurerm_storage_account.mssql_auditing.0.primary_access_key
      storage_account_access_key_is_secondary = false
      retention_in_days                       = var.settings.extended_auditing_policy.retention_in_days
    }
  }

  dynamic "azuread_administrator" {
    for_each = lookup(var.settings, "azuread_administrator", {}) == {} ? [] : [1]

    content {
      login_username = try(var.settings.azuread_administrator.login_username, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].name)
      object_id      = try(var.settings.azuread_administrator.object_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].id)
      tenant_id      = try(var.settings.azuread_administrator.tenant_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].tenant_id)
    }
  }

}

resource "azurecaf_naming_convention" "mssql" {

  name          = var.settings.name
  resource_type = "azurerm_sql_server"
  convention    = try(var.settings.convention, var.global_settings.convention)
  prefix        = lookup(var.settings, "useprefix", true) == false ? "" : var.global_settings.prefix
  max_length    = try(var.settings.max_length, var.global_settings.max_length)
}

# Generate sql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "sql_admin" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  length           = 128
  special          = true
  upper            = true
  number           = true
  override_special = "$#%"
}

# Store the generated password into keyvault
resource "azurerm_key_vault_secret" "sql_admin_password" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-password", azurecaf_naming_convention.mssql.result)
  value        = random_password.sql_admin.0.result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_secret" "sql_admin" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-username", azurecaf_naming_convention.mssql.result)
  value        = var.settings.administrator_login
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "sql_fqdn" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-fqdn", azurecaf_naming_convention.mssql.result)
  value        = azurerm_mssql_server.mssql.fully_qualified_domain_name
  key_vault_id = var.keyvault_id
}

data "azurerm_storage_account" "mssql_auditing" {
  count = try(var.settings.extended_auditing_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.extended_auditing_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.extended_auditing_policy.storage_account.key].resource_group_name
}




#
# security_alert_policy and server_vulnerability_assessment
#
#

data "azurerm_storage_account" "mssql_security_alert" {
  count = try(var.settings.security_alert_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.security_alert_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.security_alert_policy.storage_account.key].resource_group_name
}


resource "azurerm_mssql_server_security_alert_policy" "mssql" {
  count = try(var.settings.security_alert_policy, null) == null ? 0 : 1

  resource_group_name        = var.resource_group_name
  server_name                = azurerm_mssql_server.mssql.name
  state                      = try(var.settings.state, "Enabled")
  storage_endpoint           = data.azurerm_storage_account.mssql_security_alert.0.primary_blob_endpoint
  storage_account_access_key = data.azurerm_storage_account.mssql_security_alert.0.primary_access_key
  disabled_alerts            = try(var.settings.disabled_alerts, null)
  email_account_admins       = try(var.settings.email_subscription_admins, false)
  email_addresses            = try(var.settings.email_addresses, null)
  retention_days             = try(var.settings.retention_days, 0)
}

# Server vulnerability assessment

data "azurerm_storage_account" "mssql_va" {
  count = try(var.settings.security_alert_policy.vulnerability_assessment.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.security_alert_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.security_alert_policy.storage_account.key].resource_group_name
}

resource "azurerm_mssql_server_vulnerability_assessment" "mssql" {
  count = try(var.settings.security_alert_policy.vulnerability_assessment, null) == null ? 0 : 1

  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.mssql.0.id
  storage_container_path          = format("%s%s/", data.azurerm_storage_account.mssql_va.0.primary_blob_endpoint, try(var.settings.security_alert_policy.vulnerability_assessment.storage_account.container_path, "vascans"))
  storage_account_access_key      = data.azurerm_storage_account.mssql_va.0.primary_access_key
  recurring_scans {
    enabled                   = try(var.settings.security_alert_policy.vulnerability_assessment.enabled, true)
    email_subscription_admins = try(var.settings.security_alert_policy.vulnerability_assessment.email_subscription_admins, false)
    emails                    = try(var.settings.security_alert_policy.vulnerability_assessment.email_addresses, null)
  }
}

# #
# # Private endpoint
# #

# module private_endpoint {
#   source   = "./modules/networking/private_endpoint"
#   for_each = {
#     for key, sql_server in local.database.mssql_servers : key => sql_server
#     if try(sql_server.private_endpoints, null) != null
#   }

#   resource_id         = azurerm_mssql_server.mssql[each.key].id
#   name                = format("%s-to-%s-%s", var.settings.private_endpoints.name, var.settings.private_endpoints.vnet_key, var.settings.private_endpoints.subnet_key)
#   location            = var.resource_groups[var.settings.private_endpoints.resource_group_key].location
#   resource_group_name = var.resource_groups[var.settings.private_endpoints.resource_group_key].name
#   subnet_id           = var.vnets[var.settings.vnet_key].subnets[var.settings.subnet_key].id
#   settings            = var.settings
# }