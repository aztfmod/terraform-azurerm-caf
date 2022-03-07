resource "azurerm_synapse_workspace_security_alert_policy" "sywssap" {
  synapse_workspace_id         = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  policy_state                 = var.settings.policy_state
  disabled_alerts              = try(var.settings.disabled_alerts, null)
  email_account_admins_enabled = try(var.settings.email_account_admins_enabled, null)
  email_addresses              = try(var.settings.email_addresses, null)
  retention_days               = try(var.settings.retention_days, null)
  storage_account_access_key   = try(var.settings.storage_account_access_key, null)
  storage_endpoint             = try(var.settings.storage_endpoint, null)
}