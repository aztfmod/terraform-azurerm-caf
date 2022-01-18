

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
  name                = azurecaf_name.lb.result
  resource_group_name = var.resource_group_name
  loadbalancer_id = coalesce(
    try(var.remote_objects.lb[var.settings.loadbalancer.lz_key][var.settings.loadbalancer.key].id, null),
    try(var.remote_objects.lb[var.client_config.landingzone_key][var.settings.loadbalancer.key].id, null),
    try(var.settings.loadbalancer.id, null)
  )
  frontend_ip_configuration_name = var.settings.frontend_ip_configuration_name
  protocol                       = var.settings.protocol
  frontend_port_start            = var.settings.frontend_port_start
  frontend_port_end              = var.settings.frontend_port_end
  backend_port                   = var.settings.backend_port
  idle_timeout_in_minutes        = try(var.settings.idle_timeout_in_minutes, null)
  floating_ip_enabled            = try(var.settings.floating_ip_enabled, null)
  tcp_reset_enabled              = try(var.settings.tcp_reset_enabled, null)
}