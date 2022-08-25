output "id" {
  value       = azurerm_function_app.function_app.id
  description = "The ID of the App Service."
}
#output default_site_hostname {
#  value       = azurerm_function_app.function_app.default_site_hostname
#  description = "The Default Hostname associated with the App Service"
#}
output "outbound_ip_addresses" {
  value       = azurerm_function_app.function_app.outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses"
}
output "possible_outbound_ip_addresses" {
  value       = azurerm_function_app.function_app.possible_outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses. not all of which are necessarily in use"
}
