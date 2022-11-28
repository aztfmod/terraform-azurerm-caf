resource "azurecaf_name" "mssqlmi" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_server" //TODO: add support for sql mi
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_template_deployment" "mssqlmi" {

  name                = azurecaf_name.mssqlmi.result
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)

  parameters_body = jsonencode(local.parameters_body)

  deployment_mode = "Incremental"

  timeouts {
    create = "10h"
    update = "10h"
    delete = "10h"
    read   = "5m"
  }
}

resource "null_resource" "destroy_sqlmi" {

  triggers = {
    resource_id = local.output.id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/destroy_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE_IDS = self.triggers.resource_id
    }
  }

}

# Generate sql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "sqlmi_admin" {
  count = try(var.settings.administratorLoginPassword, null) == null ? 1 : 0

  length           = 128
  special          = true
  upper            = true
  numeric          = true
  override_special = "$#%"
}

# Both (azapi_resource.azapi_resource) have to be kept to support transition to azapi. Will be removed in next release
# Store the generated password into keyvault
resource "azurerm_key_vault_secret" "sqlmi_admin_password" {
  count = 0

  name         = format("%s-password", azurecaf_name.mssqlmi.result)
  value        = random_password.sqlmi_admin.0.result
  key_vault_id = var.keyvault.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# to support keyvault in a different subscription
resource "azapi_resource" "sqlmi_admin_password" {
  count = try(var.settings.administratorLoginPassword, null) == null ? 1 : 0

  type      = "Microsoft.KeyVault/vaults/secrets@2021-11-01-preview"
  name      = format("%s-password-v1", azurecaf_name.mssqlmi.result)
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

data "external" "sqlmi_admin_password" {
  count      = try(var.settings.administratorLoginPassword, null) == null ? 1 : 0
  depends_on = [azapi_resource.sqlmi_admin_password]
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show -n '%s' --vault-name '%s' --query '{value: value }' -o json",
      format("%s-password-v1", azurecaf_name.mssqlmi.result),
      var.keyvault.name
    )
  ]
}

data "azapi_resource" "mssqlmi" {
  name      = azurecaf_name.mssqlmi.result
  parent_id = local.parent_id
  type      = "Microsoft.Sql/managedInstances@2021-11-01-preview"
}

locals {
  parent_id = format("/subscriptions/%s/resourceGroups/%s", var.client_config.subscription_id, var.resource_group_name)
  output = {
    id           = data.azapi_resource.mssqlmi.id
    principal_id = try(data.azapi_resource.mssqlmi.identity[0].principal_id, null)
  }
}