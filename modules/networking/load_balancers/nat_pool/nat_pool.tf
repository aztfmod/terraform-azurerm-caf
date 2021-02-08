resource "azurerm_lb_nat_pool" "nat_pool" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = var.loadbalancer_id
  name                           = var.settings.name
  protocol                       = var.settings.protocol
  frontend_port_start            = var.settings.frontend_port_end
  frontend_port_end              = var.settings.frontend_port_end
  backend_port                   = var.settings.backend_port
  frontend_ip_configuration_name = var.settings.frontend_ip_configuration
}