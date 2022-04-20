

resource "azurecaf_name" "lb" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_lb_probe"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_lb_probe" "lb" {
  name                = azurecaf_name.lb.result
  resource_group_name = var.resource_group_name
  loadbalancer_id     = can(var.settings.loadbalancer.id) ? var.settings.loadbalancer.id : var.remote_objects.lb[try(var.settings.loadbalancer.lz_key, var.client_config.landingzone_key)][var.settings.loadbalancer.key].id
  protocol            = try(var.settings.protocol, null)
  port                = var.settings.port
  request_path        = try(var.settings.request_path, null)
  interval_in_seconds = try(var.settings.interval_in_seconds, null)
  number_of_probes    = try(var.settings.number_of_probes, null)
}