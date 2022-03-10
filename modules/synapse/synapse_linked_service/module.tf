resource "azurecaf_name" "syls" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_linked_service"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_linked_service" "syls" {
  name                  = azurecaf_name.syls.result
  synapse_workspace_id  = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  type                  = var.settings.type
  type_properties_json  = var.settings.type_properties_json
  additional_properties = try(var.settings.additional_properties, null)
  annotations           = try(var.settings.annotations, null)
  description           = try(var.settings.description, null)
  dynamic "integration_runtime" {
    for_each = try(var.settings.integration_runtime, null) != null ? [var.settings.integration_runtime] : []
    content {
      name       = try(integration_runtime.value.name, null)
      parameters = try(integration_runtime.value.parameters, null)
    }
  }
  parameters = try(var.settings.parameters, null)
}