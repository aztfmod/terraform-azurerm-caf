output "id" {
  value       = azurerm_lb_backend_address_pool.lb.id
  description = "The ID of the Backend Address Pool."
}
output "backend_ip_configurations" {
  value       = azurerm_lb_backend_address_pool.lb.backend_ip_configurations
  description = "The Backend IP Configurations associated with this Backend Address Pool."
}
output "load_balancing_rules" {
  value       = azurerm_lb_backend_address_pool.lb.load_balancing_rules
  description = "The Load Balancing Rules associated with this Backend Address Pool."
}
output "outbound_rules" {
  value       = azurerm_lb_backend_address_pool.lb.outbound_rules
  description = "An array of the Load Balancing Outbound Rules associated with this Backend Address Pool."
}
