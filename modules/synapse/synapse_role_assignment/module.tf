resource "azurerm_synapse_role_assignment" "syra" {
  synapse_workspace_id  = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  synapse_spark_pool_id = can(var.settings.synapse_spark_pool.id) ? var.settings.synapse_spark_pool.id : var.remote_objects.synapse_spark_pool[try(var.settings.synapse_spark_pool.lz_key, var.client_config.landingzone_key)][var.settings.synapse_spark_pool.key].id
  role_name             = var.settings.role_name
  principal_id          = var.settings.principal_id
}