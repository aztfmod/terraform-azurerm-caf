data "azurecaf_name" "mssqlmi" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_mi"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_mssql_managed_instance" "mssqlmi" {
  administrator_login            = try(var.settings.administrator_login, null)
  administrator_login_password   = try(var.settings.administrator_login_password, random_password.sqlmi_admin.0.result)
  collation                      = try(var.settings.collation, null)
  dns_zone_partner_id            = can(var.primary_server_id != null) ? var.primary_server_id : null
  license_type                   = try(module.var_settings.license_type, "BasePrice")
  location                       = local.location
  maintenance_configuration_name = try(var.settings.maintenance_configuration_name, null)
  minimum_tls_version            = try(var.settings.minimal_tls_version, null)
  name                           = data.azurecaf_name.mssqlmi.result
  public_data_endpoint_enabled   = try(var.settings.public_data_endpoint_enabled, null)
  proxy_override                 = try(module.var_settings.proxy_override, null)
  resource_group_name            = local.resource_group_name
  sku_name                       = module.var_settings.sku_name
  storage_account_type           = var.settings.backup_storage_redundancy
  storage_size_in_gb             = try(var.settings.storage_size_in_gb, null)
  subnet_id                      = var.subnet_id
  tags                           = local.tags
  timezone_id                    = try(var.settings.timezone_id, "UTC")
  vcores                         = module.var_settings.vcores

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = module.var_identity.0.type
      identity_ids = local.managed_identities
    }
  }



  lifecycle {
    ignore_changes = [
      name
    ]
  }

}

module "var_settings" {

  source = "./var/settings"

  vcores                    = try(var.settings.vcores, null)
  sku_name                  = try(var.settings.sku.name, null)
  minimal_tls_version       = try(var.settings.minimal_tls_version, null)
  backup_storage_redundancy = try(var.settings.backup_storage_redundancy, null)
  storage_size_in_gb        = try(var.settings.storage_size_in_gb, null)
  license_type              = try(var.settings.license_type, null)
  proxy_override            = try(var.settings.proxy_override, null)
  authentication_mode       = try(var.settings.authentication_mode, null)
  identity                  = try(var.settings.identity, null)
}

module "var_identity" {
  source = "./var/identity"
  count  = can(var.settings.identity) ? 1 : 0

  type = module.var_settings.identity.type
}

module "var_login" {
  source                       = "./var/login"
  administrator_login          = var.settings.administrator_login
  administrator_login_password = can(var.settings.administrator_login_password) ? var.settings.administrator_login_password : random_password.sqlmi_admin.0.result
  keyvault                     = var.settings.keyvault
}

# Generate sql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "sqlmi_admin" {
  count = can(var.settings.administrator_login_password) ? 0 : 1

  length           = 128
  special          = true
  upper            = true
  numeric          = true
  override_special = "$#%"

}

# Create the random password in the keyvault if not provided in the attribute administrator_login_password
# in the same subscription as the sql server
resource "azurerm_key_vault_secret" "sqlmi_admin_password" {
  count        = can(var.settings.administrator_login_password) ? 0 : 1
  name         = format("%s-password", azurerm_mssql_managed_instance.mssqlmi.name)
  value        = random_password.sqlmi_admin.0.result
  key_vault_id = var.keyvault.id
  tags         = local.tags

  lifecycle {
    replace_triggered_by = [
      random_password.sqlmi_admin.0.id
    ]
  }
}

# to support keyvault in a different subscription -
# Need to revert to azurerm as azpi does not support delete secret when soft-delete is enabled
#

locals {
  dns_zone_id = split(".", azurerm_mssql_managed_instance.mssqlmi.fqdn)[1]

}