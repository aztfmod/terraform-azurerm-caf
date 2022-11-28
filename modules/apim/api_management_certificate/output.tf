output "id" {
  value       = azurerm_api_management_certificate.apim.id
  description = "The ID of the API Management Certificate."
}
output "expiration" {
  value       = azurerm_api_management_certificate.apim.expiration
  description = "The Expiration Date of this Certificate, formatted as an RFC3339 string."
}
output "subject" {
  value       = azurerm_api_management_certificate.apim.subject
  description = "The Subject of this Certificate."
}
output "thumbprint" {
  value       = azurerm_api_management_certificate.apim.thumbprint
  description = "The Thumbprint of this Certificate."
}
