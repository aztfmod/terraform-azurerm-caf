resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = var.loadbalancer_id
  name                = var.settings.backend_address_pool_name
}