output "id" {
  value       = azurerm_lb.lb.id
  description = "The Load Balancer ID."
}
output "frontend_ip_configuration" {
  value       = azurerm_lb.lb.frontend_ip_configuration
  description = "A `frontend_ip_configuration` block as documented below."
}
output "private_ip_address" {
  value       = azurerm_lb.lb.private_ip_address
  description = "The first private IP address assigned to the load balancer in `frontend_ip_configuration` blocks, if any."
}
output "private_ip_addresses" {
  value       = azurerm_lb.lb.private_ip_addresses
  description = "The list of private IP address assigned to the load balancer in `frontend_ip_configuration` blocks, if any."
}
