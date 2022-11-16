output "id" {
  value       = azurerm_api_management.apim.id
  description = "The ID of the API Management Service."
}
output "additional_location" {
  value       = azurerm_api_management.apim.additional_location
  description = "Zero or more `additional_location` blocks as documented below."
}
output "gateway_url" {
  value       = azurerm_api_management.apim.gateway_url
  description = "The URL of the Gateway for the API Management Service."
}
output "gateway_regional_url" {
  value       = azurerm_api_management.apim.gateway_regional_url
  description = "The Region URL for the Gateway of the API Management Service."
}
output "identity" {
  value       = azurerm_api_management.apim.identity
  description = "An `identity` block as defined below."
}
output "management_api_url" {
  value       = azurerm_api_management.apim.management_api_url
  description = "The URL for the Management API associated with this API Management service."
}
output "portal_url" {
  value       = azurerm_api_management.apim.portal_url
  description = "The URL for the Publisher Portal associated with this API Management service."
}
output "developer_portal_url" {
  value       = azurerm_api_management.apim.developer_portal_url
  description = "The URL for the Developer Portal associated with this API Management service."
}
output "public_ip_addresses" {
  value       = azurerm_api_management.apim.public_ip_addresses
  description = "The Public IP addresses of the API Management Service."
}
output "private_ip_addresses" {
  value       = azurerm_api_management.apim.private_ip_addresses
  description = "The Private IP addresses of the API Management Service."
}
output "scm_url" {
  value       = azurerm_api_management.apim.scm_url
  description = "The URL for the SCM (Source Code Management) Endpoint associated with this API Management service."
}
output "tenant_access" {
  value       = azurerm_api_management.apim.tenant_access
  description = "The `tenant_access` block as documented below."
}
output "name" {
  value       = azurerm_api_management.apim.name
  description = "The name of the API Management Service."
}
output "rbac_id" {
  value       = try(azurerm_api_management.apim.identity[0].principal_id, null)
  description = "The rbac_id of the API Management Service for role assignments."
}