resource "azurerm_batch_job" "job" {
  name                          = var.settings.name
  batch_pool_id                 = var.batch_pool_id
  common_environment_properties = try(var.settings.common_environment_properties, null)
  display_name                  = try(var.settings.display_name, null)
  task_retry_maximum            = try(var.settings.task_retry_maximum, null)
  priority                      = try(var.settings.priority, null)
}
