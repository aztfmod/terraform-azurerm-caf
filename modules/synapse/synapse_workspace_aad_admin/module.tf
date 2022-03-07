resource "azurerm_synapse_workspace_aad_admin" "sywsaa" {
  synapse_workspace_id = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  login                = var.settings.login
  object_id            = var.settings.object_id
  tenant_id            = var.settings.tenant_id
}