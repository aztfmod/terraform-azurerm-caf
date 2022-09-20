resource "azurecaf_name" "linked_service_cosmosdb" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_data_factory_dataset_azure_blob"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_linked_service_cosmosdb" "linked_service_cosmosdb" {
  name                     = azurecaf_name.linked_service_cosmosdb.result
  resource_group_name      = var.resource_group_name
  data_factory_id          = var.data_factory_id
  description              = try(var.settings.description, null)
  integration_runtime_name = try(var.settings.integration_runtime_name, null)
  annotations              = try(var.settings.annotations, null)
  parameters               = try(var.settings.parameters, null)
  additional_properties    = try(var.settings.additional_properties, null)
  account_endpoint         = try(var.account_endpoint, null)
  account_key              = try(var.account_key, null)
  database                 = try(var.settings.cosmosdb_account.database, null)
  connection_string        = try(var.settings.connection_string, null)
}