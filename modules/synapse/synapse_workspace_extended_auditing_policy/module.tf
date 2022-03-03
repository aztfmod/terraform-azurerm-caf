resource "azurerm_synapse_workspace_extended_auditing_policy" "sywseap" {
  synapse_workspace_id                    = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  storage_endpoint                        = try(var.settings.storage_endpoint, null)
  retention_in_days                       = try(var.settings.retention_in_days, null)
  storage_account_access_key              = try(var.settings.storage_account_access_key, null)
  storage_account_access_key_is_secondary = try(var.settings.storage_account_access_key_is_secondary, null)
  log_monitoring_enabled                  = try(var.settings.log_monitoring_enabled, null)
}