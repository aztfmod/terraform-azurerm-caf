resource "azurecaf_name" "syfwe" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_firewall_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_firewall_rule" "syfwe" {
  name                 = azurecaf_name.syfwe.result
  synapse_workspace_id = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  start_ip_address     = var.settings.start_ip_address
  end_ip_address       = var.settings.end_ip_address
}