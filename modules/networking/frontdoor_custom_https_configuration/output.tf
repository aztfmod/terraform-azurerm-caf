output "id" {
  value       = azurerm_frontdoor_custom_https_configuration.fdchc.id
  description = "The ID of the Azure Front Door Custom Https Configuration."
}
output "custom_https_configuration" {
  value       = azurerm_frontdoor_custom_https_configuration.fdchc.custom_https_configuration
  description = "A `custom_https_configuration` block as defined below."
}