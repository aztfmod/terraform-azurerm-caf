resource "azurecaf_name" "linked" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_linked_service_key_vault"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_linked_service_key_vault" "linked_service_key_vault" {
  name                     = azurecaf_name.linked.name
  resource_group_name      = var.resource_group_name
  data_factory_id          = var.data_factory_id
  description              = var.description
  integration_runtime_name = var.integration_runtime_name
  annotations              = var.annotations
  parameters               = var.parameters
  additional_properties    = var.additional_properties
  key_vault_id             = var.key_vault_id
}