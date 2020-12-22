resource "azurerm_data_factory_pipeline" "pipeline" {
  name                = var.name
  resource_group_name = var.resource_group_name
  data_factory_name   = var.data_factory_name
  description         = try(var.description, null)
  annotations         = try(var.annotations, null)
  parameters          = try(var.parameters, null)
  variables           = try(var.variables, null)
  activities_json     = try(var.activities_json, null)
}