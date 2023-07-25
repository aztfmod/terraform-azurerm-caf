output "id" {
  description = "The ID of the PowerBI Embedded."
  value       = azurerm_powerbi_embedded.powerbi.id
}

output "powerbi_embedded_name" {
  description = "The name of the PowerBI Embedded."
  value       = azurerm_powerbi_embedded.powerbi.name
}

output "powerbi_embedded_location" {
  description = "The location where the resource exists"
  value       = azurerm_powerbi_embedded.powerbi.location
}

output "powerbi_embedded_sku_name" {
  description = "The PowerBI Embedded's pricing level's SKU."
  value       = azurerm_powerbi_embedded.powerbi.sku_name
}

output "powerbi_embedded_administrators" {
  description = "The administrator user identities"
  value       = azurerm_powerbi_embedded.powerbi.administrators
}
