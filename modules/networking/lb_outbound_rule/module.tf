

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
  name                = azurecaf_name.lb.result
  resource_group_name = var.resource_group_name
  loadbalancer_id = coalesce(
    try(var.remote_objects.lb[var.settings.loadbalancer.lz_key][var.settings.loadbalancer.key].id, null),
    try(var.remote_objects.lb[var.client_config.landingzone_key][var.settings.loadbalancer.key].id, null),
    try(var.settings.loadbalancer.id, null)
  )
  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend_ip_configuration, null) != null ? [var.settings.frontend_ip_configuration] : []
    content {
      name = try(frontend_ip_configuration.value.name, null)
    }
  }
  backend_address_pool_id = coalesce(
    try(var.remote_objects.lb_backend_address_pool[var.settings.backend_address_pool.lz_key][var.settings.backend_address_pool.key].id, null),
    try(var.remote_objects.lb_backend_address_pool[var.client_config.landingzone_key][var.settings.backend_address_pool.key].id, null),
    try(var.settings.backend_address_pool.id, null)
  )
  protocol                 = var.settings.protocol
  enable_tcp_reset         = try(var.settings.enable_tcp_reset, null)
  allocated_outbound_ports = try(var.settings.allocated_outbound_ports, null)
  idle_timeout_in_minutes  = try(var.settings.idle_timeout_in_minutes, null)
}