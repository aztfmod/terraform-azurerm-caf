

resource "azurecaf_name" "lb" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_lb_backend_address_pool_address"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_lb_backend_address_pool_address" "lb" {
  backend_address_pool_id = coalesce(
    try(var.remote_objects.lb_backend_address_pool[var.settings.backend_address_pool.lz_key][var.settings.backend_address_pool.key].id, null),
    try(var.remote_objects.lb_backend_address_pool[var.client_config.landingzone_key][var.settings.backend_address_pool.key].id, null),
    try(var.settings.backend_address_pool.id, null)
  )
  ip_address = var.settings.ip_address
  name       = azurecaf_name.lb.result
  virtual_network_id = coalesce(
    try(var.remote_objects.virtual_network[var.settings.virtual_network.lz_key][var.settings.virtual_network.key].id, null),
    try(var.remote_objects.virtual_network[var.client_config.landingzone_key][var.settings.virtual_network.key].id, null),
    try(var.settings.virtual_network.id, null)
  )
}