

resource "azurecaf_name" "lb" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_lb_backend_address_pool"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_lb_backend_address_pool" "lb" {
  name = azurecaf_name.lb.result
  loadbalancer_id = coalesce(
    try(var.remote_objects.lb[var.settings.loadbalancer.lz_key][var.settings.loadbalancer.key].id, null),
    try(var.remote_objects.lb[var.client_config.landingzone_key][var.settings.loadbalancer.key].id, null),
    try(var.settings.loadbalancer.id, null)
  )
  dynamic "tunnel_interface" {
    for_each = try(var.settings.tunnel_interface, null) != null ? [var.settings.tunnel_interface] : []
    content {
      identifier = try(tunnel_interface.value.identifier, null)
      type       = try(tunnel_interface.value.type, null)
      protocol   = try(tunnel_interface.value.protocol, null)
      port       = try(tunnel_interface.value.port, null)
    }
  }
}