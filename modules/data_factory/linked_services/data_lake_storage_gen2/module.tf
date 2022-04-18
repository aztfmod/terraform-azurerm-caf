resource "azurecaf_name" "linked" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_linked_service_data_lake_storage_gen2"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "linked_service_data_lake_storage_gen2" {
  name                     = azurecaf_name.linked.name
  resource_group_name      = var.resource_group_name
  data_factory_id          = var.data_factory_id
  description              = try(var.description, null)
  integration_runtime_name = try(var.integration_runtime_name, null)
  annotations              = try(var.annotations, null)
  parameters               = try(var.parameters, null)
  additional_properties    = try(var.additional_properties, null)
  url                      = var.url
  use_managed_identity     = try(var.use_managed_identity, null)
  service_principal_id     = try(var.service_principal_id, null)
  service_principal_key    = try(var.service_principal_key, null)
  tenant                   = var.tenant
}