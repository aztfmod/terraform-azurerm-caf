output "id" {
  value = azurerm_lb.lb.id
}

output "private_ip_addresses" {
  value       = azurerm_lb.lb.private_ip_addresses
  description = "The list of private IP address assigned to the load balancer in frontend_ip_configuration blocks, if any"
}

output "private_ip_address" {
  value       = azurerm_lb.lb.private_ip_address
  description = "The first private IP address assigned to the load balancer in frontend_ip_configuration"
}

output "frontend_ip_configuration" {
  value = azurerm_lb.lb.frontend_ip_configuration
}

output "bap" {
  value = {
    for backend_address_pool_name, value in var.settings : backend_address_pool_name => {
      id   = azurerm_lb_backend_address_pool.backend_address_pool.0.id
      name = azurerm_lb_backend_address_pool.backend_address_pool.0.name
    }
  }
}

output "backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.backend_address_pool.0.id
}

output "probes" {
  value = azurerm_lb_probe.lb_probe
}
