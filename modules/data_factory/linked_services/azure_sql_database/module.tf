resource "azurecaf_name" "dataset" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_linked_service_azure_file_storage"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_linked_service_azure_sql_database" "linked_service_azure_sql_database" {
  name                     = azurecaf_name.dataset.name
  resource_group_name      = var.resource_group_name
  data_factory_id          = var.data_factory_id
  description              = try(var.description, null)
  integration_runtime_name = try(var.integration_runtime_name, null)
  annotations              = try(var.annotations, null)
  parameters               = try(var.parameters, null)
  additional_properties    = try(var.additional_properties, null)
  connection_string        = var.connection_string
}