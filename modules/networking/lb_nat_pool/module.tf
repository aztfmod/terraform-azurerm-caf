

resource "azurecaf_name" "lb" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_lb_nat_pool"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_lb_nat_pool" "lb" {
  backend_port                   = var.settings.backend_port
  floating_ip_enabled            = try(var.settings.floating_ip_enabled, null)
  frontend_ip_configuration_name = var.settings.frontend_ip_configuration_name
  frontend_port_end              = var.settings.frontend_port_end
  frontend_port_start            = var.settings.frontend_port_start
  idle_timeout_in_minutes        = try(var.settings.idle_timeout_in_minutes, null)
  loadbalancer_id                = can(var.settings.loadbalancer.id) || can(var.settings.loadbalancer.key) ? try(var.settings.loadbalancer.id, var.remote_objects.lb[try(var.settings.loadbalancer.lz_key, var.client_config.landingzone_key)][var.settings.loadbalancer.key].id) : null
  name                           = azurecaf_name.lb.result
  protocol                       = var.settings.protocol
  resource_group_name            = var.resource_group_name
  tcp_reset_enabled              = try(var.settings.tcp_reset_enabled, null)
}