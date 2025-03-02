

resource "azurecaf_name" "lb" {
  name          = var.settings.name
  resource_type = "azurerm_lb_nat_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_lb_nat_rule" "lb" {
  backend_port                   = var.settings.backend_port
  enable_floating_ip             = try(var.settings.enable_floating_ip, null)
  enable_tcp_reset               = try(var.settings.enable_tcp_reset, null)
  frontend_ip_configuration_name = var.settings.frontend_ip_configuration_name
  frontend_port                  = var.settings.frontend_port
  idle_timeout_in_minutes        = try(var.settings.idle_timeout_in_minutes, null)
  loadbalancer_id                = can(var.settings.loadbalancer.id) ? var.settings.loadbalancer.id : can(var.settings.loadbalancer.key) ? var.remote_objects.lb[try(var.settings.loadbalancer.lz_key, var.client_config.landingzone_key)][var.settings.loadbalancer.key].id : null
  name                           = azurecaf_name.lb.result
  protocol                       = var.settings.protocol
  resource_group_name            = var.resource_group_name
}
