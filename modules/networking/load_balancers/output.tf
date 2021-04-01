output "id" {
  value = azurerm_lb.lb.id
}

output "bap" {
  value = {
    for backend_address_pool_name, value in var.settings : backend_address_pool_name => {
      id   = azurerm_lb_backend_address_pool.backend_address_pool.0.id
      name = azurerm_lb_backend_address_pool.backend_address_pool.0.name
    }
  }