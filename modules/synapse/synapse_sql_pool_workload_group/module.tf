
resource "azurecaf_name" "syspwg" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_sql_pool_workload_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_sql_pool_workload_group" "syspwg" {
  name                               = azurecaf_name.syspwg.result
  sql_pool_id                        = can(var.settings.sql_pool.id) ? var.settings.sql_pool.id : var.remote_objects.sql_pool[try(var.settings.sql_pool.lz_key, var.client_config.landingzone_key)][var.settings.sql_pool.key].id
  max_resource_percent               = var.settings.max_resource_percent
  min_resource_percent               = var.settings.min_resource_percent
  importance                         = try(var.settings.importance, null)
  max_resource_percent_per_request   = try(var.settings.max_resource_percent_per_request, null)
  min_resource_percent_per_request   = try(var.settings.min_resource_percent_per_request, null)
  query_execution_timeout_in_seconds = try(var.settings.query_execution_timeout_in_seconds, null)
}