resource "azurecaf_name" "pipeline" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_pipeline"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_pipeline" "pipeline" {
  name                           = azurecaf_name.pipeline.result
  resource_group_name            = var.resource_group_name
  data_factory_name              = var.data_factory_name
  description                    = try(var.settings.description, null)
  annotations                    = try(var.settings.annotations, null)
  concurrency                    = try(var.settings.concurrency, null)
  folder                         = try(var.settings.folder, null)
  moniter_metrics_after_duration = try(var.settings.moniter_metrics_after_duration, null)
  parameters                     = try(var.settings.parameters, null)
  variables                      = try(var.settings.variables, null)
  activities_json                = try(var.settings.activities_json, null)
}