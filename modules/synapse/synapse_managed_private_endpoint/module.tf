
resource "azurecaf_name" "sympe" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_synapse_managed_private_endpoint"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_managed_private_endpoint" "sympe" {
  name                 = azurecaf_name.sympe.result
  synapse_workspace_id = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  target_resource_id   = var.settings.target_resource_id
  subresource_name     = var.settings.subresource_name
}