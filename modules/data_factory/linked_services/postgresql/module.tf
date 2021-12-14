resource "azurecaf_name" "linked" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_linked_service_postgresql"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_linked_service_postgresql" "linked_service_postgresql" {
  name                     = azurecaf_name.linked.name
  resource_group_name      = var.resource_group_name
  data_factory_name        = var.data_factory_name
  description              = try(var.settings.description, null)
  integration_runtime_name = try(var.settings.integration_runtime_name, null)
  annotations              = try(var.settings.annotations, null)
  parameters               = try(var.settings.parameters, null)
  connection_string        = var.settings.connection_string
}