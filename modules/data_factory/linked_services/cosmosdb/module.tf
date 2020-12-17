resource "azurerm_data_factory_linked_service_cosmosdb" "linked_service_cosmosdb" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  data_factory_name        = var.data_factory_name
  description              = try(var.description, null)
  integration_runtime_name = try(var.integration_runtime_name, null)
  annotations              = try(var.annotations, null)
  parameters               = try(var.parameters, null)
  additional_properties    = try(var.additional_properties, null)
  account_endpoint         = try(var.account_endpoint, null)
  account_key              = try(var.account_key, null)
  database                 = try(var.database, null)
  connection_string        = try(var.connection_string, null)
}