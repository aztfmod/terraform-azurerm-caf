resource "azurecaf_name" "manageddb" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azapi_resource" "manageddb" {
  type      = "Microsoft.Resources/deployments@2021-04-01"
  name      = format("manageddb-%s", azurecaf_name.manageddb.result)
  parent_id = var.resource_group_id
  tags      = local.tags
  body = jsonencode(
    {
      properties = {
        mode     = "Incremental"
        template = jsondecode(file(local.arm_filename))
        parameters = {
          serverName = {
            value = var.server_name
          }
          dbName = {
            value = azurecaf_name.manageddb.result
          }
          location = {
            value = var.location
          }
          collation = {
            value = try(var.settings.collation, "SQL_Latin1_General_CP1_CI_AS")
          }
          createMode = {
            value = try(var.settings.createMode, "Default")
          }
          sourceDatabaseId = {
            value = var.sourceDatabaseId
          }
          restorePointInTime = {
            value = try(var.settings.createMode, null) == "PointInTimeRestore" ? var.settings.restorePointInTime : ""
          }
          longTermRetentionBackupResourceId = {
            value = try(var.settings.longTermRetentionBackupResourceId, "")
          }
          retentionDays = {
            value = try(var.settings.retentionDays, 7)
          }
          tags = {
            value = local.tags
          }
        }
      }
    }
  )

  schema_validation_enabled = false
  response_export_values    = ["properties.outputs"]

  provisioner "local-exec" {
    when       = destroy
    on_failure = fail
    command = format(
      "az rest --method delete --url https://management.azure.com%s?api-version=2021-11-01",
      jsondecode(self.output).properties.outputs.id.value
    )
  }
}