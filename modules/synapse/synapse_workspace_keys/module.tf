resource "azurerm_synapse_workspace_key" "sywsk" {
  customer_managed_key_name           = var.settings.customer_managed_key_name
  customer_managed_key_versionless_id = var.settings.customer_managed_key_versionless_id
  synapse_workspace_id                = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  active                              = var.settings.active
}