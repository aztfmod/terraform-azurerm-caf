output "id" {
  value       = azurerm_api_management_api.apim.id
  description = "The ID of the API Management API."
}
output "is_current" {
  value       = azurerm_api_management_api.apim.is_current
  description = "Is this the current API Revision?"
}
output "is_online" {
  value       = azurerm_api_management_api.apim.is_online
  description = "Is this API Revision online/accessible via the Gateway?"
}
output "version" {
  value       = azurerm_api_management_api.apim.version
  description = "The Version number of this API, if this API is versioned."
}
output "version_set_id" {
  value       = azurerm_api_management_api.apim.version_set_id
  description = "The ID of the Version Set which this API is associated with."
}
output "name" {
  value       = azurerm_api_management_api.apim.name
  description = "The name of the API Management API."
}