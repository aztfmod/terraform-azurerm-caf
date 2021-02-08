resource "azurerm_lb_outbound_rule" "outbound_rule" {
  resource_group_name     = var.resource_group_name
  loadbalancer_id         = var.loadbalancer_id
  name                    = var.settings.name
  protocol                = var.settings.protocol
  backend_address_pool_id = var.backend_address_pool_id
  enable_tcp_reset        = try(var.settings.enable_tcp_reset, {})
  allocated_outbound_ports  = try(var.settings.allocated_outbound_ports, {})
  idle_timeout_in_minutes  = try(var.settings.idle_timeout_in_minutes, {})


  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend_ip_configuration, {})
    content {
      name = frontend_ip_configuration.value.name
    }
  }
}
