output "id" {
  value       = azurerm_app_service.app_service.id
  description = "The ID of the App Service."
}
output "default_site_hostname" {
  value       = azurerm_app_service.app_service.default_site_hostname
  description = "The Default Hostname associated with the App Service"
}
output "outbound_ip_addresses" {
  value       = azurerm_app_service.app_service.outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses"
}
output "possible_outbound_ip_addresses" {
  value       = azurerm_app_service.app_service.possible_outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses. not all of which are necessarily in use"
}
output "rbac_id" {
  value       = try(azurerm_app_service.app_service.identity.0.principal_id, null)
  description = "The Principal ID of the App Service."
}
output "slot" {
  value = {
    for key, value in try(var.slots, {}) : key => {
      id = azurerm_app_service_slot.slots[key].id
    }
  }
}