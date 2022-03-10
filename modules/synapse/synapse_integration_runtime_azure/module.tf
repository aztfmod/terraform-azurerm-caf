
resource "azurecaf_name" "syira" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_integration_runtime_azure"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_integration_runtime_azure" "syira" {
  name                 = azurecaf_name.syira.result
  synapse_workspace_id = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  location             = var.global_settings.regions[var.settings.location]
  compute_type         = try(var.settings.compute_type, null)
  core_count           = try(var.settings.core_count, null)
  description          = try(var.settings.description, null)
  time_to_live_min     = try(var.settings.time_to_live_min, null)
}