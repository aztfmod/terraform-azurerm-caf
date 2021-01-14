resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "linked_service_data_lake_storage_gen2" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  data_factory_name        = var.data_factory_name
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