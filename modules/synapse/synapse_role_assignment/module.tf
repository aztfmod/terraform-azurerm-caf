resource "azurerm_synapse_role_assignment" "syra" {
  synapse_workspace_id  = can(var.settings.synapse_workspace.key) == false ? try(var.settings.synapse_workspace.id, null) : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  synapse_spark_pool_id = can(var.settings.synapse_spark_pool.key) == false ? try(var.settings.synapse_spark_pool.id, null) : var.remote_objects.synapse_spark_pool[try(var.settings.synapse_spark_pool.lz_key, var.client_config.landingzone_key)][var.settings.synapse_spark_pool.key].id
  role_name             = var.settings.role_name
  principal_id          = can(var.settings.target_resource.id) ? var.settings.target_resource_id : var.remote_objects.all[var.settings.principal.type][try(var.settings.principal.lz_key, var.client_config.landingzone_key)][var.settings.principal.key].id
} 