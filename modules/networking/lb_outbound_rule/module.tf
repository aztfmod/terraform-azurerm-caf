

resource "azurecaf_name" "lb" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_lb_outbound_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_lb_outbound_rule" "lb" {
  allocated_outbound_ports = try(var.settings.allocated_outbound_ports, null)
  backend_address_pool_id  = can(var.settings.backend_address_pool.id) || can(var.settings.backend_address_pool.key) ? try(var.settings.backend_address_pool.id, var.remote_objects.lb_backend_address_pool[try(var.settings.backend_address_pool.lz_key, var.client_config.landingzone_key)][var.settings.backend_address_pool.key].id) : null
  enable_tcp_reset         = try(var.settings.enable_tcp_reset, null)
  idle_timeout_in_minutes  = try(var.settings.idle_timeout_in_minutes, null)
  loadbalancer_id          = can(var.settings.loadbalancer.id) || can(var.settings.loadbalancer.key) ? try(var.settings.loadbalancer.id, var.remote_objects.lb[try(var.settings.loadbalancer.lz_key, var.client_config.landingzone_key)][var.settings.loadbalancer.key].id) : null
  name                     = azurecaf_name.lb.result
  protocol                 = var.settings.protocol

  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend_ip_configuration, null) != null ? [var.settings.frontend_ip_configuration] : []
    content {
      name = try(frontend_ip_configuration.value.name, null)
    }
  }

}