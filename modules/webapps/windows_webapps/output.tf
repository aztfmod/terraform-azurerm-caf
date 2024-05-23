output "id" {
  value       = azurerm_windows_web_app.windows_web_apps.id
  description = "The ID of the App Service."
}
output "default_hostname" {
  value       = azurerm_windows_web_app.windows_web_apps.default_hostname 
  description = "The Default Hostname associated with the Linux Web App"
}
output "outbound_ip_addresses" {
  value       = azurerm_windows_web_app.windows_web_apps.outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses"
}
output "possible_outbound_ip_addresses" {
  value       = azurerm_windows_web_app.windows_web_apps.possible_outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses. not all of which are necessarily in use"
}
output "identity" {
  value       = try(azurerm_windows_web_app.windows_web_apps.identity.0.principal_id, null)
  description = "The identity id of the windows web app."
}