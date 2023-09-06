resource "azurecaf_name" "manageddb" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_mssql_managed_database" "sqlmanageddatabase" {
  name                = azurecaf_name.manageddb.result
  managed_instance_id = var.server_id


  short_term_retention_days = module.var_settings.short_term_retention_days

  dynamic "long_term_retention_policy" {
    for_each = can(var.settings.long_term_retention_policy) ? [1] : []

    content {
      weekly_retention  = try(var.settings.long_term_retention_policy.weekly_retention, null)
      monthly_retention = try(var.settings.long_term_retention_policy.monthly_retention, null)
      yearly_retention  = try(var.settings.long_term_retention_policy.yearly_retention, null)
      week_of_year      = try(var.settings.long_term_retention_policy.week_of_year, null)
    }
  }

}

#module for variable validation
module "var_settings" {
  source                    = "./var/settings"
  short_term_retention_days = try(var.settings.short_term_retention_days, null)
}