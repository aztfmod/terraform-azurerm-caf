resource "azurecaf_name" "schedule" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_pipeline"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_data_factory_trigger_schedule" "schedule" {
  name                = azurecaf_name.schedule.name
  resource_group_name = var.resource_group_name
  data_factory_name   = var.data_factory_name
  pipeline_name       = var.pipeline_name
  start_time          = try(var.settings.start_time, null)
  end_time            = try(var.settings.end_time, null)
  interval            = try(var.settings.interval, null)
  frequency           = try(var.settings.frequency, null)
  pipeline_parameters = try(var.settings.pipeline_parameters, null)
  annotations         = try(var.settings.annotations, null)
}
