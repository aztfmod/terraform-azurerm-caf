
resource "azurecaf_name" "syspc" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_sql_pool_workload_classifier"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_sql_pool_workload_classifier" "syspc" {
  name              = azurecaf_name.syspc.result
  workload_group_id = can(var.settings.workload_group.id) ? var.settings.workload_group.id : var.remote_objects.synapse_sql_pool_workload_group[try(var.settings.workload_group.lz_key, var.client_config.landingzone_key)][var.settings.workload_group.key].id
  member_name       = var.settings.member_name
  context           = try(var.settings.context, null)
  end_time          = try(var.settings.end_time, null)
  importance        = try(var.settings.importance, null)
  label             = try(var.settings.label, null)
  start_time        = try(var.settings.start_time, null)
}