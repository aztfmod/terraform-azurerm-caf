resource "azapi_update_resource" "backupltr" {
  type      = "Microsoft.Sql/managedInstances/databases/backupLongTermRetentionPolicies@2021-11-01"
  name      = "default"
  parent_id = var.database_id

  body = jsonencode(
    {
      properties = {
        monthlyRetention = try(var.settings.monthlyRetention, "")
        weeklyRetention  = try(var.settings.weeklyRetention, "")
        weekOfYear       = try(var.settings.weekOfYear, 0)
        yearlyRetention  = try(var.settings.yearlyRetention, "")
      }
    }
  )
}