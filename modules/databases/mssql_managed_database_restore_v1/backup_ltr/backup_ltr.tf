#create longterm retention if the create_mode is default or if inherit retention settings from source is not true
resource "azapi_update_resource" "longtermretention" {
  type      = "Microsoft.Sql/managedInstances/databases/backupLongTermRetentionPolicies@2021-11-01"
  name      = "default"
  parent_id = var.db_id
  body = jsonencode({
    properties = {
      weeklyRetention  = local.settings.ltr_settings.weekly_retention
      monthlyRetention = local.settings.ltr_settings.monthly_retention
      yearlyRetention  = local.settings.ltr_settings.yearly_retention
      weekOfYear       = local.settings.ltr_settings.week_of_year

    }
  })
}





