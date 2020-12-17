resource "azurerm_data_factory_trigger_schedule" "schedule" {
  name                = var.name
  resource_group_name = var.resource_group_name
  data_factory_name   = var.data_factory_name
  pipeline_name       = var.pipeline_name
  start_time          = try(var.start_time, null)
  end_time            = try(var.end_time, null)
  interval            = try(var.interval, null)
  frequency           = try(var.frequency, null)
  pipeline_parameters = try(var.pipeline_parameters, null)
  annotations         = try(var.annotations, null)
}
