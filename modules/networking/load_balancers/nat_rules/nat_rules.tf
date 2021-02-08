resource "azurerm_lb_nat_rule" "nat_rule" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = var.loadbalancer_id
  name                           = var.settings.name
  protocol                       = var.settings.protocol
  frontend_port                  = var.settings.frontend_port
  backend_port                   = var.settings.backend_port
  frontend_ip_configuration_name = var.settings.frontend_ip_configuration_name
  idle_timeout_in_minutes        = try(var.settings.idle_timeout_in_minutes, null)
  enable_floating_ip             = try(var.settings.enable_floating_ip, null)
  enable_tcp_reset               = try(var.settings.enable_tcp_reset, null)
}