data "azurecaf_name" "mssqlmi" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_mi"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

# resource "azapi_resource" "mssqlmi" {

#   name = data.azurecaf_name.mssqlmi.result

#   parent_id = var.resource_group_id
#   location  = var.location
#   type      = "Microsoft.Sql/managedInstances@2022-08-01-preview"
#   #tags = local.tags
#   body = jsonencode({
#     sku        = local.sku
#     properties =  {

#       administratorLogin               = try(var.settings.administrator_login,null)
#       administratorLoginPassword       = try(var.settings.administrator_login_password, data.external.sqlmi_admin_password.0.result.value)
#       administrators                   = try(local.administrators,null)
#       collation                        = try(var.settings.collation, null)
#       licenseType                      = try(var.settings.license_type, "BasePrice")
#       minimalTlsVersion                = try(var.settings.minimal_tls_version, null)
#       proxyOverride                    = try(var.settings.proxy_override, "Redirect")
#       publicDataEndpointEnabled        = try(var.settings.public_data_endpoint_enabled, null)
#       subnetId                         = var.subnet_id
#       timezoneId                       = try(var.settings.timezone_id, "UTC")
#       vCores                           = var.settings.vcores
#       storageSizeInGB                  = try(var.settings.storage_size_in_gb, null)
#       requestedBackupStorageRedundancy = var.settings.backup_storage_redundancy
#       authentication_mode               = var.settings.authentication_mode
#     }
#   })

#   timeouts {
#     create = "10h"
#     update = "10h"
#     delete = "10h"
#     read   = "5m"
#   }

# }

resource "azurerm_mssql_managed_instance" "mssqlmi" {
  name                         = data.azurecaf_name.mssqlmi.result
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = try(var.settings.administrator_login, null)
  administrator_login_password = try(var.settings.administrator_login_password, data.external.sqlmi_admin_password.0.result.value)

  license_type         = try(var.settings.license_type, "BasePrice")
  subnet_id            = var.subnet_id
  sku_name             = local.sku.name
  vcores               = var.settings.vcores
  storage_size_in_gb   = try(var.settings.storage_size_in_gb, null)
  minimum_tls_version  = try(var.settings.minimal_tls_version, null)
  timezone_id          = try(var.settings.timezone_id, "UTC")
  storage_account_type = var.settings.backup_storage_redundancy

  # depends_on = [
  #   azurerm_subnet_network_security_group_association.example,
  #   azurerm_subnet_route_table_association.example,
  # ]
}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "aadadmin" {
  count                       = var.settings.authentication_mode != "sql_only" ? 1 : 0
  managed_instance_id         = azurerm_mssql_managed_instance.mssqlmi.id
  login_username              = var.settings.administrators.login
  object_id                   = var.settings.administrators.sid
  tenant_id                   = var.settings.administrators.tenantId
  azuread_authentication_only = var.settings.authentication_mode == "aad_only" ? true : false
}

module "var_settings" {
  source = "./var/settings"

  vcores                    = try(var.settings.vcores, null)
  sku                       = try(var.settings.sku, null)
  minimal_tls_version       = try(var.settings.minimal_tls_version, null)
  backup_storage_redundancy = try(var.settings.backup_storage_redundancy, null)
  storage_size_in_gb        = try(var.settings.storage_size_in_gb, null)
  license_type              = try(var.settings.license_type, null)
  proxy_override            = try(var.settings.proxy_override, null)
  administrators            = try(var.settings.administrators, null)
  authentication_mode       = try(var.settings.authentication_mode, null)
}

locals {
  sku = {
    name = module.var_sku.name
  }
}

module "var_sku" {
  source = "./var/sku"

  name = module.var_settings.sku.name
}

module "var_admin" {
  source = "./var/admin"
  count  = var.settings.authentication_mode != "sql_only" ? 1 : 0
  #principal_type = var.settings.authentication_mode != "sql_only" ? module.var_settings.administrators.principal_type : null
  principal_type = module.var_settings.administrators.principal_type
}

locals {

  administrators = var.settings.authentication_mode != "sql_only" ? {

    administratorType         = "ActiveDirectory"
    azureADOnlyAuthentication = var.settings.authentication_mode != "aad_only" ? true : false
    login                     = var.settings.administrators.login
    principalType             = var.settings.administrators.principal_type
    sid                       = var.settings.administrators.sid
    tenantId                  = var.settings.administrators.tenantId
  } : null
}

module "var_login" {
  source = "./var/login"
  #count                        = var.settings.authentication_mode != "aad_only" ? 1 : 0
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
#to support keyvault in a different subscription
resource "azapi_resource" "sqlmi_admin_password" {
  count = (can(var.settings.administrator_login_password)) ? 0 : 1

  type      = "Microsoft.KeyVault/vaults/secrets@2022-07-01"
  name      = format("%s-password-v1", data.azurecaf_name.mssqlmi.result)
  parent_id = var.keyvault.id

  body = jsonencode({
    properties = {
      attributes = {
        enabled = true
      }
      value = random_password.sqlmi_admin.0.result
    }
  })

  ignore_missing_property = true
}

# data "external" "sqlmi_admin_password" {
#   count      = try(var.settings.administrator_login_password, null) == null ? 1 : 0
#   depends_on = [azapi_resource.sqlmi_admin_password]
#   program = [
#     "bash", "-c",
#     format(
#       "az keyvault secret show -n '%s' --vault-name '%s' --query '{value: value }' -o json",
#       format("%s-password-v1", data.azurecaf_name.mssqlmi.result),
#       var.keyvault.name
#     )
#   ]
# }

data "external" "sqlmi_admin_password" {
  count      = can(var.settings.administrator_login_password) ? 0 : 1
  depends_on = [azapi_resource.sqlmi_admin_password]
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show -n '%s' --vault-name '%s' --query '{value: value }' -o json",
      format("%s-password-v1", data.azurecaf_name.mssqlmi.result),
      var.keyvault.name
    )
  ]
}



# resource "azurerm_key_vault_secret" "sqlmi_admin_password" {
#   count = 0

#   name         = format("%s-password", var.settings.name)
#   value        = random_password.sqlmi_admin.0.result
#   key_vault_id = var.keyvault.id

#   lifecycle {
#     ignore_changes = [
#       value
#     ]
#   }
# }



