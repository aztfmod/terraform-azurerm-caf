output "id" {
  value       = azurerm_logic_app_standard.logic_app.id
  description = "The ID of the App Service."
}
output default_hostname {
 value       = azurerm_logic_app_standard.logic_app.default_hostname
 description = "The Default Hostname associated with the App Service"
}
output "outbound_ip_addresses" {
  value       = azurerm_logic_app_standard.logic_app.outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses"
}
output "possible_outbound_ip_addresses" {
  value       = azurerm_logic_app_standard.logic_app.possible_outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses. not all of which are necessarily in use"
}
